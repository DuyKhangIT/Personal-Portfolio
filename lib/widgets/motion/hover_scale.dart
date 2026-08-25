import 'package:flutter/material.dart';

import '../../theme/editorial_motion.dart';

/// Motion pattern 5 — a card grows slightly under the pointer while an
/// [overlay] (the circular `↗` button) fades in over it.
///
/// On touch devices there is no hover, so the child simply renders at rest
/// and the overlay stays hidden; the tap target is the caller's concern.
class HoverScale extends StatefulWidget {
  final Widget child;

  /// Cross-faded in on hover, centred over [child].
  final Widget? overlay;

  final double scale;

  /// Called when the hover state changes, for callers that want to drive
  /// sibling widgets (a row highlight, say) from the same gesture.
  final ValueChanged<bool>? onHoverChanged;

  const HoverScale({
    super.key,
    required this.child,
    this.overlay,
    this.scale = 1.06,
    this.onHoverChanged,
  });

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hovered = false;

  void _setHovered(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
    widget.onHoverChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      // expand, so the child fills the box the caller sized (an AspectRatio,
      // say) instead of shrinking to its own content. The overlay is centred
      // separately so it keeps its intrinsic size.
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            // The scale animates on hover; its own boundary keeps those frames
            // from invalidating the whole section's repaint boundary.
            child: RepaintBoundary(
              child: AnimatedScale(
                scale: _hovered ? widget.scale : 1,
                duration: EditorialMotion.hoverDuration,
                curve: EditorialMotion.hoverCurve,
                child: widget.child,
              ),
            ),
          ),
          if (widget.overlay != null)
            IgnorePointer(
              child: Center(
                child: AnimatedOpacity(
                  opacity: _hovered ? 1 : 0,
                  duration: EditorialMotion.hoverDuration,
                  curve: EditorialMotion.hoverCurve,
                  child: AnimatedScale(
                    scale: _hovered ? 1 : 0.8,
                    duration: EditorialMotion.hoverDuration,
                    curve: EditorialMotion.hoverCurve,
                    child: widget.overlay,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
