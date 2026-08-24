import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../ultils/open_url.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/pill_button.dart';
import '../widgets/section_shell.dart';

/// The portrait that rises from the base of the hero, threaded between the
/// wordmark above it and the title / social rail below it.
const String _portraitAsset = 'assets/images/png/hero_portrait.png';

/// The opening screen: an oversized wordmark with the portrait rising from the
/// centre of the section, the title block on the left and the social rail on
/// the right — layered so the figure reads in front of the name.
class HeroSection extends StatelessWidget {
  /// Scrolls the page to the contact section.
  final VoidCallback onContact;

  const HeroSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    return isCompact
        ? _CompactHero(onContact: onContact)
        : _WideHero(onContact: onContact);
  }
}

/// Desktop composition — three layers stacked over a fixed-height stage so the
/// figure sits in front of the wordmark and behind the title / social rail.
class _WideHero extends StatelessWidget {
  final VoidCallback onContact;
  const _WideHero({required this.onContact});

  /// Gap between the nav and the top of the wordmark.
  static const double _wordmarkTop = 128;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final stageHeight = size.height.clamp(700.0, 980.0);
    final gutter = SectionShell.gutterOf(context);
    // Centre the editorial measure once the viewport outgrows it.
    final sidePad = math.max(0.0, (size.width - SectionShell.maxWidth) / 2);

    // Start the figure below the letters so the head clears the wordmark
    // instead of cutting through it.
    final measure = size.width - sidePad * 2 - gutter * 2;
    final portraitTop =
        _wordmarkTop + _wordmarkHeight(context, measure) + 20;
    final portraitWidth = (size.width * 0.25).clamp(250.0, 350.0);

    return SizedBox(
      width: double.infinity,
      height: stageHeight,
      child: Stack(
        children: [
          // 1 — the wordmark, pinned to the top, behind the figure.
          _MeasureLayer(
            sidePad: sidePad,
            padding: EdgeInsets.fromLTRB(gutter, _wordmarkTop, gutter, 0),
            alignment: Alignment.topCenter,
            child: const SizedBox(width: double.infinity, child: _Wordmark()),
          ),
          // 2 — the portrait, rising from the base up to just under the name.
          Positioned(
            top: portraitTop,
            left: 0,
            right: 0,
            bottom: 0,
            child: _HeroPortrait(width: portraitWidth),
          ),
          // 3 — the title block and the social rail, in front of the figure.
          _MeasureLayer(
            sidePad: sidePad,
            padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 72),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _TitleBlock(),
                      const SizedBox(height: 28),
                      _CtaButton(onContact: onContact),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                const _SocialLinks(horizontal: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The height the wordmark actually paints at, once [FittedBox] has scaled it
/// down to fit [measure].
///
/// Measured rather than assumed: on a narrow desktop the row is scaled down,
/// so trusting the raw font size would leave the portrait floating in a gap.
double _wordmarkHeight(BuildContext context, double measure) {
  final style = EditorialType.heroDisplay(context);
  const profile = PortfolioData.profile;

  final naturalWidth = _textWidth(profile.heroOutline, style) +
      style.fontSize! * 0.16 +
      _textWidth(profile.heroSolid, style);
  final scale =
      measure <= 0 ? 1.0 : math.min(1.0, measure / naturalWidth);

  return style.fontSize! * style.height! * scale;
}

double _textWidth(String text, TextStyle style) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return painter.width;
}

/// One layer of the wide hero: fills the stage, centres the editorial measure,
/// then anchors its child to the top or bottom of that measure.
class _MeasureLayer extends StatelessWidget {
  final double sidePad;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;
  final Widget child;

  const _MeasureLayer({
    required this.sidePad,
    required this.padding,
    required this.alignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePad),
        child: Padding(
          padding: padding,
          child: Align(alignment: alignment, child: child),
        ),
      ),
    );
  }
}

/// Mobile composition — the same pieces stacked in a single column.
class _CompactHero extends StatelessWidget {
  final VoidCallback onContact;
  const _CompactHero({required this.onContact});

  @override
  Widget build(BuildContext context) {
    final gutter = SectionShell.gutterOf(context);
    return SectionShell(
      padding: EdgeInsets.fromLTRB(gutter, 116, gutter, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Wordmark(),
          const SizedBox(height: 32),
          const _HeroPortrait(width: 260, height: 340),
          const SizedBox(height: 36),
          const _TitleBlock(),
          const SizedBox(height: 28),
          _CtaButton(onContact: onContact),
          const SizedBox(height: 36),
          const _SocialLinks(horizontal: true),
        ],
      ),
    );
  }
}

/// The portrait, cropped to the top of the frame so the head reads, with its
/// base dissolved into the canvas so the figure appears to rise out of it.
class _HeroPortrait extends StatelessWidget {
  final double width;

  /// Null lets the figure fill whatever height the stage gives it — the wide
  /// hero sizes it by its top offset instead.
  final double? height;

  const _HeroPortrait({required this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height ?? double.infinity,
        child: RevealOnScroll(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRect(
                child: Image.asset(
                  _portraitAsset,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  filterQuality: FilterQuality.medium,
                ),
              ),
              // Melt the base of the figure into the canvas below.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00FFFFFF),
                      Color(0x00FFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                    stops: [0.0, 0.82, 1.0],
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final child in children)
          Padding(padding: const EdgeInsets.only(bottom: 10), child: child),
      ],
    );
  }
}
