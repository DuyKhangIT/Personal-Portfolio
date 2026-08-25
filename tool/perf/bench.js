(async () => {
  const view = document.querySelector('flutter-view');
  const nextFrame = () => new Promise(r => requestAnimationFrame(r));
  const sleep = ms => new Promise(r => setTimeout(r, ms));

  const wheel = dy => view.dispatchEvent(new WheelEvent('wheel', {
    deltaY: dy, deltaMode: 0, bubbles: true, cancelable: true,
    clientX: innerWidth / 2, clientY: innerHeight / 2
  }));

  const q = (xs, p) => xs.length ? +xs[Math.min(xs.length - 1, Math.floor(xs.length * p))].toFixed(2) : null;
  const avg = xs => xs.length ? +(xs.reduce((a, b) => a + b, 0) / xs.length).toFixed(2) : null;

  const readFrames = (start, end) =>
    JSON.parse(localStorage.getItem('PERFFRAMES') || '[]')
      .filter(f => f[0] >= start && f[0] <= end + 500);

  const summarise = (frames, rafDeltas, ms) => {
    const build = frames.map(f => f[1]).sort((a, b) => a - b);
    const raster = frames.map(f => f[2]).sort((a, b) => a - b);
    const rd = rafDeltas.slice().sort((a, b) => a - b);
    return {
      wallMs: ms,
      flutterFrames: frames.length,
      build: { avg: avg(build), p50: q(build, .5), p95: q(build, .95), max: q(build, 1) },
      raster: { avg: avg(raster), p50: q(raster, .5), p95: q(raster, .95), max: q(raster, 1) },
      over16ms: frames.filter(f => f[1] + f[2] > 16.67).length,
      over33ms: frames.filter(f => f[1] + f[2] > 33.3).length,
      rafFps: +(1000 / avg(rafDeltas)).toFixed(1),
      rafDelta: { avg: avg(rafDeltas), p50: q(rd, .5), p95: q(rd, .95), max: q(rd, 1) },
      rafOver32ms: rafDeltas.filter(d => d > 32).length,
      rafSamples: rafDeltas.length
    };
  };

  // Scrolls `steps` frames in `dir`, sampling rAF spacing throughout.
  const drive = async (steps, dy) => {
    const deltas = [];
    const start = Date.now();
    let last = performance.now();
    for (let i = 0; i < steps; i++) {
      wheel(dy);
      await nextFrame();
      const now = performance.now();
      deltas.push(now - last);
      last = now;
    }
    return { deltas, start, end: Date.now() };
  };

  const idleFramesBefore = JSON.parse(localStorage.getItem('PERFFRAMES') || '[]').length;
  const steadyOnly = window.__benchMode === 'steady';

  // --- Pass 1: the cold scroll a first-time visitor actually experiences.
  // Reveal animations fire as each section enters, so this is where the
  // blur/opacity/scale cost lands.
  let coldStats = null;
  if (!steadyOnly) {
    const cold = await drive(240, 45);
    await sleep(1400);
    coldStats = summarise(readFrames(cold.start, cold.end), cold.deltas, cold.end - cold.start);
  }

  // --- Pass 2: steady-state, everything already revealed.
  for (let i = 0; i < 120; i++) { wheel(-400); await nextFrame(); }
  await sleep(1200);

  const legs = [];
  const warmStart = Date.now();
  let warmDeltas = [];
  for (let leg = 0; leg < 4; leg++) {
    const r = await drive(90, 45 * (leg % 2 === 0 ? 1 : -1));
    warmDeltas = warmDeltas.concat(r.deltas);
    legs.push(r);
  }
  const warmEnd = Date.now();
  await sleep(1400);
  const warmStats = summarise(readFrames(warmStart, warmEnd), warmDeltas, warmEnd - warmStart);

  return {
    scrollDidMove: window.__scrollProof || null,
    idleFramesBefore,
    cold: coldStats,
    steady: warmStats
  };
})()
