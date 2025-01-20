import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleUtils {
  static String interRegular = "InterRegular";
  static String interMedium = "InterMedium";
  static String interSemiBold = "InterSemiBold";
  static String interBold = "InterBold";

  static TextStyle regular(double size) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size.sp,
        fontFamily: interRegular,
      );

  static TextStyle medium(double size) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: size.sp,
        fontFamily: interMedium,
      );
  static TextStyle semiBold(double size) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size.sp,
        fontFamily: interSemiBold,
      );

  static TextStyle bold(double size) => TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: size.sp,
        fontFamily: interBold,
      );
}
