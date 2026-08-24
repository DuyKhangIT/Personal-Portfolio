import 'package:flutter/material.dart';

import 'editorial_colors.dart';

/// The typographic scale for the editorial design.
///
/// Display type is Geist, body copy stays on Inter. Every size interpolates
/// on viewport width between [_minWidth] and [_maxWidth], so a heading that
/// reads at 160px on a wide desktop lands at 64px on a phone without a pile
/// of breakpoint branches at the call site.
class EditorialType {
  const EditorialType._();

  static const String display = 'Geist';
  static const String body = 'InterRegular';

  static const double _minWidth = 900;
  static const double _maxWidth = 1440;

  /// Linearly interpolates between [min] and [max] across the breakpoints,
  /// clamping outside them.
  static double scale(double width, {required double min, required double max}) {
    final t = ((width - _minWidth) / (_maxWidth - _minWidth)).clamp(0.0, 1.0);
    return min + (max - min) * t;
  }

  static double _w(BuildContext context) => MediaQuery.sizeOf(context).width;

  /// The hero wordmark — `HUYNH` / `DUY KHANG`.
  static TextStyle heroDisplay(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 52, max: 160),
        fontWeight: FontWeight.w700,
        letterSpacing: scale(_w(context), min: 52, max: 160) * -0.04,
        height: 0.90,
        color: EditorialColors.ink,
      );

  /// The oversized word sitting behind a section label.
  static TextStyle ghost(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 72, max: 220),
        fontWeight: FontWeight.w700,
        letterSpacing: scale(_w(context), min: 72, max: 220) * -0.03,
        height: 1.0,
        color: EditorialColors.ghost,
      );

  /// A section label such as `/SELECTED WORK`.
  static TextStyle label(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 26, max: 44),
        fontWeight: FontWeight.w600,
        letterSpacing: scale(_w(context), min: 26, max: 44) * -0.02,
        height: 1.05,
        color: EditorialColors.ink,
      );

  /// Full-width list rows — expertise and experience.
  static TextStyle rowTitle(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 22, max: 40),
        fontWeight: FontWeight.w500,
        letterSpacing: scale(_w(context), min: 22, max: 40) * -0.02,
        height: 1.1,
        color: EditorialColors.ink,
      );

  static TextStyle cardTitle(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 17, max: 22),
        fontWeight: FontWeight.w500,
        letterSpacing: scale(_w(context), min: 17, max: 22) * -0.01,
        height: 1.25,
        color: EditorialColors.ink,
      );

  static TextStyle bodyText(BuildContext context) => TextStyle(
        fontFamily: body,
        fontSize: scale(_w(context), min: 14, max: 16),
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: EditorialColors.inkSoft,
      );

  /// Chips, nav items, meta labels.
  static TextStyle meta(BuildContext context) => TextStyle(
        fontFamily: display,
        fontSize: scale(_w(context), min: 12, max: 13),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.26,
        height: 1.2,
        color: EditorialColors.inkSoft,
      );
}
