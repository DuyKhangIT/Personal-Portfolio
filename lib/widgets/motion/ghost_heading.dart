import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/editorial_colors.dart';
import '../../theme/editorial_type.dart';

/// Motion pattern 2 — an oversized, near-invisible word sits behind a small
/// `/LABEL`, drifting sideways as the page scrolls.
///
/// [scrollOffset] carries the page's raw pixel offset. It is a listenable
/// rather than a plain double so only the ghost word rebuilds as the page
/// moves — passing the value down would rebuild every section on every frame
/// of a scroll, which Flutter web cannot keep up with.
class GhostHeading extends StatelessWidget {
  /// The oversized background word, e.g. `PROJECTS`.
  final String ghost;

  /// The foreground label, including its leading slash, e.g. `/SELECTED WORK`.
  final String label;

  /// Null disables the parallax and pins the word in place.
  final ValueListenable<double>? scrollOffset;

  final EditorialPalette palette;

  /// Optional right-aligned content, e.g. `4+ years of experience`.
  final Widget? trailing;

  const GhostHeading({
    super.key,
    required this.ghost,
    required this.label,
    this.scrollOffset,
    this.palette = EditorialPalette.light,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final ghostStyle =
        EditorialType.ghost(context).copyWith(color: palette.ghost);
    final labelStyle =
        EditorialType.label(context).copyWith(color: palette.ink);

    final ghostSize = ghostStyle.fontSize!;

    final word = Text(
      ghost,
      style: ghostStyle,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.visible,
    );

    return SizedBox(
      height: ghostSize * 0.92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: -ghostSize * 0.05,
            child: scrollOffset == null
                ? word
                : ValueListenableBuilder<double>(
                    valueListenable: scrollOffset!,
                    // The word is the one thing in an otherwise static section
                    // that moves every frame. Its own boundary keeps that
                    // movement from invalidating the section's boundary and
                    // dragging the whole section into a repaint with it.
                    child: RepaintBoundary(child: word),
                    builder: (context, offset, child) {
                      // A slow drift, bounded so the word never wanders far
                      // enough to look detached from its label.
                      final parallax = (offset * 0.03).clamp(-48.0, 48.0);
                      return Transform.translate(
                        offset: Offset(parallax, 0),
                        child: child,
                      );
                    },
                  ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Expanded, not Flexible + Spacer: those two would each take
                // a share of the free space and park the trailing widget in
                // the middle instead of against the right edge.
                Expanded(child: Text(label, style: labelStyle)),
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 6),
                    child: trailing!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
