#!/usr/bin/env python3
"""Drive the portfolio in a real Chrome over CDP and run the scroll benchmark.

The in-app browser pane reports document.hidden, which throttles
requestAnimationFrame to a crawl and makes frame timing meaningless. This
launches a dedicated Chrome with backgrounding disabled so the page renders at
full rate on the real GPU.

    drive.py <url> <label> [cpuThrottle] [full|steady]
"""
import asyncio
import base64
import json
import os
import shutil
import subprocess
import sys
import tempfile
import urllib.request

import websockets

CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
PORT = 9333
HERE = os.path.dirname(os.path.abspath(__file__))

SCROLL_JS = """(async () => {{
  const v = document.querySelector('flutter-view');
  const f = () => new Promise(r => requestAnimationFrame(r));
  for (let i = 0; i < {steps}; i++) {{
    v.dispatchEvent(new WheelEvent('wheel', {{deltaY: {dy}, deltaMode: 0,
      bubbles: true, cancelable: true,
      clientX: innerWidth / 2, clientY: innerHeight / 2}}));
    await f();
  }}
  await new Promise(r => setTimeout(r, 600));
  return 1;
}})()"""


def launch(profile_dir):
    args = [
        CHROME,
        f"--remote-debugging-port={PORT}",
        f"--user-data-dir={profile_dir}",
        "--no-first-run",
        "--no-default-browser-check",
        "--disable-background-timer-throttling",
        "--disable-backgrounding-occluded-windows",
        "--disable-renderer-backgrounding",
        "--disable-features=CalculateNativeWinOcclusion",
        "--window-size=1280,900",
        "--window-position=0,0",
        "about:blank",
    ]
    return subprocess.Popen(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


async def wait_for_devtools(timeout=25):
    for _ in range(timeout * 4):
        try:
            with urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/version", timeout=1):
                return True
        except Exception:
            await asyncio.sleep(0.25)
    return False


def page_target():
    with urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/list", timeout=5) as r:
        targets = json.load(r)
    pages = [t for t in targets if t.get("type") == "page"]
    return pages[0] if pages else None


class CDP:
    def __init__(self, ws):
        self.ws = ws
        self.n = 0

    async def send(self, method, params=None, timeout=300):
        self.n += 1
        mid = self.n
        await self.ws.send(json.dumps({"id": mid, "method": method, "params": params or {}}))
        while True:
            raw = await asyncio.wait_for(self.ws.recv(), timeout=timeout)
            msg = json.loads(raw)
            if msg.get("id") == mid:
                if "error" in msg:
                    raise RuntimeError(f"{method}: {msg['error']}")
                return msg.get("result", {})

    async def eval(self, expr, await_promise=False, timeout=300):
        res = await self.send(
            "Runtime.evaluate",
            {
                "expression": expr,
                "awaitPromise": await_promise,
                "returnByValue": True,
                "userGesture": True,
            },
            timeout=timeout,
        )
        if res.get("exceptionDetails"):
            raise RuntimeError(json.dumps(res["exceptionDetails"])[:800])
        return res.get("result", {}).get("value")


async def verify_scroll(cdp, label, url):
    """Prove the synthetic wheel events actually move the app before trusting
    any timing taken while dispatching them."""
    shot_a = (await cdp.send("Page.captureScreenshot", {"format": "png"}))["data"]
    await cdp.eval(SCROLL_JS.format(steps=80, dy=60), await_promise=True, timeout=90)
    shot_b = (await cdp.send("Page.captureScreenshot", {"format": "png"}))["data"]
    for name, data in (("before", shot_a), ("after", shot_b)):
        with open(os.path.join(HERE, f"scroll-{label}-{name}.png"), "wb") as fh:
            fh.write(base64.b64decode(data))
    # That scroll already fired the reveals, so reload for a genuinely cold page.
    await cdp.send("Page.navigate", {"url": url})
    await asyncio.sleep(7)
    return shot_a != shot_b


async def main():
    url = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:8987/"
    label = sys.argv[2] if len(sys.argv) > 2 else "run"
    # This Mac has far more headroom than a typical visitor's laptop; throttling
    # the CPU is how the real margin gets exposed.
    throttle = float(sys.argv[3]) if len(sys.argv) > 3 else 1.0
    # "steady" skips the cold pass and the scroll-proof reload — used for the
    # attribution matrix, where every config is pre-revealed anyway.
    mode = sys.argv[4] if len(sys.argv) > 4 else "full"

    profile = tempfile.mkdtemp(prefix="portfolio-bench-")
    proc = launch(profile)
    try:
        if not await wait_for_devtools():
            print("ERROR: devtools never came up", file=sys.stderr)
            return 1

        target = page_target()
        async with websockets.connect(
            target["webSocketDebuggerUrl"], max_size=64 * 1024 * 1024
        ) as ws:
            cdp = CDP(ws)
            await cdp.send("Page.enable")
            await cdp.send("Runtime.enable")
            await cdp.send("Network.enable")
            await cdp.send("Network.setCacheDisabled", {"cacheDisabled": True})

            if throttle > 1.0:
                await cdp.send("Emulation.setCPUThrottlingRate", {"rate": throttle})

            await cdp.send("Page.navigate", {"url": url})
            await asyncio.sleep(6)

            vis = await cdp.eval("document.visibilityState")
            ready = await cdp.eval("localStorage.getItem('PERFREADY')")
            print(f"[{label}] visibility={vis} probeReady={ready}", file=sys.stderr)
            if vis != "visible":
                print(f"[{label}] WARNING: not visible, timings unreliable", file=sys.stderr)

            moved = None
            if mode == "steady":
                await cdp.eval("window.__benchMode = 'steady'")
            else:
                moved = await verify_scroll(cdp, label, url)
                print(f"[{label}] scrollMovedPage={moved}", file=sys.stderr)

            with open(os.path.join(HERE, "bench.js")) as f:
                bench = f.read()

            result = await cdp.eval(bench, await_promise=True, timeout=300)
            print(json.dumps(
                {"label": label, "cpuThrottle": throttle, "mode": mode,
                 "scrollMovedPage": moved, **(result or {})}, indent=2))
    finally:
        proc.terminate()
        try:
            proc.wait(timeout=10)
        except Exception:
            proc.kill()
        shutil.rmtree(profile, ignore_errors=True)
    return 0


if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
