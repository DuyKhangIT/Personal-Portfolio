import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

ThemeData lightTheme = ThemeData(
  //fontFamily: 'Poppins',
  brightness: Brightness.light,
  primaryColor: Colors.black,
  cardColor: Colors.grey.shade100,
  dialogBackgroundColor: Colors.white,
  canvasColor: Colors.white,
  disabledColor: const Color(0xFF899099),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black87,
    foregroundColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: const Color(0xFFE5F4FC),
    titleTextStyle: TextStyleUtils.medium(18).copyWith(color: Colors.black87),
    iconTheme: const IconThemeData(color: Colors.black87),
    foregroundColor: const Color(0xFF022150),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: ColorUtils.mainColor,
    cursorColor: ColorUtils.mainColor,
    selectionHandleColor: ColorUtils.mainColor,
  ),
  scaffoldBackgroundColor: Colors.grey.shade100,
  iconTheme: IconThemeData(
    color: Colors.grey.shade600,
  ),
  buttonTheme: const ButtonThemeData(buttonColor: Colors.black87),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    unselectedItemColor: Color(0xFF9A9A9A),
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.black87),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyleUtils.regular(14).copyWith(
      color: Colors.grey.withOpacity(0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.redAccent.withOpacity(0.5),
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      disabledBackgroundColor: ColorUtils.grey,
      disabledForegroundColor: Colors.white,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  //fontFamily: 'Poppins',
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  disabledColor: const Color(0xFF899099),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorUtils.mainColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white70),
    foregroundColor: ColorUtils.mainColor,
  ),
  dialogBackgroundColor: const Color(0xFF373A45),
  cardColor: const Color(0xFF373A45),
  canvasColor: const Color(0xFF373A45),
  scaffoldBackgroundColor: Colors.grey.shade900,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    unselectedItemColor: Colors.white,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: ColorUtils.mainColor,
    cursorColor: ColorUtils.mainColor,
    selectionHandleColor: ColorUtils.mainColor,
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black.withOpacity(0.4),
    hintStyle: TextStyleUtils.regular(14).copyWith(
      color: Colors.grey.withOpacity(0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.redAccent.withOpacity(0.5),
        width: 1,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      disabledBackgroundColor: ColorUtils.grey,
      disabledForegroundColor: Colors.black54,
    ),
  ),
);
