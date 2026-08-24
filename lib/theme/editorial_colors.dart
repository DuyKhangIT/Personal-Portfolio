import 'package:flutter/material.dart';

/// Flat color tokens for the editorial (light) design.
///
/// Sections that flip to the dark treatment read from [EditorialPalette]
/// instead of reaching for these directly, so a single widget tree can be
/// rendered on either ground.
class EditorialColors {
  const EditorialColors._();

  // ── Light ground ────────────────────────────────────────────────
  static const Color canvas = Color(0xFFF4F4F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF0A0A0A);
  static const Color inkSoft = Color(0xFF6B6B6B);
  static const Color inkFaint = Color(0xFF9A9A98);
  static const Color hairline = Color(0xFFE5E5E3);
  static const Color ghost = Color(0xFFEAEAE8);

  /// The "available for work" status dot.
  static const Color available = Color(0xFF22C55E);

  // ── Dark ground (the Experience section) ────────────────────────
  static const Color darkBg = Color(0xFF1B1B1B);
  static const Color darkGhost = Color(0xFF2A2A2A);
  static const Color darkInk = Color(0xFFFFFFFF);
  static const Color darkInkSoft = Color(0xFF8A8A88);

  /// Cover art for projects that have no screenshot yet.
  static const LinearGradient coverGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFAF9), Color(0xFFEFEFED)],
  );
}

/// The set of tokens a section needs to render on one ground.
///
/// Passing a palette down rather than a `bool isDark` keeps the branching in
/// one place and lets a widget be reused on either ground unchanged.
@immutable
class EditorialPalette {
  final Color bg;
  final Color surface;
  final Color ghost;
  final Color ink;
  final Color inkSoft;
  final Color inkFaint;
  final Color hairline;

  const EditorialPalette({
    required this.bg,
    required this.surface,
    required this.ghost,
    required this.ink,
    required this.inkSoft,
    required this.inkFaint,
    required this.hairline,
  });

  static const EditorialPalette light = EditorialPalette(
    bg: EditorialColors.canvas,
    surface: EditorialColors.surface,
    ghost: EditorialColors.ghost,
    ink: EditorialColors.ink,
    inkSoft: EditorialColors.inkSoft,
    inkFaint: EditorialColors.inkFaint,
    hairline: EditorialColors.hairline,
  );

  static const EditorialPalette dark = EditorialPalette(
    bg: EditorialColors.darkBg,
    surface: EditorialColors.surface,
    ghost: EditorialColors.darkGhost,
    ink: EditorialColors.darkInk,
    inkSoft: EditorialColors.darkInkSoft,
    inkFaint: EditorialColors.darkInkSoft,
    hairline: Color(0x2EFFFFFF),
  );

  bool get isDark => bg == EditorialColors.darkBg;
}
