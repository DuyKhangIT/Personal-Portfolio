import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../ultils/open_url.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/pill_button.dart';
import '../widgets/section_shell.dart';

/// The opening screen: an oversized wordmark over a blurred, full-width
/// avatar backdrop, flanked by the title block and social links.
class HeroSection extends StatelessWidget {
  /// Scrolls the page to the contact section.
  final VoidCallback onContact;

  const HeroSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const Positioned.fill(child: _HeroBackdrop()),
          SectionShell(
            padding: EdgeInsets.fromLTRB(
              SectionShell.gutterOf(context),
              isCompact ? 120 : 150,
              SectionShell.gutterOf(context),
              isCompact ? 64 : 96,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Wordmark(),
                SizedBox(height: isCompact ? 48 : 88),
                if (isCompact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _TitleBlock(),
                      const SizedBox(height: 28),
                      _CtaButton(onContact: onContact),
                      const SizedBox(height: 36),
                      const _SocialLinks(horizontal: true),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _TitleBlock(),
                            const SizedBox(height: 28),
                            _CtaButton(onContact: onContact),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      const _SocialLinks(horizontal: false),
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

/// The avatar, blown up full-width, heavily blurred and washed out under a
/// white veil so the ink wordmark reads cleanly on top. The veil deepens to
/// solid white at the bottom edge so the hero melts into the canvas below.
class _HeroBackdrop extends StatelessWidget {
  const _HeroBackdrop();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
            child: Image.asset(
              'assets/images/png/avt.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xD9FFFFFF),
                  Color(0xE6FFFFFF),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `DUY` outlined next to `KHANG` solid, on one line, scaled to the measure.
class _Wordmark extends StatelessWidget {
  const _Wordmark();

  @override
  Widget build(BuildContext context) {
    final style = EditorialType.heroDisplay(context);
    const profile = PortfolioData.profile;

    return RevealOnScroll(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _OutlineText(text: profile.heroOutline, style: style),
            SizedBox(width: style.fontSize! * 0.16),
            Text(profile.heroSolid, style: style, maxLines: 1),
          ],
        ),
      ),
    );
  }
}

/// Text drawn as a stroke only, matching the reference's outlined first line.
class _OutlineText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const _OutlineText({required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: style.copyWith(
        color: null,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = style.fontSize! * 0.012
          ..color = EditorialColors.ink,
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock();

  @override
  Widget build(BuildContext context) {
    const profile = PortfolioData.profile;
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(profile.title, style: EditorialType.rowTitle(context)),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Text(
              profile.tagline,
              style: EditorialType.bodyText(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final VoidCallback onContact;
  const _CtaButton({required this.onContact});

  @override
  Widget build(BuildContext context) {
    return RevealOnScroll(
      delay: EditorialMotion.staggerStep,
      child: Align(
        alignment: Alignment.centerLeft,
        child: PillButton(
          label: "Let's collaborate",
          filled: true,
          showArrow: true,
          onTap: onContact,
        ),
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  final bool horizontal;
  const _SocialLinks({required this.horizontal});

  @override
  Widget build(BuildContext context) {
    const profile = PortfolioData.profile;
    final links = <({String label, IconData icon, String url})>[
      (label: 'GitHub', icon: Icons.code_rounded, url: profile.github),
      (label: 'LinkedIn', icon: Icons.person_outline, url: profile.linkedin),
      (
        label: 'Email',
        icon: Icons.mail_outline_rounded,
        url: 'mailto:${profile.email}',
      ),
      (
        label: 'Phone',
        icon: Icons.phone_outlined,
        url: 'tel:${profile.phone.replaceAll(RegExp(r'[^0-9+]'), '')}',
      ),
    ];

    final children = <Widget>[
      for (final (index, link) in links.indexed)
        RevealOnScroll(
          delay: EditorialMotion.staggerStep * (index + 1),
          child: PillButton(
            label: link.label,
            trailingIcon: link.icon,
            onTap: () => OpenWeb.openURL(link.url),
          ),
        ),
    ];

    if (horizontal) {
      return Wrap(spacing: 10, runSpacing: 10, children: children);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final child in children)
          Padding(padding: const EdgeInsets.only(bottom: 10), child: child),
      ],
    );
  }
}
