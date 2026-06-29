part of './main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 920;

    final heroText = _HeroText(isNarrow: isNarrow);
    final heroVisual = const _HeroVisual();

    return SectionShell(
      verticalPadding: 0,
      child: Column(
        children: [
          SizedBox(height: isNarrow ? 130.h : 150.h),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: isNarrow ? 0 : -20,
                child: GhostWord('FLUTTER', fontSize: isNarrow ? 110 : 230),
              ),
              if (isNarrow)
                Reveal(
                  child: Column(
                    children: [
                      heroVisual,
                      SizedBox(height: 48.h),
                      heroText,
                    ],
                  ),
                )
              else
                Reveal(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: heroText),
                      SizedBox(width: 40.w),
                      Expanded(flex: 5, child: Center(child: heroVisual)),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 96.h),
          const Reveal(delayMs: 200, child: _StatsBand()),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isNarrow;
  const _HeroText({required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    final align = isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isNarrow ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppText.roleEyebrow.toUpperCase(),
          textAlign: textAlign,
          style: TextStyleUtils.semiBold(13).copyWith(
            color: ColorUtils.accentPink,
            letterSpacing: 3,
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isNarrow ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              "Hi, I'm Khang",
              style: TextStyleUtils.bold(52).copyWith(
                color: ColorUtils.textPrimary,
                height: 1.05,
                letterSpacing: -1.5,
              ),
            ),
            SizedBox(width: 12.w),
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Image.asset(
                'assets/images/gif/ic_hi.gif',
                width: 46,
                height: 46,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        GradientText(
          "Mobile Engineer & Flutter Expert",
          textAlign: textAlign,
          style: TextStyleUtils.bold(40).copyWith(
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 24.h),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            AppText.heroSummary,
            textAlign: textAlign,
            style: TextStyleUtils.regular(17).copyWith(
              color: ColorUtils.textSecondary,
              height: 1.65,
            ),
          ),
        ),
        SizedBox(height: 26.h),
        Wrap(
          alignment: isNarrow ? WrapAlignment.center : WrapAlignment.start,
          spacing: 14.w,
          runSpacing: 12.h,
          children: const [
            _LocationChip(),
            _AvailableChip(),
          ],
        ),
        SizedBox(height: 32.h),
        const DownloadButton(),
        SizedBox(height: 32.h),
        Row(
          mainAxisAlignment:
              isNarrow ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _SocialIcon(
              path: 'assets/images/png/ic_github.png',
              tint: ColorUtils.textPrimary,
              onTap: () => OpenWeb.openURL('https://github.com/DuyKhangIT'),
            ),
            SizedBox(width: 16.w),
            _SocialIcon(
              path: 'assets/images/png/ic_linkedin.png',
              onTap: () => OpenWeb.openURL(
                  'https://www.linkedin.com/in/khang-huynh-15b0b1248/'),
            ),
            SizedBox(width: 16.w),
            _SocialIcon(
              path: 'assets/images/png/ic_facebook.png',
              onTap: () =>
                  OpenWeb.openURL('https://www.facebook.com/duy.khang.155935/'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 420,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Floating gradient orb behind the photo.
          const Positioned(
            top: -10,
            right: 0,
            child: GradientOrb(size: 120),
          ),
          Positioned(
            bottom: 10,
            left: -6,
            child: GradientOrb(
              size: 70,
              colors: const [
                ColorUtils.accentCyan,
                ColorUtils.accentBlue,
                ColorUtils.accentViolet,
              ],
            ),
          ),
          // Glow behind the portrait.
          Container(
            width: 300,
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: ColorUtils.accentMagenta.withOpacity(0.35),
                  blurRadius: 70,
                  spreadRadius: -10,
                ),
                BoxShadow(
                  color: ColorUtils.accentViolet.withOpacity(0.30),
                  blurRadius: 90,
                  spreadRadius: -20,
                ),
              ],
            ),
          ),
          // Gradient ring frame + photo.
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              gradient: ColorUtils.brandGradient,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/png/avatars.png',
                width: 296,
                height: 356,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsBand extends StatelessWidget {
  const _StatsBand();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 720;
    final stats = const [
      StatTile(end: 3, suffix: '+', label: 'Years of\nexperience'),
      StatTile(end: 6, suffix: '+', label: 'Production apps\nshipped'),
      StatTile(end: 99.9, suffix: '%', decimals: 1, label: 'Crash-free\nsessions'),
      StatTile(end: 60, suffix: '%', label: 'Faster load\ntimes'),
    ];
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 34.h),
      child: isNarrow
          ? Wrap(
              alignment: WrapAlignment.center,
              spacing: 40.w,
              runSpacing: 28.h,
              children: stats,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < stats.length; i++) ...[
                  Expanded(child: stats[i]),
                  if (i != stats.length - 1)
                    Container(
                      width: 1,
                      height: 56,
                      color: Colors.white.withOpacity(0.08),
                    ),
                ],
              ],
            ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/svg/ic_location.svg',
            width: 16,
            height: 16,
            color: ColorUtils.textSecondary,
          ),
          SizedBox(width: 8.w),
          Text(
            AppText.address,
            style: TextStyleUtils.medium(14)
                .copyWith(color: ColorUtils.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AvailableChip extends StatelessWidget {
  const _AvailableChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorUtils.available.withOpacity(0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: ColorUtils.available.withOpacity(0.40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.available,
            ),
          ),
          SizedBox(width: 9.w),
          Text(
            AppText.available,
            style: TextStyleUtils.medium(14)
                .copyWith(color: ColorUtils.available),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String path;
  final VoidCallback onTap;

  /// Optional tint — used to brighten monochrome logos (e.g. GitHub) so
  /// they don't disappear against the dark background.
  final Color? tint;
  const _SocialIcon({required this.path, required this.onTap, this.tint});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(_hover ? 0.10 : 0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withOpacity(_hover ? 0.25 : 0.10),
            ),
          ),
          padding: const EdgeInsets.all(11),
          child: Image.asset(
            widget.path,
            color: widget.tint,
            colorBlendMode: widget.tint != null ? BlendMode.srcIn : null,
          ),
        ),
      ),
    );
  }
}
