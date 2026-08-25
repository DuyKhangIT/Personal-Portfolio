import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../theme/editorial_motion.dart';

/// Motion pattern 1 — a section fades and scales into place the first time it
/// enters the viewport.
///
/// Pass a [delay] to stagger a list (pattern 3). The reveal fires once and
/// never plays again, so scrolling back up does not re-trigger it.
///
/// Two deliberate performance properties, both measured on a 6x-throttled CPU:
///
///  * There is no blur. An `ImageFiltered` blur over a whole section forces a
///    saveLayer and a filter pass every frame it animates, and with sections
///    staggered several run at once — it cost ~10fps and quadrupled dropped
///    frames on the first scroll down the page.
///  * Once the animation lands, the widget collapses to its child, dropping
///    the [VisibilityDetector] and the animation wrappers. Otherwise every
///    revealed section keeps a detector reporting for the life of the page.
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

  /// Set once the reveal has finished, after which this widget is transparent
  /// overhead and takes itself out of the tree.
  bool _settled = false;

  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_onStatus);
  }

  void _onStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || _settled) return;
    if (!mounted) return;
    setState(() => _settled = true);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < widget.threshold) return;
    _triggered = true;

    if (widget.delay == Duration.zero) {
      _controller.forward();
      return;
    }
    // Held so it can be cancelled — a staggered list scrolled past quickly
    // would otherwise leave timers running against disposed widgets.
    _delayTimer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_settled) return widget.child;

    return VisibilityDetector(
      key: ValueKey<int>(identityHashCode(this)),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final progress = _t.value;
          return Opacity(
            opacity: progress,
            child: Transform.scale(
              scale: EditorialMotion.revealScale +
                  (1 - EditorialMotion.revealScale) * progress,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
