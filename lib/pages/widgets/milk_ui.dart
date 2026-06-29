import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ultils/color_utils.dart';
import '../../ultils/text_style_utils.dart';

/// Fixed, slowly drifting field of blurred gradient orbs that sits behind all
/// page content — the cinematic "ambient light" of the Milkinside look.
class AmbientBackground extends StatefulWidget {
  final Widget child;
  const AmbientBackground({super.key, required this.child});

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 26),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorUtils.ink,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          return Stack(
            children: [
              RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = _controller.value * 2 * math.pi;
                    return Stack(
                      children: [
                        _orb(
                          x: w * 0.05 + 40 * math.sin(t),
                          y: h * 0.02 + 30 * math.cos(t),
                          size: w * 0.45 + 120,
                          color: Colors.white,
                          opacity: 0.10,
                        ),
                        _orb(
                          x: w * 0.62 + 36 * math.cos(t),
                          y: -h * 0.12 + 26 * math.sin(t),
                          size: w * 0.5 + 120,
                          color: Colors.white,
                          opacity: 0.08,
                        ),
                        _orb(
                          x: w * 0.34 + 50 * math.sin(t + 1.6),
                          y: h * 0.55 + 40 * math.cos(t + 1.2),
                          size: w * 0.4 + 80,
                          color: Colors.white,
                          opacity: 0.05,
                        ),
                        _orb(
                          x: w * 0.78 + 30 * math.cos(t + 2.0),
                          y: h * 0.72 + 30 * math.sin(t + 0.8),
                          size: w * 0.35 + 80,
                          color: Colors.white,
                          opacity: 0.05,
                        ),
                      ],
                    );
                  },
                ),
              ),
              widget.child,
            ],
          );
        },
      ),
    );
  }

  Widget _orb({
    required double x,
    required double y,
    required double size,
    required Color color,
    required double opacity,
  }) {
    return Positioned(
      left: x - size / 2,
      top: y - size / 2,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withOpacity(opacity),
                color.withOpacity(0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A single decorative glossy gradient orb (the Milkinside "blob").
class GradientOrb extends StatefulWidget {
  final double size;
  final List<Color> colors;
  const GradientOrb({
    super.key,
    required this.size,
    this.colors = const [
      ColorUtils.accentOrange,
      ColorUtils.accentPink,
      ColorUtils.accentViolet,
      ColorUtils.accentCyan,
    ],
  });

  @override
  State<GradientOrb> createState() => _GradientOrbState();
}

class _GradientOrbState extends State<GradientOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(colors: [...widget.colors, widget.colors.first]),
          boxShadow: [
            BoxShadow(
              color: widget.colors.first.withOpacity(0.35),
              blurRadius: 60,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: widget.colors.last.withOpacity(0.30),
              blurRadius: 80,
              spreadRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

/// Frosted glass container with hairline border — the building block for cards.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Border? border;
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 22,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: ColorUtils.glassGradient,
            border: border ??
                Border.all(color: Colors.white.withOpacity(0.08), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Text painted with a gradient via a shader mask.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = ColorUtils.brandGradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

/// Fades + slides its child up the first time it is built (sections build as
/// they scroll into view, so this reads as a reveal-on-scroll).
class Reveal extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final double offsetY;
  const Reveal({
    super.key,
    required this.child,
    this.delayMs = 0,
    this.offsetY = 40,
  });

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Opacity(
          opacity: _anim.value,
          child: Transform.translate(
            offset: Offset(0, (1 - _anim.value) * widget.offsetY),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Eyebrow label + gradient/white title + optional subtitle, centered.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final center = alignment == CrossAxisAlignment.center;
    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Eyebrow(),
        SizedBox(height: 14.h),
        Text(
          eyebrow.toUpperCase(),
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: TextStyleUtils.semiBold(13).copyWith(
            color: ColorUtils.accentPink,
            letterSpacing: 3,
          ),
        ),
        SizedBox(height: 12.h),
        GradientText(
          title,
          textAlign: center ? TextAlign.center : TextAlign.start,
          gradient: const LinearGradient(
            colors: [ColorUtils.textPrimary, ColorUtils.textSecondary],
          ),
          style: TextStyleUtils.bold(44).copyWith(
            height: 1.05,
            letterSpacing: -1,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 18.h),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: TextStyleUtils.regular(17).copyWith(
                color: ColorUtils.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 4,
      decoration: BoxDecoration(
        gradient: ColorUtils.brandGradient,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

/// Pill button — filled (gradient) or outlined, with hover lift/glow.
class PillButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  final IconData? icon;
  const PillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = true,
    this.icon,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final filled = widget.filled;
    // Filled = solid white pill with black (ink) content — the primary,
    // high-contrast CTA. Outline = white hairline border + white content.
    final foreground = filled ? ColorUtils.ink : ColorUtils.textPrimary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hover ? -2 : 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: filled
                ? (_hover ? Colors.white : const Color(0xFFF2F2F4))
                : Colors.white.withOpacity(_hover ? 0.08 : 0.0),
            borderRadius: BorderRadius.circular(40),
            border: filled
                ? null
                : Border.all(color: Colors.white.withOpacity(0.28), width: 1.2),
            boxShadow: filled && _hover
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.28),
                      blurRadius: 28,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: foreground),
                SizedBox(width: 9.w),
              ],
              Text(
                widget.label,
                style: TextStyleUtils.semiBold(16).copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated count-up statistic.
class StatTile extends StatelessWidget {
  final double end;
  final String suffix;
  final String label;
  final int decimals;
  const StatTile({
    super.key,
    required this.end,
    required this.label,
    this.suffix = '',
    this.decimals = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: end),
          duration: const Duration(milliseconds: 1400),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return GradientText(
              '${value.toStringAsFixed(decimals)}$suffix',
              style: TextStyleUtils.bold(46).copyWith(letterSpacing: -1),
            );
          },
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyleUtils.medium(14).copyWith(
            color: ColorUtils.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

/// Centers section content, caps it at a comfortable reading width and adds
/// responsive horizontal + vertical breathing room.
class SectionShell extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double verticalPadding;
  const SectionShell({
    super.key,
    required this.child,
    this.maxWidth = 1180,
    this.verticalPadding = 110,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontal = width < 720 ? 24.0 : (width < 1024 ? 48.0 : 64.0);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: verticalPadding.h,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// A gradient-dot bullet line.
class BulletRow extends StatelessWidget {
  final String text;
  const BulletRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              gradient: ColorUtils.accentGradient,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyleUtils.regular(15).copyWith(
                color: ColorUtils.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Oversized outlined word that drifts slowly behind hero content — the
/// signature "ghost headline" of the Milkinside monochrome look.
class GhostWord extends StatefulWidget {
  final String text;
  final double fontSize;
  const GhostWord(this.text, {super.key, required this.fontSize});

  @override
  State<GhostWord> createState() => _GhostWordState();
}

class _GhostWordState extends State<GhostWord>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value * 2 * math.pi;
          return Transform.translate(
            offset: Offset(18 * math.sin(t), 6 * math.cos(t)),
            child: child,
          );
        },
        child: Text(
          widget.text,
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: TextStyleUtils.interBold,
            fontWeight: FontWeight.w800,
            fontSize: widget.fontSize,
            height: 1,
            letterSpacing: -2,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.6
              ..color = Colors.white.withOpacity(0.08),
          ),
        ),
      ),
    );
  }
}

/// Small glass pill used to list technologies.
class TechChip extends StatelessWidget {
  final String label;
  const TechChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Text(
        label,
        style: TextStyleUtils.medium(14).copyWith(
          color: ColorUtils.textSecondary,
        ),
      ),
    );
  }
}
