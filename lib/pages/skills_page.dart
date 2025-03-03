part of './main_page.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<Skill> listSkills = [
    Skill(iconPath: 'assets/images/svg/ic_flutter.svg', name: 'Flutter'),
    Skill(iconPath: 'assets/images/svg/ic_dart.svg', name: 'Dart'),
    Skill(iconPath: 'assets/images/svg/ic_kotlin.svg', name: 'Kotlin'),
    Skill(iconPath: 'assets/images/svg/ic_java.svg', name: 'Java'),
    Skill(iconPath: 'assets/images/svg/ic_nodejs.svg', name: 'Node JS'),
    Skill(iconPath: 'assets/images/svg/ic_mongo.svg', name: 'Mongo DB'),
    Skill(iconPath: 'assets/images/svg/ic_sql.svg', name: 'SQL Server'),
    Skill(iconPath: 'assets/images/svg/ic_socket_io.svg', name: 'Socket io'),
    Skill(iconPath: 'assets/images/svg/ic_git.svg', name: 'Git'),
    Skill(iconPath: 'assets/images/svg/ic_android.svg', name: 'Android Studio'),
    Skill(iconPath: 'assets/images/svg/ic_vscode.svg', name: 'Visual Code'),
    Skill(iconPath: 'assets/images/svg/ic_jira.svg', name: 'Jira'),
    Skill(iconPath: 'assets/images/svg/ic_rocketchat.svg', name: 'Rocket Chat'),
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
  final bool isHover;
  const SkillItem({
    super.key,
    required this.iconPath,
    required this.name,
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
        MouseRegion(
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
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()..scale(isHover ? 1.2 : 1.0),
            child: SvgPicture.asset(
              widget.iconPath,
              width: 50,
              height: 50,
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
