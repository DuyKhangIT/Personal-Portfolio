import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_type.dart';
import '../widgets/experience_row.dart';
import '../widgets/motion/cursor_preview.dart';
import '../widgets/motion/ghost_heading.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/section_shell.dart';

/// Motion pattern 6 — the page flips to the dark ground for this one section,
/// inset with a large corner radius so it reads as a slab on the canvas.
class ExperienceSection extends StatelessWidget {
  final double scrollOffset;
  const ExperienceSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    const palette = EditorialPalette.dark;
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    const experiences = PortfolioData.experiences;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 16 : 24),
      child: Container(
        decoration: BoxDecoration(
          color: EditorialColors.darkBg,
          borderRadius: BorderRadius.circular(isCompact ? 24 : 32),
        ),
        clipBehavior: Clip.antiAlias,
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
              CursorPreview(
                previewBuilder: (index) =>
                    ExperiencePreviewCard(item: experiences[index]),
                builder: (context, reportHover) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final (index, item) in experiences.indexed)
                      RevealOnScroll(
                        child: ExperienceRow(
                          item: item,
                          isLast: index == experiences.length - 1,
                          onEnter: () => reportHover(index),
                          onExit: () => reportHover(null),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
