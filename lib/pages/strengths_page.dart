part of './main_page.dart';

class StrengthsPage extends StatelessWidget {
  const StrengthsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cols = width < 720 ? 1 : 2;

    return SectionShell(
      child: Column(
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.strengthsEyebrow,
              title: AppText.strengthsTitle,
            ),
          ),
          SizedBox(height: 56.h),
          Reveal(
            delayMs: 120,
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 20.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (cols - 1)) / cols;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final s in PortfolioData.strengths)
                      SizedBox(
                        width: cardWidth,
                        child: _StrengthCard(item: s),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StrengthCard extends StatelessWidget {
  final StrengthItem item;
  const _StrengthCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorUtils.accentPink.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: ColorUtils.accentPink.withOpacity(0.30)),
            ),
            child: Icon(item.icon, color: ColorUtils.accentPink, size: 26),
          ),
          SizedBox(height: 20.h),
          Text(
            item.title,
            style: TextStyleUtils.bold(20)
                .copyWith(color: ColorUtils.textPrimary),
          ),
          SizedBox(height: 12.h),
          Text(
            item.description,
            style: TextStyleUtils.regular(15).copyWith(
              color: ColorUtils.textSecondary,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}
