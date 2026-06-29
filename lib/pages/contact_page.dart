part of './main_page.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 720;

    final cards = [
      _ContactCard(
        icon: 'assets/images/svg/ic_mail.svg',
        label: 'Email',
        value: AppText.email,
        onTap: () => OpenWeb.openURL('mailto:${AppText.email}'),
      ),
      _ContactCard(
        icon: 'assets/images/svg/ic_telephone.svg',
        label: 'Phone',
        value: AppText.phone,
        onTap: () => OpenWeb.openURL('tel:+84762449965'),
      ),
    ];

    return SectionShell(
      child: Column(
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.contactEyebrow,
              title: AppText.contactTitle,
              subtitle: AppText.contactDes,
            ),
          ),
          SizedBox(height: 48.h),
          Reveal(
            delayMs: 120,
            child: isNarrow
                ? Column(
                    children: [
                      cards[0],
                      SizedBox(height: 16.h),
                      cards[1],
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: cards[0]),
                      SizedBox(width: 16.w),
                      Expanded(child: cards[1]),
                    ],
                  ),
          ),
          SizedBox(height: 64.h),
          Reveal(
            delayMs: 240,
            child: Column(
              children: [
                Divider(color: Colors.white.withOpacity(0.08), height: 1),
                SizedBox(height: 24.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    Text(
                      '© 2026 Huynh Duy Khang',
                      style: TextStyleUtils.regular(14)
                          .copyWith(color: ColorUtils.textMuted),
                    ),
                    Text(
                      '· Built with Flutter',
                      style: TextStyleUtils.regular(14)
                          .copyWith(color: ColorUtils.textMuted),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIcon(
                      path: 'assets/images/png/ic_github.png',
                      tint: ColorUtils.textPrimary,
                      onTap: () =>
                          OpenWeb.openURL('https://github.com/DuyKhangIT'),
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
                      onTap: () => OpenWeb.openURL(
                          'https://www.facebook.com/duy.khang.155935/'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final String icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hover = false;
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.value));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // The whole card is tappable — tapping the email card opens the mail
    // client, the phone card the dialer (see onTap passed in).
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: GlassCard(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
          border: Border.all(
            color: Colors.white.withOpacity(_hover ? 0.18 : 0.08),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: ColorUtils.accentGradient,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: SvgPicture.asset(
                  widget.icon,
                  width: 22,
                  height: 22,
                  color: ColorUtils.ink,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyleUtils.medium(13)
                          .copyWith(color: ColorUtils.textMuted),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.value,
                      style: TextStyleUtils.semiBold(15)
                          .copyWith(color: ColorUtils.textPrimary),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: _copy,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    _copied ? Icons.check_rounded : Icons.copy_rounded,
                    size: 20,
                    color: _copied
                        ? ColorUtils.available
                        : ColorUtils.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
