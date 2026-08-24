import 'package:flutter/material.dart';

import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';

/// A small hairline tag. Used both as the work-section filter (where
/// [onTap] is supplied and [selected] toggles) and as a static tech tag.
class EditorialChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final EditorialPalette palette;

  const EditorialChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.palette = EditorialPalette.light,
  });

  @override
  State<EditorialChip> createState() => _EditorialChipState();
}

class _EditorialChipState extends State<EditorialChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final Color background;
    final Color foreground;

    if (widget.selected) {
      background = palette.ink;
      foreground = palette.bg;
    } else {
      background =
          _hovered ? palette.ink.withValues(alpha: 0.05) : Colors.transparent;
      foreground = palette.inkSoft;
    }

    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: EditorialMotion.hoverDuration,
          curve: EditorialMotion.hoverCurve,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: widget.selected ? palette.ink : palette.hairline,
            ),
          ),
          child: Text(
            widget.label,
            style: EditorialType.meta(context).copyWith(color: foreground),
          ),
        ),
      ),
    );
  }
}
