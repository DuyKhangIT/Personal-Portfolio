import 'package:flutter/material.dart';

import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  canvasColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle:
        TextStyleUtils.bold(26).copyWith(color: ColorUtils.blackDefault),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.grey.shade600,
  ),
  buttonTheme: const ButtonThemeData(buttonColor: ColorUtils.gray900),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black87),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      disabledBackgroundColor: ColorUtils.gray900,
      disabledForegroundColor: Colors.white,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: ColorUtils.blackDefault,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle:
        TextStyleUtils.bold(26).copyWith(color: ColorUtils.whiteDefault),
  ),
  scaffoldBackgroundColor: ColorUtils.blackDefault,
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFF9FAFB)),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      disabledBackgroundColor: Colors.white,
      disabledForegroundColor: Colors.white,
    ),
  ),
);
