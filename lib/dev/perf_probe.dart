import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Opt-in frame-timing probe, compiled out unless the build passes
/// `--dart-define=PERF_PROBE=true`.
///
/// It exists so scroll performance can be *measured* rather than guessed at.
/// Every frame's build and raster cost is recorded with a wall-clock stamp and
/// flushed to `localStorage.PERFFRAMES`; a harness drives a real wheel scroll,
/// notes the window it scrolled in, and reads back only the frames inside it.
/// Driving the scroll with wheel events rather than a [ScrollController] keeps
/// the measurement on the same path a visitor's mouse takes.
const bool kPerfProbe = bool.fromEnvironment('PERF_PROBE');

class PerfProbe {
  const PerfProbe._();

  /// `[wallClockMs, buildMs, rasterMs]` per frame, newest last.
  static final List<List<num>> _frames = <List<num>>[];
  static bool _flushScheduled = false;

  static void start() {
    if (!kPerfProbe) return;
    SchedulerBinding.instance.addTimingsCallback(_onTimings);
    html.window.localStorage['PERFREADY'] = '1';
  }

  static void _onTimings(List<FrameTiming> timings) {
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final t in timings) {
      _frames.add([
        now,
        t.buildDuration.inMicroseconds / 1000.0,
        t.rasterDuration.inMicroseconds / 1000.0,
      ]);
    }
    // Keep memory bounded — a long session should not grow without limit.
    if (_frames.length > 4000) {
      _frames.removeRange(0, _frames.length - 4000);
    }
    _scheduleFlush();
  }

  /// Serialising on every timings callback would itself distort the numbers,
  /// so the write is coalesced onto a short timer.
  static void _scheduleFlush() {
    if (_flushScheduled) return;
    _flushScheduled = true;
    Future<void>.delayed(const Duration(milliseconds: 400), () {
      _flushScheduled = false;
      html.window.localStorage['PERFFRAMES'] = jsonEncode(_frames);
    });
  }
}
