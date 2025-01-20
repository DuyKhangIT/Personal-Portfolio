import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ultils/color_utils.dart';
import 'package:personal_portfolio/ultils/text_style_utils.dart';

class DownloadButton extends StatefulWidget {
  final Color buttonColor;
  const DownloadButton({super.key, required this.buttonColor});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isHover = false;

  void _onHover(bool isHovered) {
    setState(() {
      isHover = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (v) => _onHover(true),
      onExit: (v) => _onHover(false),
      child: Container(
        height: 30.h,
        margin: EdgeInsets.only(right: 80.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isHover ? ColorUtils.gray600 : widget.buttonColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {},
          child: Text(
            'Download CV',
            style: TextStyleUtils.semiBold(12).copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
