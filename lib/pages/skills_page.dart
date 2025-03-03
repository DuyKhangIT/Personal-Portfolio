part of './main_page.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<Skill> listSkills = [
    Skill(
      iconPath: 'assets/images/svg/ic_flutter.svg',
      name: 'Flutter',
      url: 'https://flutter.dev/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_dart.svg',
      name: 'Dart',
      url: 'https://dart.dev/',
    ),
    Skill(
        iconPath: 'assets/images/svg/ic_kotlin.svg',
        name: 'Kotlin',
        url: 'https://kotlinlang.org/,'),
    Skill(
      iconPath: 'assets/images/svg/ic_java.svg',
      name: 'Java',
      url: 'https://www.java.com/en/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_nodejs.svg',
      name: 'Node JS',
      url: 'https://nodejs.org/en',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_mongo.svg',
      name: 'Mongo DB',
      url: 'https://www.mongodb.com/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_sql.svg',
      name: 'SQL Server',
      url: 'https://www.microsoft.com/en-us/sql-server',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_socket_io.svg',
      name: 'Socket io',
      url: 'https://socket.io/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_git.svg',
      name: 'Git',
      url: 'https://git-scm.com/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_android.svg',
      name: 'Android Studio',
      url: 'https://developer.android.com/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_vscode.svg',
      name: 'Visual Code',
      url: 'https://code.visualstudio.com/',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_jira.svg',
      name: 'Jira',
      url: 'https://www.atlassian.com/software/jira',
    ),
    Skill(
      iconPath: 'assets/images/svg/ic_rocketchat.svg',
      name: 'Rocket Chat',
      url: 'https://www.rocket.chat/',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 140.h, horizontal: 130.w),
      child: Column(
        children: [
          Center(
            child: TextViewUtils.titleBold(
              text: "Skills",
            ),
          ),
          SizedBox(height: 20.h),
          TextViewUtils.descriptionsRegular(
            text: "The skills, tools and technologies I am really good at:",
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.w),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 60.w,
              runSpacing: 60.w,
              runAlignment: WrapAlignment.center,
              children: [
                for (var item in listSkills)
                  SkillItem(
                    iconPath: item.iconPath,
                    name: item.name,
                    url: item.url,
                    isHover: false,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SkillItem extends StatefulWidget {
  final String iconPath;
  final String name;
  final String url;
  final bool isHover;
  const SkillItem({
    super.key,
    required this.iconPath,
    required this.name,
    required this.url,
    required this.isHover,
  });

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  bool isHover = false;
  @override
  void initState() {
    isHover = widget.isHover;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            OpenWeb.openURL(widget.url);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (v) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (v) {
              setState(() {
                isHover = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform: Matrix4.identity()..scale(isHover ? 1.2 : 1.0),
              child: SvgPicture.asset(
                widget.iconPath,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        TextViewUtils.descriptionsRegular(
          text: widget.name,
        ),
      ],
    );
  }
}
