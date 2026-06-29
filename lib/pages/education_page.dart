part of './main_page.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 820;

    final education = GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardIcon(icon: Icons.school_rounded),
          SizedBox(height: 20.h),
          Text(
            "Bachelor of Software Engineering",
            style: TextStyleUtils.bold(20)
                .copyWith(color: ColorUtils.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            "Ho Chi Minh City University of Foreign Languages – "
            "Information Technology (HUFLIT)",
            style: TextStyleUtils.regular(15).copyWith(
              color: ColorUtils.textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 14.h),
          _HighlightTag(text: "GPA 8.0 / 10.0"),
        ],
      ),
    );

    final languages = GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardIcon(icon: Icons.translate_rounded),
          SizedBox(height: 20.h),
          Text(
            "English — Professional working proficiency",
            style: TextStyleUtils.bold(20)
                .copyWith(color: ColorUtils.textPrimary),
          ),
          SizedBox(height: 8.h),
          Text(
            "Comfortable reading technical docs, writing specs and "
            "collaborating with international teams.",
            style: TextStyleUtils.regular(15).copyWith(
              color: ColorUtils.textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            "Vietnamese — Native",
            style: TextStyleUtils.medium(15)
                .copyWith(color: ColorUtils.textSecondary),
          ),
        ],
      ),
    );

    return SectionShell(
      child: Column(
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.educationEyebrow,
              title: AppText.educationTitle,
            ),
          ),
          SizedBox(height: 56.h),
          Reveal(
            delayMs: 120,
            child: isNarrow
                ? Column(
                    children: [
                      education,
                      SizedBox(height: 20.h),
                      languages,
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: education),
                        SizedBox(width: 20.w),
                        Expanded(child: languages),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  final IconData icon;
  const _CardIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorUtils.accentPink.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ColorUtils.accentPink.withOpacity(0.30)),
      ),
      child: Icon(icon, color: ColorUtils.accentPink, size: 26),
    );
  }
}
