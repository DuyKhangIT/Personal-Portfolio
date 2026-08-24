import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_motion.dart';
import '../widgets/expertise_row.dart';
import '../widgets/motion/ghost_heading.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/section_shell.dart';

class ExpertiseSection extends StatelessWidget {
  final double scrollOffset;
  const ExpertiseSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GhostHeading(
            ghost: 'STRENGTH',
            label: '/EXPERTISE',
            scrollOffset: scrollOffset,
          ),
          const SizedBox(height: 40),
          for (final (index, item) in PortfolioData.expertise.indexed)
            RevealOnScroll(
              delay: EditorialMotion.staggerStep * index,
              child: ExpertiseRow(item: item),
            ),
        ],
      ),
    );
  }
}
