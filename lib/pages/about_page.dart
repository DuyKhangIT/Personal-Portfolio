part of './main_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 920;

    final paragraphs = [
      AppText.aboutOne,
      AppText.aboutTwo,
      AppText.aboutThree,
      AppText.aboutFour,
    ];

    final photo = _AboutPhoto();
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppText.aboutSubtitle,
          style: TextStyleUtils.semiBold(22)
              .copyWith(color: ColorUtils.textPrimary),
        ),
        SizedBox(height: 20.h),
        for (final p in paragraphs) ...[
          Text(
            p,
            style: TextStyleUtils.regular(16).copyWith(
              color: ColorUtils.textSecondary,
              height: 1.7,
            ),
          ),
          SizedBox(height: 18.h),
        ],
      ],
    );

    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.aboutEyebrow,
              title: AppText.aboutTitle,
              alignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(height: 56.h),
          if (isNarrow)
            Reveal(
              delayMs: 120,
              child: Column(
                children: [
                  Center(child: photo),
                  SizedBox(height: 40.h),
                  text,
                ],
              ),
            )
          else
            Reveal(
              delayMs: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  photo,
                  SizedBox(width: 56.w),
                  Expanded(child: text),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _AboutPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: ColorUtils.accentGradient,
        boxShadow: [
          BoxShadow(
            color: ColorUtils.accentViolet.withOpacity(0.30),
            blurRadius: 60,
            spreadRadius: -16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'assets/images/png/avt.png',
          width: 300,
          height: 360,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
