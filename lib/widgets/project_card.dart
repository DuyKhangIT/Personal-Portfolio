import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_type.dart';
import 'editorial_chip.dart';
import 'motion/hover_scale.dart';

/// One entry in the Selected Work grid.
///
/// No screenshots exist yet, so the cover is typographic: the project name
/// set large over a soft gradient, with the impact metric beneath. Supplying
/// `project.coverAsset` later swaps in the image without touching callers.
class ProjectCard extends StatelessWidget {
  final ProjectItem project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: HoverScale(
              overlay: const _ArrowBadge(),
              child: Hero(
                tag: 'project-${project.id}',
                child: ProjectCover(project: project),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(project.name, style: EditorialType.cardTitle(context)),
          const SizedBox(height: 4),
          Text(project.domain, style: EditorialType.bodyText(context)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tech in project.tech.take(3))
                EditorialChip(label: tech),
            ],
          ),
        ],
      ),
    );
  }
}

/// The card artwork, shared between the grid and the detail overlay so the
/// `Hero` transition has identical content on both ends.
class ProjectCover extends StatelessWidget {
  final ProjectItem project;
  const ProjectCover({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cover = project.coverAsset;
    if (cover != null) {
      return Image.asset(cover, fit: BoxFit.cover);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: EditorialColors.coverGradient,
        border: Border.all(color: EditorialColors.hairline),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryBadge(category: project.category),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              project.name,
              maxLines: 2,
              style: EditorialType.cardTitle(context).copyWith(
                fontSize: EditorialType.cardTitle(context).fontSize! * 1.9,
                fontWeight: FontWeight.w600,
                height: 1.05,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            project.impact,
            style: EditorialType.meta(context)
                .copyWith(color: EditorialColors.inkFaint),
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final ProjectCategory category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: EditorialColors.ink,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        category.label,
        style: EditorialType.meta(context).copyWith(
          color: EditorialColors.surface,
          fontSize: 10,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

/// The circular `↗` that fades in over a hovered cover.
class _ArrowBadge extends StatelessWidget {
  const _ArrowBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: EditorialColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.arrow_outward_rounded,
        size: 22,
        color: EditorialColors.ink,
      ),
    );
  }
}
