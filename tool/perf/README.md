# Scroll performance harness

Measures how the site actually scrolls, so changes to the motion work can be
judged on numbers rather than on how the page feels on a fast Mac.

## Why it exists

The site renders at a locked 120fps on a recent Mac even when it is doing far
more work than it needs to, so a local "feels fine" proves nothing. The harness
throttles the CPU to stand in for an ordinary visitor's laptop, drives a
deterministic scroll, and reports build/raster times per frame.

## Running it

Build with the probe compiled in, serve, then drive it:

```bash
fvm flutter build web --release --dart-define=PERF_PROBE=true --no-wasm-dry-run
```

Serve `build/web` on port 8987 (the `portfolio-web` config in
`.claude/launch.json` does this), then:

```bash
python3 tool/perf/drive.py "http://localhost:8987/" mylabel 6 full
```

Arguments are `<url> <label> [cpuThrottle] [full|steady]`. `full` measures both
a cold first scroll (reveal animations firing) and a steady-state scroll;
`steady` skips the cold pass. A throttle of `6` is what the numbers below use.

Requires `python3 -m pip install websockets` and Google Chrome.

## How it works

- `lib/dev/perf_probe.dart` records every frame's build and raster duration and
  flushes them to `localStorage`. It is behind `bool.fromEnvironment` and is
  tree-shaken out of a normal build — verified by grepping `main.dart.js`.
- `drive.py` launches a throwaway Chrome with backgrounding disabled. This
  matters: a browser tab that reports `document.hidden` throttles
  `requestAnimationFrame`, and every frame timing taken in one is meaningless.
- `bench.js` dispatches wheel events and samples rAF spacing, then correlates
  that window against the frames the probe recorded.

## Baseline

Measured at 6x CPU throttle, 1280x900, release build, two runs averaged.

| | cold fps | steady fps | cold dropped frames |
|---|---|---|---|
| before the Aug 2026 pass | 33.9 | 44.3 | 90.5 |
| after | 51.2 | 55.7 | 11.5 |

The four changes that produced it, largest first:

1. **Dropped the blur from `RevealOnScroll`.** An `ImageFiltered` blur over a
   whole section forces a saveLayer and a filter pass on every frame it
   animates, and staggering means several run at once.
2. **Dropped the `BackdropFilter` from the nav.** It re-blurs the page beneath
   it on every scrolled frame. Lowering the sigma does not help — sigma 18, 8
   and 4 all measured the same; the cost is the readback, not the kernel.
3. **A `RepaintBoundary` per section**, plus one around the drifting ghost word
   and one around each hover-scaled card cover. Without the inner two, the
   moving parts re-dirty the section boundaries and cancel out the win.
4. **`RevealOnScroll` collapses to its child once it lands**, dropping its
   `VisibilityDetector` and animation wrappers instead of leaving ~30 detectors
   reporting for the life of the page.
