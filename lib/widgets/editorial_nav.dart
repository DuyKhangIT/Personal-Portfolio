import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/editorial_colors.dart';
import '../theme/editorial_motion.dart';
import '../theme/editorial_type.dart';
import 'pill_button.dart';

/// A destination in the floating nav.
class NavDestination {
  final String label;

  /// Rendered as a superscript count, e.g. `Work⁽⁶⁾`. Null hides it.
  final int? count;

  final VoidCallback onTap;

  const NavDestination({required this.label, required this.onTap, this.count});
}

/// The floating nav pill. Below 900px it collapses to the availability badge
/// plus a menu button, since the full row cannot fit.
class EditorialNav extends StatelessWidget {
  final List<NavDestination> destinations;
  final VoidCallback onTalk;
  final VoidCallback onMenu;

  const EditorialNav({
    super.key,
    required this.destinations,
    required this.onTalk,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 900;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 24,
        vertical: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: EditorialColors.surface.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: EditorialColors.hairline),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: isCompact
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AvailabilityBadge(),
                          IconButton(
                            onPressed: onMenu,
                            icon: const Icon(
                              Icons.menu_rounded,
                              color: EditorialColors.ink,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const AvailabilityBadge(),
                          const SizedBox(width: 24),
                          for (final destination in destinations)
                            _NavItem(destination: destination),
                          const Spacer(),
                          PillButton(
                            label: "Let's Talk",
                            filled: true,
                            showArrow: true,
                            onTap: onTalk,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final NavDestination destination;
  const _NavItem({required this.destination});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final metaStyle = EditorialType.meta(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.destination.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: EditorialMotion.hoverDuration,
            curve: EditorialMotion.hoverCurve,
            style: metaStyle.copyWith(
              color: _hovered ? EditorialColors.ink : EditorialColors.inkSoft,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.destination.label),
                if (widget.destination.count != null)
                  Transform.translate(
                    offset: const Offset(2, -5),
                    child: Text(
                      '${widget.destination.count}',
                      style: metaStyle.copyWith(
                        fontSize: 9,
                        color: EditorialColors.inkFaint,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
