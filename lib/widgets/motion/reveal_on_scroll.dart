import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../theme/editorial_motion.dart';

/// Motion pattern 1 — a section blurs, fades and scales into place the first
/// time it enters the viewport.
///
/// Pass a [delay] to stagger a list (pattern 3). The reveal fires once and
/// never plays again, so scrolling back up does not re-trigger it.
class RevealOnScroll extends StatefulWidget {
  final Widget child;

  /// How long to wait after becoming visible before animating.
  final Duration delay;

  /// Fraction of the widget that must be on screen to trigger.
  final double threshold;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.threshold = 0.1,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: EditorialMotion.revealDuration,
  );

  late final Animation<double> _t = CurvedAnimation(
    parent: _controller,
    curve: EditorialMotion.revealCurve,
  );

  bool _triggered = false;
  Timer? _delayTimer;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < widget.threshold) return;
    _triggered = true;

    if (widget.delay == Duration.zero) {
      _controller.forward();
      return;
    }
    // Held so it can be cancelled — a staggered list scrolled past quickly
    // would otherwise leave timers running against disposed widgets.
    _delayTimer = Timer(widget.delay, _controller.forward);
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey<int>(identityHashCode(this)),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final progress = _t.value;
          final remaining = 1 - progress;
          return Opacity(
            opacity: progress,
            child: ImageFiltered(
              // A zero-sigma blur still costs a saveLayer, so switch the
              // filter off entirely once the reveal has landed.
              enabled: remaining > 0.001,
              imageFilter: ImageFilter.blur(
                sigmaX: EditorialMotion.revealBlur * remaining,
                sigmaY: EditorialMotion.revealBlur * remaining,
                tileMode: TileMode.decal,
              ),
              child: Transform.scale(
                scale: EditorialMotion.revealScale +
                    (1 - EditorialMotion.revealScale) * progress,
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
