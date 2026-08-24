import 'package:flutter/animation.dart';

/// Timing shared by every motion pattern lifted from the reference reel.
///
/// Sections read these rather than inlining durations, so the whole site can
/// be slowed down or sped up from one place.
class EditorialMotion {
  const EditorialMotion._();

  /// Pattern 1 — blur + fade + scale as a section enters the viewport.
  static const Duration revealDuration = Duration(milliseconds: 700);
  static const Curve revealCurve = Curves.easeOutCubic;

  /// Pattern 3 — per-item delay when a list reveals.
  static const Duration staggerStep = Duration(milliseconds: 80);

  /// Pattern 5 — card and row hover response.
  static const Duration hoverDuration = Duration(milliseconds: 260);
  static const Curve hoverCurve = Curves.easeOut;

  /// Pattern 7 — the project detail overlay, and nav scroll-to.
  static const Duration overlayDuration = Duration(milliseconds: 520);

  /// Pattern 4 — how far the follower card closes on the pointer each frame.
  static const double cursorLerp = 0.16;

  /// Blur applied at the start of a reveal, in logical pixels.
  static const double revealBlur = 12;

  /// Scale a section starts at before revealing.
  static const double revealScale = 0.96;
}
