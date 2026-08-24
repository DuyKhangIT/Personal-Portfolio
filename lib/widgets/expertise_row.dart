import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';

/// A full-width capability row: title on the left, `↗` on the right, with the
/// description expanding on hover.
///
/// Below 900px there is no hover, so the description is always shown.
class ExpertiseRow extends StatefulWidget {
  final ExpertiseItem item;
  const ExpertiseRow({super.key, required this.item});

  @override
  State<ExpertiseRow> createState() => _ExpertiseRowState();
}

class _ExpertiseRowState extends State<ExpertiseRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    final expanded = isCompact || _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: EditorialColors.hairline),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: EditorialType.rowTitle(context),
                  ),
                ),
                AnimatedSlide(
                  offset: _hovered ? const Offset(0.15, 0) : Offset.zero,
                  duration: EditorialMotion.hoverDuration,
                  curve: EditorialMotion.hoverCurve,
                  child: const Icon(
                    Icons.arrow_outward_rounded,
                    size: 22,
                    color: EditorialColors.ink,
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: EditorialMotion.hoverDuration,
              curve: EditorialMotion.hoverCurve,
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                height: expanded ? null : 0,
                child: expanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 14, right: 64),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: Text(
                            widget.item.description,
                            style: EditorialType.bodyText(context),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
