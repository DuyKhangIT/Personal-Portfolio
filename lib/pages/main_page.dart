import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_portfolio/pages/widgets/custom_appbar.dart';
import 'package:personal_portfolio/pages/widgets/download_button.dart';
import 'package:personal_portfolio/ultils/open_url.dart';
import 'package:personal_portfolio/ultils/text_ultils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../core/blocs/setting_bloc/setting_bloc.dart';
import '../core/models/skill.dart';
import '../global/app_text.dart';
import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

part './home_page.dart';
part './about_page.dart';
part './contact_page.dart';
part './experience_page.dart';
part './skills_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ItemScrollController _scrollController = ItemScrollController();

  void _scrollToIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        onClickHome: () => _scrollToIndex(0),
        onClickAbout: () => _scrollToIndex(1),
        onClickSkill: () => _scrollToIndex(2),
        onClickExperience: () => _scrollToIndex(3),
        onClickContact: () => _scrollToIndex(4),
      ),
      endDrawer: (MediaQuery.of(context).size.width < 810)
          ? _customDrawer(screenHeight)
          : null,
      body: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemCount: 5,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const HomePage();
            case 1:
              return const AboutPage();
            case 2:
              return const SkillsPage();
            case 3:
              return const ExperiencePage();
            case 4:
              return const ContactPage();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _customDrawer(double screenHeight) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Drawer(
          elevation: 0,
          backgroundColor: state.themeMode == ThemeMode.dark
              ? ColorUtils.blackDefault
              : ColorUtils.whiteDefault,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextViewUtils.titleBold(
                      text: 'Duy Khang',
                      fontSize: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: state.themeMode == ThemeMode.dark
                            ? ColorUtils.whiteDefault
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
                height: 0.5,
              ),
              ListTile(
                title: TextViewUtils.titleBold(
                  text: 'About',
                  fontSize: 14,
                ),
                onTap: () {
                  _scrollToIndex(1);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: TextViewUtils.titleBold(
                  text: 'Skill',
                  fontSize: 14,
                ),
                onTap: () {
                  _scrollToIndex(2);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: TextViewUtils.titleBold(
                  text: 'Experience',
                  fontSize: 14,
                ),
                onTap: () {
                  _scrollToIndex(3);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: TextViewUtils.titleBold(
                  text: 'Contact',
                  fontSize: 14,
                ),
                onTap: () {
                  _scrollToIndex(4);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: TextViewUtils.titleBold(
                  text: 'Switch Theme',
                  fontSize: 14,
                ),
                trailing: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    if (state.themeMode == ThemeMode.system ||
                        state.themeMode == ThemeMode.light) {
                      context.read<SettingBloc>().add(
                            const SettingThemeModeChanged(
                              themeMode: ThemeMode.dark,
                            ),
                          );
                    } else {
                      context.read<SettingBloc>().add(
                            const SettingThemeModeChanged(
                              themeMode: ThemeMode.light,
                            ),
                          );
                    }
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorUtils.gray100,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: state.themeMode == ThemeMode.dark
                        ? SvgPicture.asset(
                            'assets/images/svg/ic_light_mode.svg',
                          )
                        : SvgPicture.asset(
                            'assets/images/svg/ic_dark_mode.svg',
                          ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100.w, top: 25.h),
                child: const DownloadButton(
                  buttonColor: ColorUtils.gray800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
