import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:personal_portfolio/pages/widgets/custom_appbar.dart';

import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

part './home_page.dart';
part './about_page.dart';
part './contact_page.dart';
part './experience_page.dart';
part './projects_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  void _scrollToIndex(int index, double screenHeight) {
    _scrollController.animateTo(
      index * context.height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        onClickHome: () => _scrollToIndex(0, screenHeight),
        onClickAbout: () => _scrollToIndex(1, screenHeight),
        onClickExperience: () => _scrollToIndex(2, screenHeight),
        onClickProjects: () => _scrollToIndex(3, screenHeight),
        onClickContact: () => _scrollToIndex(4, screenHeight),
      ),
      body: ListView(
        controller: _scrollController,
        children: const [
          HomePage(),
          AboutPage(),
          ExperiencePage(),
          ProjectsPage(),
          ContactPage(),
        ],
      ),
    );
  }
}
