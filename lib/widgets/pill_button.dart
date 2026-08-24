import 'package:flutter/material.dart';

import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';

/// The rounded control used everywhere in the reference design — nav items,
/// social links, calls to action.
///
/// [filled] paints it as the solid ink pill (`Let's Talk`, `Contact Me`);
/// otherwise it is a hairline outline on the section's ground.
class PillButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool filled;

  /// Defaults to the `↗` arrow when [showArrow] is true.
  final IconData? trailingIcon;
  final bool showArrow;

  /// Rendered before the label — the availability dot, a brand mark, an icon.
  final Widget? leading;

  final EditorialPalette palette;
  final bool dense;

  const PillButton({
    super.key,
    required this.label,
    this.onTap,
    this.filled = false,
    this.trailingIcon,
    this.showArrow = false,
    this.leading,
    this.palette = EditorialPalette.light,
    this.dense = false,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final foreground = widget.filled ? palette.bg : palette.ink;
    final background = widget.filled
        ? palette.ink
        : (_hovered ? palette.ink.withValues(alpha: 0.04) : Colors.transparent);

    final icon = widget.trailingIcon ??
        (widget.showArrow ? Icons.arrow_outward_rounded : null);

    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          offset: _hovered && widget.onTap != null
              ? const Offset(0, -0.06)
              : Offset.zero,
          duration: EditorialMotion.hoverDuration,
          curve: EditorialMotion.hoverCurve,
          child: AnimatedContainer(
            duration: EditorialMotion.hoverDuration,
            curve: EditorialMotion.hoverCurve,
            padding: EdgeInsets.symmetric(
              horizontal: widget.dense ? 12 : 18,
              vertical: widget.dense ? 7 : 12,
            ),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(999),
              border: widget.filled
                  ? null
                  : Border.all(color: palette.hairline, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: EditorialType.meta(context).copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, size: 14, color: foreground),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The `● Available for New Project` badge — a pill with a live status dot.
class AvailabilityBadge extends StatelessWidget {
  final EditorialPalette palette;
  const AvailabilityBadge({super.key, this.palette = EditorialPalette.light});

  @override
  Widget build(BuildContext context) {
    return PillButton(
      label: 'Available for New Project',
      dense: true,
      palette: palette,
      leading: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: EditorialColors.available,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
