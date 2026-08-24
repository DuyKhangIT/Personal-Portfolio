import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../ultils/download_file.dart';
import '../ultils/open_url.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/pill_button.dart';
import '../widgets/section_shell.dart';

/// The closing call to action, centred rather than left-aligned like the rest
/// of the page — the one place the editorial column breaks symmetry.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const String _cvAsset =
      'assets/images/pdf/HuynhDuyKhang_FlutterEngineer.pdf';
  static const String _cvFileName =
      'Huynh Duy Khang - Mobile Engineer (Flutter).pdf';

  @override
  Widget build(BuildContext context) {
    const profile = PortfolioData.profile;
    final labelStyle = EditorialType.label(context);

    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const RevealOnScroll(child: AvailabilityBadge()),
          const SizedBox(height: 28),
          RevealOnScroll(
            delay: EditorialMotion.staggerStep,
            child: Text(
              'HAVE A PROJECT IN MIND?',
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: labelStyle.fontSize! * 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          RevealOnScroll(
            delay: EditorialMotion.staggerStep * 2,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                'Open to mobile engineering roles and freelance work. '
                'If you are building something on Flutter, I would like to hear about it.',
                textAlign: TextAlign.center,
                style: EditorialType.bodyText(context),
              ),
            ),
          ),
          const SizedBox(height: 32),
          RevealOnScroll(
            delay: EditorialMotion.staggerStep * 3,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                PillButton(
                  label: 'Contact Me',
                  filled: true,
                  showArrow: true,
                  onTap: () => OpenWeb.openURL('mailto:${profile.email}'),
                ),
                PillButton(
                  label: 'Download CV',
                  trailingIcon: Icons.south_rounded,
                  onTap: () =>
                      DownloadFile.downloadPdf(_cvAsset, _cvFileName),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          RevealOnScroll(
            delay: EditorialMotion.staggerStep * 4,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                PillButton(
                  label: profile.fullName,
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/images/png/avt.png',
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                PillButton(
                  label: 'GitHub',
                  onTap: () => OpenWeb.openURL(profile.github),
                ),
                PillButton(
                  label: 'LinkedIn',
                  onTap: () => OpenWeb.openURL(profile.linkedin),
                ),
                PillButton(
                  label: profile.email,
                  onTap: () => OpenWeb.openURL('mailto:${profile.email}'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 56),
          Text(
            '${profile.location}  ·  © ${DateTime.now().year}',
            style: EditorialType.meta(context)
                .copyWith(color: EditorialColors.inkFaint),
          ),
        ],
      ),
    );
  }
}
