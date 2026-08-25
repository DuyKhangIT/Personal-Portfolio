import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
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
///
/// The pill is opaque rather than frosted. A `BackdropFilter` here has to read
/// back and re-blur the page beneath it on every scrolled frame, which measured
/// as the largest steady-state scroll cost on the site — ~10fps, and dropped
/// frames going from 7 to 32 over a six-second scroll. Lowering the blur sigma
/// does not help: the cost is the readback, not the kernel width. A soft shadow
/// carries the "floating above the page" read instead.
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

    final bar = Container(
      decoration: BoxDecoration(
        color: EditorialColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: EditorialColors.hairline),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: isCompact
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    PortfolioData.profile.heroSolid,
                    style: EditorialType.meta(context).copyWith(
                      color: EditorialColors.ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                const SizedBox(width: 8),
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
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 24,
        vertical: 16,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          // No ClipRRect: the pill already rounds itself, and clipping would
          // cut off the shadow that replaces the frosted edge.
          child: RepaintBoundary(child: bar),
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
