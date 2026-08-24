import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_type.dart';
import '../widgets/experience_row.dart';
import '../widgets/motion/ghost_heading.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/section_shell.dart';

/// Motion pattern 6 — the page flips to the dark ground for this one section.
/// It bleeds edge to edge with no radius, so the flip reads as the page
/// itself changing rather than as a card laid on the canvas.
class ExperienceSection extends StatelessWidget {
  final ValueListenable<double>? scrollOffset;
  const ExperienceSection({super.key, this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    const palette = EditorialPalette.dark;
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    const experiences = PortfolioData.experiences;

    return Container(
      width: double.infinity,
      color: EditorialColors.darkBg,
      child: SectionShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GhostHeading(
              ghost: 'EXPERIENCE',
              label: '/EXPERIENCE',
              scrollOffset: scrollOffset,
              palette: palette,
              trailing: isCompact
                  ? null
                  : Text(
                      '${PortfolioData.profile.yearsExperience}+ years of experience',
                      style: EditorialType.bodyText(context)
                          .copyWith(color: palette.inkSoft),
                    ),
            ),
            const SizedBox(height: 40),
            for (final (index, item) in experiences.indexed)
              RevealOnScroll(
                child: ExperienceRow(
                  item: item,
                  isLast: index == experiences.length - 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
