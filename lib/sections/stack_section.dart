import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../widgets/editorial_chip.dart';
import '../widgets/motion/ghost_heading.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/section_shell.dart';

class StackSection extends StatelessWidget {
  final double scrollOffset;
  const StackSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GhostHeading(
            ghost: 'TECH',
            label: '/STACK',
            scrollOffset: scrollOffset,
          ),
          const SizedBox(height: 40),
          for (final (index, group) in PortfolioData.stack.indexed)
            RevealOnScroll(
              delay: EditorialMotion.staggerStep * index,
              child: _StackGroupRow(group: group),
            ),
        ],
      ),
    );
  }
}

class _StackGroupRow extends StatelessWidget {
  final StackGroup group;
  const _StackGroupRow({required this.group});

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    final titleStyle = EditorialType.rowTitle(context);
    final title = Text(
      group.title,
      style: titleStyle.copyWith(fontSize: titleStyle.fontSize! * 0.7),
    );
    final chips = Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [for (final item in group.items) EditorialChip(label: item)],
    );

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: EditorialColors.hairline)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: 16), chips],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 280, child: title),
                const SizedBox(width: 32),
                Expanded(child: chips),
              ],
            ),
    );
  }
}
