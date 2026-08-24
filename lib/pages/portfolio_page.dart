import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../overlays/project_detail_overlay.dart';
import '../sections/contact_section.dart';
import '../sections/experience_section.dart';
import '../sections/expertise_section.dart';
import '../sections/hero_section.dart';
import '../sections/stack_section.dart';
import '../sections/work_section.dart';
import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import '../widgets/editorial_nav.dart';

/// The whole site: one scrolling column with the nav floating above it.
///
/// A plain [ScrollController] rather than `ScrollablePositionedList`, because
/// the ghost headings need a raw pixel offset to derive their parallax from,
/// which an index-based list does not expose.
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _workKey = GlobalKey();
  final _expertiseKey = GlobalKey();
  final _stackKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() => _offset = _scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: EditorialMotion.overlayDuration,
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  void _openProject(ProjectItem project) {
    Navigator.of(context).push(projectDetailRoute(project));
  }

  List<NavDestination> get _destinations => [
        NavDestination(
          label: 'Work',
          count: PortfolioData.projects.length,
          onTap: () => _scrollTo(_workKey),
        ),
        NavDestination(
          label: 'Expertise',
          count: PortfolioData.expertise.length,
          onTap: () => _scrollTo(_expertiseKey),
        ),
        NavDestination(label: 'Stack', onTap: () => _scrollTo(_stackKey)),
        NavDestination(
          label: 'Experience',
          count: PortfolioData.experiences.length,
          onTap: () => _scrollTo(_experienceKey),
        ),
        NavDestination(label: 'Contact', onTap: () => _scrollTo(_contactKey)),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: EditorialColors.canvas,
      endDrawer: _buildDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(onContact: () => _scrollTo(_contactKey)),
                KeyedSubtree(
                  key: _workKey,
                  child: WorkSection(
                    scrollOffset: _offset,
                    onOpenProject: _openProject,
                  ),
                ),
                KeyedSubtree(
                  key: _expertiseKey,
                  child: ExpertiseSection(scrollOffset: _offset),
                ),
                KeyedSubtree(
                  key: _stackKey,
                  child: StackSection(scrollOffset: _offset),
                ),
                KeyedSubtree(
                  key: _experienceKey,
                  child: ExperienceSection(scrollOffset: _offset),
                ),
                KeyedSubtree(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: EditorialNav(
              destinations: _destinations,
              onTalk: () => _scrollTo(_contactKey),
              onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: EditorialColors.canvas,
      elevation: 0,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    PortfolioData.profile.fullName,
                    style: EditorialType.cardTitle(context),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: EditorialColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: EditorialColors.hairline, height: 1),
            for (final destination in _destinations)
              ListTile(
                title: Text(
                  destination.label,
                  style: EditorialType.rowTitle(context).copyWith(
                    fontSize: EditorialType.rowTitle(context).fontSize! * 0.7,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  destination.onTap();
                },
              ),
          ],
        ),
      ),
    );
  }
}
