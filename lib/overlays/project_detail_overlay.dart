import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../ultils/open_url.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/editorial_chip.dart';
import '../widgets/pill_button.dart';
import '../widgets/project_card.dart';
import '../widgets/section_shell.dart';

/// Motion pattern 7 — the project detail, pushed as a non-opaque route so the
/// page beneath stays mounted and the cover can `Hero` across.
Route<void> projectDetailRoute(ProjectItem project) {
  return PageRouteBuilder<void>(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: EditorialMotion.overlayDuration,
    reverseTransitionDuration: EditorialMotion.overlayDuration,
    pageBuilder: (_, __, ___) => ProjectDetailOverlay(project: project),
    transitionsBuilder: (context, animation, _, child) {
      final eased = CurvedAnimation(
        parent: animation,
        curve: EditorialMotion.revealCurve,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: eased,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.03),
            end: Offset.zero,
          ).animate(eased),
          child: child,
        ),
      );
    },
  );
}

class ProjectDetailOverlay extends StatelessWidget {
  final ProjectItem project;
  const ProjectDetailOverlay({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;

    return Scaffold(
      backgroundColor: EditorialColors.canvas,
      body: SingleChildScrollView(
        child: SectionShell(
          padding: EdgeInsets.fromLTRB(
            SectionShell.gutterOf(context),
            32,
            SectionShell.gutterOf(context),
            96,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(onBack: () => Navigator.of(context).pop()),
              const SizedBox(height: 56),
              if (isCompact)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Headline(project: project),
                    const SizedBox(height: 40),
                    _MetaColumn(project: project, alignEnd: false),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _Headline(project: project)),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 2,
                      child: _MetaColumn(project: project, alignEnd: true),
                    ),
                  ],
                ),
              const SizedBox(height: 64),
              AspectRatio(
                aspectRatio: isCompact ? 4 / 3 : 16 / 9,
                child: Hero(
                  tag: 'project-${project.id}',
                  child: ProjectCover(project: project),
                ),
              ),
              const SizedBox(height: 72),
              _Contributions(project: project),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PillButton(
        label: 'Back',
        trailingIcon: Icons.arrow_back_rounded,
        onTap: onBack,
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  final ProjectItem project;
  const _Headline({required this.project});

  @override
  Widget build(BuildContext context) {
    final labelStyle = EditorialType.label(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            EditorialChip(label: project.domain),
            EditorialChip(label: project.company),
          ],
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: labelStyle.copyWith(fontSize: labelStyle.fontSize! * 1.5),
            children: [
              TextSpan(text: project.name),
              TextSpan(
                text: '  /${project.category.filterLabel}',
                style: labelStyle.copyWith(
                  fontSize: labelStyle.fontSize! * 0.62,
                  color: EditorialColors.inkFaint,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            project.summary,
            style: EditorialType.bodyText(context),
          ),
        ),
        if (project.hasStoreLinks) ...[
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (project.playStoreUrl != null)
                PillButton(
                  label: 'Google Play',
                  filled: true,
                  showArrow: true,
                  onTap: () => OpenWeb.openURL(project.playStoreUrl!),
                ),
              if (project.appStoreUrl != null)
                PillButton(
                  label: 'App Store',
                  filled: true,
                  showArrow: true,
                  onTap: () => OpenWeb.openURL(project.appStoreUrl!),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _MetaColumn extends StatelessWidget {
  final ProjectItem project;
  final bool alignEnd;

  const _MetaColumn({required this.project, required this.alignEnd});

  @override
  Widget build(BuildContext context) {
    final rows = <({String label, String value})>[
      if (project.role != null) (label: 'Role', value: project.role!),
      (label: 'Timeline', value: project.period),
      (label: 'Team', value: project.teamSize),
      (label: 'Tech', value: project.tech.join(' · ')),
    ];

    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment:
                  alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: EditorialType.meta(context)
                      .copyWith(color: EditorialColors.inkFaint),
                ),
                const SizedBox(height: 6),
                Text(
                  row.value,
                  textAlign: alignEnd ? TextAlign.end : TextAlign.start,
                  style: EditorialType.bodyText(context)
                      .copyWith(color: EditorialColors.ink),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Contributions extends StatelessWidget {
  final ProjectItem project;
  const _Contributions({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('/CONTRIBUTIONS', style: EditorialType.label(context)),
        const SizedBox(height: 32),
        for (final (index, bullet) in project.bullets.indexed)
          RevealOnScroll(
            delay: EditorialMotion.staggerStep * index,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 16),
                    child: Text(
                      '↳',
                      style: EditorialType.bodyText(context)
                          .copyWith(color: EditorialColors.inkFaint),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: EditorialType.bodyText(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
