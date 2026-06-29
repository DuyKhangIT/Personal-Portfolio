import 'package:flutter/material.dart';

import '../ultils/color_utils.dart';
import '../ultils/text_style_utils.dart';

/// The site is dark-only (full Milkinside aesthetic).
ThemeData milkinsideTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorUtils.ink,
  canvasColor: ColorUtils.ink,
  primaryColor: ColorUtils.accentPink,
  fontFamily: TextStyleUtils.interRegular,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: ColorUtils.accentViolet.withOpacity(0.35),
    cursorColor: ColorUtils.accentPink,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: ColorUtils.textPrimary),
    titleTextStyle: TextStyleUtils.bold(24).copyWith(
      color: ColorUtils.textPrimary,
    ),
  ),
  colorScheme: const ColorScheme.dark(
    surface: ColorUtils.surface,
    primary: ColorUtils.accentPink,
    secondary: ColorUtils.accentViolet,
  ),
);

// Kept so existing references keep compiling; both map to the dark theme.
ThemeData darkTheme = milkinsideTheme;
ThemeData lightTheme = milkinsideTheme;
