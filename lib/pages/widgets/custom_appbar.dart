import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/pages/widgets/milk_ui.dart';

import '../../ultils/color_utils.dart';
import '../../ultils/text_style_utils.dart';
import 'download_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClickHome;
  final VoidCallback onClickAbout;
  final VoidCallback onClickSkill;
  final VoidCallback onClickExperience;
  final VoidCallback onClickContact;

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
    final isMobile = MediaQuery.of(context).size.width < 900;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.ink.withOpacity(0.55),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.07)),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: ColorUtils.textPrimary),
            titleSpacing: 0,
            // Single download CV button lives at the top-left, beside the
            // wordmark. The right side carries navigation only.
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.w : 64.w),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onClickHome,
                  child: GradientText(
                    'Duy Khang',
                    style:
                        TextStyleUtils.bold(24).copyWith(letterSpacing: -0.5),
                  ),
                ),
              ),
            ),
            actions: isMobile
                ? null
                : [
                    ActionTab(title: 'Home', onClick: onClickHome),
                    ActionTab(title: 'About', onClick: onClickAbout),
                    ActionTab(title: 'Skills', onClick: onClickSkill),
                    ActionTab(title: 'Experience', onClick: onClickExperience),
                    ActionTab(title: 'Contact', onClick: onClickContact),
                    SizedBox(width: 64.w),
                  ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72.0);
}

class ActionTab extends StatefulWidget {
  final String title;
  final VoidCallback onClick;

  const ActionTab({
    super.key,
    required this.title,
    required this.onClick,
  });

  @override
  State<ActionTab> createState() => _ActionTabState();
}

class _ActionTabState extends State<ActionTab> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: widget.onClick,
          child: Text(
            widget.title,
            style: TextStyleUtils.medium(15).copyWith(
              color: _hover ? ColorUtils.textPrimary : ColorUtils.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
