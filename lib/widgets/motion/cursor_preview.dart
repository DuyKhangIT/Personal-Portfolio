import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../theme/editorial_motion.dart';

/// Motion pattern 4 — hovering a list row floats a tilted preview card that
/// chases the pointer.
///
/// The rows themselves report which one is under the pointer by calling the
/// `reportHover` callback handed to [builder]; this widget owns the pointer
/// position and the easing. Below 900px there is no pointer, so it degrades
/// to rendering [builder]'s output alone.
class CursorPreview extends StatefulWidget {
  /// Builds the list. `reportHover` takes the hovered row index, or null.
  final Widget Function(BuildContext context, ValueChanged<int?> reportHover)
      builder;

  /// Builds the floating preview for a row. Return null to show nothing.
  final Widget? Function(int index) previewBuilder;

  /// Size of the floating card, used to centre it on the pointer.
  final Size previewSize;

  const CursorPreview({
    super.key,
    required this.builder,
    required this.previewBuilder,
    this.previewSize = const Size(220, 140),
  });

  @override
  State<CursorPreview> createState() => _CursorPreviewState();
}

class _CursorPreviewState extends State<CursorPreview>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker(_onTick)..start();

  int? _index;
  Offset _target = Offset.zero;
  Offset _rendered = Offset.zero;

  void _onTick(Duration _) {
    if (_index == null) return;
    final next = Offset.lerp(_rendered, _target, EditorialMotion.cursorLerp)!;
    // Below half a pixel the movement is invisible; stop rebuilding.
    if ((next - _rendered).distance < 0.5) return;
    setState(() => _rendered = next);
  }

  void _reportHover(int? index) {
    if (_index == index) return;
    setState(() => _index = index);
  }

  void _onPointerMove(Offset local) {
    _target = local;
    // On the first frame of a hover, snap so the card does not fly in from
    // the top-left corner.
    if (_index != null && _rendered == Offset.zero) {
      setState(() => _rendered = local);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    if (isCompact) {
      return widget.builder(context, (_) {});
    }

    final index = _index;
    final preview = index == null ? null : widget.previewBuilder(index);

    return MouseRegion(
      onHover: (event) => _onPointerMove(event.localPosition),
      onExit: (_) {
        setState(() {
          _index = null;
          _rendered = Offset.zero;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          widget.builder(context, _reportHover),
          if (preview != null)
            Positioned(
              left: _rendered.dx - widget.previewSize.width / 2,
              top: _rendered.dy - widget.previewSize.height / 2,
              width: widget.previewSize.width,
              height: widget.previewSize.height,
              child: IgnorePointer(
                child: Transform.rotate(
                  angle: -0.105, // ≈ -6°
                  child: preview,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
