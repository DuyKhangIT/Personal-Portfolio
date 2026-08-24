import 'package:flutter/material.dart';

import '../../theme/editorial_colors.dart';
import '../../theme/editorial_type.dart';

/// Motion pattern 2 — an oversized, near-invisible word sits behind a small
/// `/LABEL`, drifting sideways as the page scrolls.
///
/// [scrollOffset] is the raw pixel offset of the page scroll controller; the
/// parallax is derived from it so every heading on the page moves together.
class GhostHeading extends StatelessWidget {
  /// The oversized background word, e.g. `PROJECTS`.
  final String ghost;

  /// The foreground label, including its leading slash, e.g. `/SELECTED WORK`.
  final String label;

  final double scrollOffset;
  final EditorialPalette palette;

  /// Optional right-aligned content, e.g. `4+ years of experience`.
  final Widget? trailing;

  const GhostHeading({
    super.key,
    required this.ghost,
    required this.label,
    this.scrollOffset = 0,
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
    // A slow drift — a fraction of the scroll distance, bounded so the word
    // never wanders far enough to look detached from its label.
    final parallax = (scrollOffset * 0.03).clamp(-48.0, 48.0);

    return SizedBox(
      height: ghostSize * 0.92,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: -ghostSize * 0.05 + parallax,
            child: Text(
              ghost,
              style: ghostStyle,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.visible,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: Text(label, style: labelStyle)),
                if (trailing != null) ...[
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: trailing!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
