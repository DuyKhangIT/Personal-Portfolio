import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../ultils/color_utils.dart';

List<BottomNavigationBarItem> bottomNavBar(Color? color) {
  double width = 25;
  double height = 25;
  Color colorActive = ColorUtils.whiteDefault;
  return [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/ic_home.svg',
        color: color,
        width: width,
        height: height,
      ),
      label: '',
      activeIcon: SvgPicture.asset(
        'assets/images/ic_home.svg',
        color: colorActive,
        width: width,
        height: height,
      ),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/ic_plus.svg',
        color: color,
        width: 30,
        height: 30,
      ),
      label: '',
      activeIcon: SvgPicture.asset(
        'assets/images/ic_plus.svg',
        color: colorActive,
        width: 30,
        height: 30,
      ),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/ic_profile.svg',
        color: color,
        width: width,
        height: height,
      ),
      label: '',
      activeIcon: SvgPicture.asset(
        'assets/images/ic_profile.svg',
        color: colorActive,
        width: width,
        height: height,
      ),
    ),
  ];
}
