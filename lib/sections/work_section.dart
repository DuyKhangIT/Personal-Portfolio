import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/editorial_motion.dart';
import '../ultils/open_url.dart';
import '../widgets/editorial_chip.dart';
import '../widgets/motion/ghost_heading.dart';
import '../widgets/motion/reveal_on_scroll.dart';
import '../widgets/pill_button.dart';
import '../widgets/project_card.dart';
import '../widgets/section_shell.dart';

/// Returns the projects matching [category], or all of them when it is null.
///
/// Pulled out of the widget so the filtering rule can be tested without a
/// widget binding.
List<ProjectItem> filterProjects(
  List<ProjectItem> all,
  ProjectCategory? category,
) {
  if (category == null) return all;
  return all.where((p) => p.category == category).toList();
}

class WorkSection extends StatefulWidget {
  final double scrollOffset;
  final ValueChanged<ProjectItem> onOpenProject;

  const WorkSection({
    super.key,
    required this.onOpenProject,
    this.scrollOffset = 0,
  });

  @override
  State<WorkSection> createState() => _WorkSectionState();
}

class _WorkSectionState extends State<WorkSection> {
  ProjectCategory? _category;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 900;
    final projects = filterProjects(PortfolioData.projects, _category);

    // Two columns above the breakpoint, one below. The gutter is subtracted
    // before halving so the cards meet the section measure exactly.
    const columnGap = 32.0;
    final available =
        (width.clamp(0, SectionShell.maxWidth) - SectionShell.gutterOf(context) * 2)
            .toDouble();
    final cardWidth =
        isCompact ? available : (available - columnGap) / 2;

    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GhostHeading(
            ghost: 'PROJECTS',
            label: '/SELECTED WORK',
            scrollOffset: widget.scrollOffset,
          ),
          const SizedBox(height: 32),
          _FilterBar(
            selected: _category,
            onChanged: (value) => setState(() => _category = value),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: columnGap,
            runSpacing: 56,
            children: [
              for (final (index, project) in projects.indexed)
                SizedBox(
                  width: cardWidth,
                  child: RevealOnScroll(
                    // Re-key on the filter so a newly shown card animates in
                    // rather than appearing already revealed.
                    key: ValueKey('${_category?.name ?? 'all'}-${project.id}'),
                    delay: EditorialMotion.staggerStep * index,
                    child: ProjectCard(
                      project: project,
                      onTap: () => widget.onOpenProject(project),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final ProjectCategory? selected;
  final ValueChanged<ProjectCategory?> onChanged;

  const _FilterBar({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              EditorialChip(
                label: 'All',
                selected: selected == null,
                onTap: () => onChanged(null),
              ),
              for (final category in ProjectCategory.values)
                EditorialChip(
                  label: category.filterLabel,
                  selected: selected == category,
                  onTap: () => onChanged(category),
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        PillButton(
          label: 'GitHub',
          showArrow: true,
          onTap: () => OpenWeb.openURL(PortfolioData.profile.github),
        ),
      ],
    );
  }
}
