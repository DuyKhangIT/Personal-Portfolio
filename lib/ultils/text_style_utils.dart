import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleUtils {
  static const fontFamily = "Inter";
  static TextStyle regular(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        fontSize: size.sp,
      );

  static TextStyle medium(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        fontSize: size.sp,
      );
  static TextStyle semiBold(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        fontSize: size.sp,
      );

  static TextStyle bold(double size) => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        fontSize: size.sp,
      );
}
