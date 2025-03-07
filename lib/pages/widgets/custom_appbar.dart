import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/blocs/setting_bloc/setting_bloc.dart';
import '../../ultils/color_utils.dart';
import '../../ultils/text_style_utils.dart';
import 'download_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onClickHome;
  final Function() onClickAbout;
  final Function() onClickSkill;
  final Function() onClickExperience;
  final Function() onClickContact;

  const CustomAppBar({
    super.key,
    required this.onClickHome,
    required this.onClickAbout,
    required this.onClickSkill,
    required this.onClickExperience,
    required this.onClickContact,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 95.w),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onClickHome,
                child: const Text('Duy Khang'),
              ),
            ),
          ),
          actions: (MediaQuery.of(context).size.width < 810)
              ? null
              : [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ActionTab(
                        title: 'Home',
                        onClick: onClickHome,
                      ),
                      ActionTab(
                        title: 'About',
                        onClick: onClickAbout,
                      ),
                      ActionTab(
                        title: 'Skill',
                        onClick: onClickSkill,
                      ),
                      ActionTab(
                        title: 'Experience',
                        onClick: onClickExperience,
                      ),
                      ActionTab(
                        title: 'Contact',
                        onClick: onClickContact,
                      ),
                      SizedBox(
                        height: 25.h,
                        child: const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: ColorUtils.gray300,
                        ),
                      ),
                      BlocBuilder<SettingBloc, SettingState>(
                        builder: (context, state) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
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
                          );
                        },
                      ),
                      const DownloadButton(
                        buttonColor: ColorUtils.gray700,
                      ),
                    ],
                  ),
                ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class ActionTab extends StatefulWidget {
  final String title;
  final Function() onClick;

  const ActionTab({
    super.key,
    required this.title,
    required this.onClick,
  });

  @override
  State<ActionTab> createState() => _ActionTabState();
}

class _ActionTabState extends State<ActionTab> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (_) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (_) {
              setState(() {
                isHover = false;
              });
            },
            child: GestureDetector(
              onTap: widget.onClick,
              child: Text(
                widget.title,
                style: TextStyleUtils.medium(16).copyWith(
                  color: isHover
                      ? state.themeMode == ThemeMode.dark
                          ? ColorUtils.whiteDefault
                          : ColorUtils.gray900
                      : state.themeMode == ThemeMode.dark
                          ? ColorUtils.gray300
                          : ColorUtils.gray500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShowTopBarMenu extends StatefulWidget {
  final Function() onClickHome;
  final Function() onClickAbout;
  final Function() onClickExperience;
  final Function() onClickContact;
  const ShowTopBarMenu({
    super.key,
    required this.onClickHome,
    required this.onClickAbout,
    required this.onClickExperience,
    required this.onClickContact,
  });

  @override
  State<ShowTopBarMenu> createState() => _ShowTopBarMenuState();
}

class _ShowTopBarMenuState extends State<ShowTopBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionTab(
          title: 'Home',
          onClick: widget.onClickHome,
        ),
        ActionTab(
          title: 'About',
          onClick: widget.onClickAbout,
        ),
        ActionTab(
          title: 'Experience',
          onClick: widget.onClickExperience,
        ),
        ActionTab(
          title: 'Contact',
          onClick: widget.onClickContact,
        ),
        SizedBox(
          height: 25.h,
          child: const VerticalDivider(
            width: 1,
            thickness: 1,
            color: ColorUtils.gray300,
          ),
        ),
        BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
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
            );
          },
        ),
        const DownloadButton(
          buttonColor: ColorUtils.gray700,
        ),
      ],
    );
  }
}
