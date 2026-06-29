part of './main_page.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  static final List<Skill> _coreTech = [
    Skill(iconPath: 'assets/images/svg/ic_flutter.svg', name: 'Flutter', url: 'https://flutter.dev/'),
    Skill(iconPath: 'assets/images/svg/ic_dart.svg', name: 'Dart', url: 'https://dart.dev/'),
    Skill(iconPath: 'assets/images/svg/ic_kotlin.svg', name: 'Kotlin', url: 'https://kotlinlang.org/'),
    Skill(iconPath: 'assets/images/svg/ic_java.svg', name: 'Java', url: 'https://www.java.com/en/'),
    Skill(iconPath: 'assets/images/svg/ic_nodejs.svg', name: 'Node JS', url: 'https://nodejs.org/en'),
    Skill(iconPath: 'assets/images/svg/ic_mongo.svg', name: 'Mongo DB', url: 'https://www.mongodb.com/'),
    Skill(iconPath: 'assets/images/svg/ic_sql.svg', name: 'SQL Server', url: 'https://www.microsoft.com/en-us/sql-server'),
    Skill(iconPath: 'assets/images/svg/ic_socket_io.svg', name: 'Socket.IO', url: 'https://socket.io/'),
    Skill(iconPath: 'assets/images/svg/ic_git.svg', name: 'Git', url: 'https://git-scm.com/'),
    Skill(iconPath: 'assets/images/svg/ic_android.svg', name: 'Android Studio', url: 'https://developer.android.com/'),
    Skill(iconPath: 'assets/images/svg/ic_vscode.svg', name: 'VS Code', url: 'https://code.visualstudio.com/'),
    Skill(iconPath: 'assets/images/svg/ic_jira.svg', name: 'Jira', url: 'https://www.atlassian.com/software/jira'),
    Skill(iconPath: 'assets/images/svg/ic_rocketchat.svg', name: 'Rocket Chat', url: 'https://www.rocket.chat/'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final categoryCols = width < 720 ? 1 : (width < 1024 ? 2 : 3);

    return SectionShell(
      child: Column(
        children: [
          Reveal(
            child: SectionHeader(
              eyebrow: AppText.skillsEyebrow,
              title: AppText.skillsTitle,
              subtitle: AppText.skillsSubtitle,
            ),
          ),
          SizedBox(height: 56.h),
          Reveal(
            delayMs: 120,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 44.w,
              runSpacing: 36.h,
              children: [
                for (final s in _coreTech) SkillItem(skill: s),
              ],
            ),
          ),
          SizedBox(height: 64.h),
          Reveal(
            delayMs: 200,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final spacing = 20.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (categoryCols - 1)) /
                        categoryCols;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final c in PortfolioData.skillCategories)
                      SizedBox(
                        width: cardWidth,
                        child: _SkillCategoryCard(category: c),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;
  const _SkillCategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.title,
            style: TextStyleUtils.semiBold(17)
                .copyWith(color: ColorUtils.textPrimary),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final item in category.items) TechChip(label: item),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillItem extends StatefulWidget {
  final Skill skill;
  const SkillItem({super.key, required this.skill});

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => OpenWeb.openURL(widget.skill.url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              transform: Matrix4.identity()..scale(_hover ? 1.15 : 1.0),
              transformAlignment: Alignment.center,
              child: SvgPicture.asset(
                widget.skill.iconPath,
                width: 48,
                height: 48,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget.skill.name,
              style: TextStyleUtils.medium(13).copyWith(
                color: _hover
                    ? ColorUtils.textPrimary
                    : ColorUtils.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
