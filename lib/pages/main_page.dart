import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_portfolio/pages/widgets/custom_appbar.dart';
import 'package:personal_portfolio/pages/widgets/download_button.dart';
import 'package:personal_portfolio/pages/widgets/milk_ui.dart';
import 'package:personal_portfolio/ultils/open_url.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../core/models/skill.dart';
import '../global/app_text.dart';
import '../global/portfolio_data.dart';
import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

part './home_page.dart';
part './about_page.dart';
part './skills_page.dart';
part './experience_page.dart';
part './strengths_page.dart';
part './education_page.dart';
part './contact_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ItemScrollController _scrollController = ItemScrollController();

  // Section indices used by the navigation bar / drawer.
  static const int _home = 0;
  static const int _about = 1;
  static const int _skills = 2;
  static const int _experience = 3;
  static const int _contact = 6;

  late final List<Widget> _sections = const [
    HomePage(),
    AboutPage(),
    SkillsPage(),
    ExperiencePage(),
    StrengthsPage(),
    EducationPage(),
    ContactPage(),
  ];

  void _scrollToIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      backgroundColor: ColorUtils.ink,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onClickHome: () => _scrollToIndex(_home),
        onClickAbout: () => _scrollToIndex(_about),
        onClickSkill: () => _scrollToIndex(_skills),
        onClickExperience: () => _scrollToIndex(_experience),
        onClickContact: () => _scrollToIndex(_contact),
      ),
      endDrawer: isMobile ? _buildDrawer() : null,
      body: AmbientBackground(
        child: ScrollablePositionedList.builder(
          itemScrollController: _scrollController,
          itemCount: _sections.length,
          itemBuilder: (context, index) => _sections[index],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    final items = <String, int>{
      'Home': _home,
      'About': _about,
      'Skills': _skills,
      'Experience': _experience,
      'Contact': _contact,
    };
    return Drawer(
      elevation: 0,
      backgroundColor: ColorUtils.ink2,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(
                    'Duy Khang',
                    style: TextStyleUtils.bold(24),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: ColorUtils.textPrimary),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.08), height: 1),
            ...items.entries.map(
              (e) => ListTile(
                title: Text(
                  e.key,
                  style: TextStyleUtils.semiBold(16)
                      .copyWith(color: ColorUtils.textSecondary),
                ),
                onTap: () {
                  _scrollToIndex(e.value);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
