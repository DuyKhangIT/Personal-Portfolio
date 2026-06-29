part of './main_page.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      child: Column(
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.experienceEyebrow,
              title: AppText.experienceTitle,
              subtitle: AppText.experienceSubtitle,
            ),
          ),
          SizedBox(height: 56.h),
          for (int i = 0; i < PortfolioData.experiences.length; i++) ...[
            Reveal(
              delayMs: 120 + i * 80,
              child: _ExperienceCard(item: PortfolioData.experiences[i]),
            ),
            if (i != PortfolioData.experiences.length - 1)
              SizedBox(height: 26.h),
          ],
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceItem item;
  const _ExperienceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 720;
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company header.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: ColorUtils.accentGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.company.substring(0, 1),
                  style:
                      TextStyleUtils.bold(20).copyWith(color: ColorUtils.ink),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.company,
                      style: TextStyleUtils.bold(22)
                          .copyWith(color: ColorUtils.textPrimary),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item.role,
                      style: TextStyleUtils.medium(15)
                          .copyWith(color: ColorUtils.accentPink),
                    ),
                  ],
                ),
              ),
              if (!isNarrow)
                Text(
                  item.period,
                  style: TextStyleUtils.medium(14)
                      .copyWith(color: ColorUtils.textMuted),
                ),
            ],
          ),
          if (isNarrow) ...[
            SizedBox(height: 12.h),
            Text(
              item.period,
              style: TextStyleUtils.medium(14)
                  .copyWith(color: ColorUtils.textMuted),
            ),
          ],
          SizedBox(height: 22.h),
          Divider(color: Colors.white.withOpacity(0.07), height: 1),
          SizedBox(height: 22.h),
          for (int i = 0; i < item.projects.length; i++) ...[
            _ProjectBlock(project: item.projects[i]),
            if (i != item.projects.length - 1) SizedBox(height: 24.h),
          ],
        ],
      ),
    );
  }
}

class _ProjectBlock extends StatelessWidget {
  final ProjectItem project;
  const _ProjectBlock({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12.w,
          runSpacing: 8.h,
          children: [
            Text(
              project.name,
              style: TextStyleUtils.semiBold(18)
                  .copyWith(color: ColorUtils.textPrimary),
            ),
            Text(
              project.domain,
              style: TextStyleUtils.regular(14)
                  .copyWith(color: ColorUtils.textMuted),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _HighlightTag(text: project.highlight),
        SizedBox(height: 16.h),
        for (final b in project.bullets) BulletRow(text: b),
      ],
    );
  }
}

class _HighlightTag extends StatelessWidget {
  final String text;
  const _HighlightTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorUtils.accentPink.withOpacity(0.18),
            ColorUtils.accentViolet.withOpacity(0.18),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorUtils.accentPink.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_up_rounded,
              size: 16, color: ColorUtils.accentPink),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              text,
              style: TextStyleUtils.semiBold(13)
                  .copyWith(color: ColorUtils.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
