import 'package:flutter/material.dart';

class ColorUtils {
  static const Color whiteDefault = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color blackDefault = Color(0xFF1A1A1A);
  static const Color green500 = Color(0xFF10B981);

  // ── Monochrome (black & white) palette ────────────────────────
  // Milkinside-style: a near-black canvas, white type, and a silver
  // gradient ramp. Every "accent" token below is collapsed to grayscale
  // so the whole UI reads black & white without touching call sites.

  /// Page background — near-black.
  static const Color ink = Color(0xFF0A0A0B);
  static const Color ink2 = Color(0xFF101012);

  /// Glass surfaces / cards.
  static const Color surface = Color(0xFF141416);

  /// Hairline borders (white at low opacity baked into a const).
  static const Color hairline = Color(0x14FFFFFF);

  /// Text ramp on dark.
  static const Color textPrimary = Color(0xFFF7F7F8);
  static const Color textSecondary = Color(0xFFA6A6AE);
  static const Color textMuted = Color(0xFF6A6A72);

  /// Former rainbow accents, now grayscale. Kept as named tokens so the
  /// ambient orbs and accent surfaces still vary subtly (white → silver).
  static const Color accentOrange = Color(0xFFEDEDF0);
  static const Color accentPink = Color(0xFFE9E9EE);
  static const Color accentMagenta = Color(0xFFFFFFFF);
  static const Color accentViolet = Color(0xFFC4C4CC);
  static const Color accentBlue = Color(0xFF9A9AA3);
  static const Color accentCyan = Color(0xFFDADAE0);

  static const Color available = Color(0xFFF2F2F4);

  /// The hero / headline gradient — white fading to silver/graphite.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFC8C8CF),
      Color(0xFF8C8C95),
    ],
  );

  /// A softer two-stop gradient for accent chips, rings and underlines.
  /// White → silver; place dark (ink) content on top of it.
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFCBCBD2)],
  );

  /// Subtle surface gradient used by glass cards.
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x0FFFFFFF), Color(0x05FFFFFF)],
  );
}
