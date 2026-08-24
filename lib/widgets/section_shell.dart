import 'package:flutter/material.dart';

/// The measure and vertical rhythm every section shares.
///
/// Keeping this in one widget is what makes the page read as a single
/// editorial column rather than a stack of independently padded blocks.
class SectionShell extends StatelessWidget {
  final Widget child;

  /// Overrides the default vertical padding — used by the hero, which sits
  /// tighter under the nav.
  final EdgeInsets? padding;

  static const double maxWidth = 1280;

  const SectionShell({super.key, required this.child, this.padding});

  /// Horizontal gutter for the current width.
  static double gutterOf(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 900 ? 24 : 64;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: gutterOf(context),
                vertical: isCompact ? 72 : 120,
              ),
          child: child,
        ),
      ),
    );
  }
}
