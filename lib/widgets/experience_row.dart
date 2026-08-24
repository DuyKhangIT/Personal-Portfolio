import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';

/// One role in the dark Experience list.
///
/// It reports its own hover state upward so [CursorPreview] can float the
/// matching company card; it does not own the preview itself.
class ExperienceRow extends StatefulWidget {
  final ExperienceItem item;
  final bool isLast;
  final VoidCallback onEnter;
  final VoidCallback onExit;

  const ExperienceRow({
    super.key,
    required this.item,
    required this.onEnter,
    required this.onExit,
    this.isLast = false,
  });

  @override
  State<ExperienceRow> createState() => _ExperienceRowState();
}

class _ExperienceRowState extends State<ExperienceRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const palette = EditorialPalette.dark;
    final isCompact = MediaQuery.sizeOf(context).width < 900;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        widget.onEnter();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        widget.onExit();
      },
      child: AnimatedOpacity(
        // The hovered row comes to full strength; the rest sit slightly back.
        opacity: _hovered ? 1 : 0.82,
        duration: EditorialMotion.hoverDuration,
        curve: EditorialMotion.hoverCurve,
        child: Container(
          decoration: BoxDecoration(
            border: widget.isLast
                ? null
                : Border(bottom: BorderSide(color: palette.hairline)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Identity(item: widget.item),
                    const SizedBox(height: 10),
                    Text(
                      widget.item.period,
                      style: EditorialType.bodyText(context)
                          .copyWith(color: palette.inkSoft),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _Identity(item: widget.item)),
                    Text(
                      widget.item.period,
                      style: EditorialType.bodyText(context)
                          .copyWith(color: palette.inkSoft),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  final ExperienceItem item;
  const _Identity({required this.item});

  @override
  Widget build(BuildContext context) {
    const palette = EditorialPalette.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.company,
          style: EditorialType.rowTitle(context).copyWith(color: palette.ink),
        ),
        const SizedBox(height: 6),
        Text(
          item.role,
          style:
              EditorialType.bodyText(context).copyWith(color: palette.inkSoft),
        ),
      ],
    );
  }
}

/// The tilted card that chases the pointer over the Experience list.
class ExperiencePreviewCard extends StatelessWidget {
  final ExperienceItem item;
  const ExperiencePreviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final logo = item.logoAsset;

    return Container(
      decoration: BoxDecoration(
        color: EditorialColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: logo != null
            ? Image.asset(logo, fit: BoxFit.contain)
            : Text(
                item.monogram,
                style: EditorialType.heroDisplay(context).copyWith(
                  fontSize: 72,
                  color: EditorialColors.ink,
                ),
              ),
      ),
    );
  }
}
