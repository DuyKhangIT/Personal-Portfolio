# Editorial Portfolio Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the dark Milkinside UI of this Flutter Web portfolio with the light editorial, typography-driven design and seven motion patterns from Dribbble shot 26995447, using CV content only.

**Architecture:** A token layer (`lib/theme/`) feeds a set of single-purpose motion widgets (`lib/widgets/motion/`) that sections compose declaratively. Content lives in a pure-Dart data layer with no Flutter imports beyond `IconData`. One scrolling page hosts six sections; project detail is a non-opaque route overlay rather than a URL route.

**Tech Stack:** Flutter 3.35.4 (via fvm), `visibility_detector` 0.4.0, `flutter_screenutil`, `scrollable_positioned_list`, Geist + Inter TTFs.

## Global Constraints

- Run all Flutter commands through `fvm flutter`, never bare `flutter`.
- Palette tokens are exact: `canvas #F4F4F3`, `surface #FFFFFF`, `ink #0A0A0A`, `inkSoft #6B6B6B`, `inkFaint #9A9A98`, `hairline #E5E5E3`, `ghost #EAEAE8`, `available #22C55E`, `darkBg #1B1B1B`, `darkGhost #2A2A2A`, `darkInk #FFFFFF`, `darkInkSoft #8A8A88`.
- Display face is Geist, body face is Inter. Never use `Icons.*` for display type.
- Responsive type interpolates between the 900px and 1440px breakpoints.
- All copy is English. Do not add `easy_localization` keys for new sections.
- No project screenshots exist. `coverAsset` is null for all six projects; cards render typographic covers.
- Motion constants come from `EditorialMotion` — no inline `Duration` literals in sections.
- `fvm flutter analyze` must be clean at the end of every task.

---

### Task 1: Theme foundation

**Files:**
- Create: `lib/theme/editorial_colors.dart`
- Create: `lib/theme/editorial_type.dart`
- Create: `lib/theme/editorial_motion.dart`
- Modify: `pubspec.yaml` (register Geist family)
- Test: `test/theme/editorial_type_test.dart`

**Interfaces:**
- Produces: `EditorialColors` (static const tokens above), `EditorialPalette` with `.light` / `.dark` instances exposing `bg`, `ghost`, `ink`, `inkSoft`, `inkFaint`, `hairline`; `EditorialType.scale(double width, {required double min, required double max})`; the named styles `EditorialType.display/ghost/label/rowTitle/cardTitle/body/meta(BuildContext)` (`display` is the hero wordmark, `ghost` the oversized background word); `EditorialMotion` constants.

- [ ] **Step 1: Register Geist in `pubspec.yaml`**

Add under `fonts:` alongside the existing Inter families:

```yaml
    - family: Geist
      fonts:
        - asset: assets/fonts/Geist-Regular.ttf
          weight: 400
        - asset: assets/fonts/Geist-Medium.ttf
          weight: 500
        - asset: assets/fonts/Geist-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Geist-Bold.ttf
          weight: 700
        - asset: assets/fonts/Geist-Black.ttf
          weight: 900
```

- [ ] **Step 2: Write the failing test for the responsive scale**

```dart
// test/theme/editorial_type_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/theme/editorial_type.dart';

void main() {
  test('scale clamps below the small breakpoint', () {
    expect(EditorialType.scale(390, min: 64, max: 160), 64);
  });

  test('scale clamps above the large breakpoint', () {
    expect(EditorialType.scale(1920, min: 64, max: 160), 160);
  });

  test('scale interpolates linearly between breakpoints', () {
    // midpoint of 900..1440 is 1170
    expect(EditorialType.scale(1170, min: 64, max: 160), closeTo(112, 0.01));
  });
}
```

- [ ] **Step 3: Run it and confirm it fails**

Run: `fvm flutter test test/theme/editorial_type_test.dart`
Expected: FAIL — `editorial_type.dart` does not exist.

- [ ] **Step 4: Write the three theme files**

`editorial_colors.dart` holds the exact tokens plus `EditorialPalette.light` and `EditorialPalette.dark`.

`editorial_type.dart` implements:

```dart
static const double _minWidth = 900;
static const double _maxWidth = 1440;

static double scale(double width, {required double min, required double max}) {
  final t = ((width - _minWidth) / (_maxWidth - _minWidth)).clamp(0.0, 1.0);
  return min + (max - min) * t;
}
```

and the named styles from the spec's type table, each reading `MediaQuery.sizeOf(context).width`.

`editorial_motion.dart` holds `revealDuration` 700ms, `revealCurve` `Curves.easeOutCubic`, `staggerStep` 80ms, `hoverDuration` 260ms, `hoverCurve` `Curves.easeOut`, `overlayDuration` 520ms, `cursorLerp` 0.16.

- [ ] **Step 5: Run the test and confirm it passes**

Run: `fvm flutter test test/theme/editorial_type_test.dart`
Expected: PASS, 3 tests.

- [ ] **Step 6: Commit**

```bash
git add pubspec.yaml lib/theme test/theme
git commit -m "feat(theme): add editorial color, type and motion tokens"
```

---

### Task 2: Data layer

**Files:**
- Create: `lib/data/portfolio_data.dart`
- Delete: `lib/global/portfolio_data.dart` (after Task 12 removes its last importer — keep both until then)
- Test: `test/data/portfolio_data_test.dart`

**Interfaces:**
- Produces: `enum ProjectCategory { production, enterprise }`; `ProjectItem` with `id, name, domain, company, role, period, teamSize, category, impact, bullets, tech, playStoreUrl, appStoreUrl, coverAsset`; `ExpertiseItem { title, description }`; `StackGroup { title, items }`; `ExperienceItem { company, role, period, logoAsset, projectIds }`; `PortfolioData.projects/expertise/stack/experiences/profile`.
- `Profile` carries `name`, `firstName` ('HUYNH'), `lastName` ('DUY KHANG'), `title`, `tagline`, `email`, `phone`, `location`, `github`, `linkedin`, `yearsExperience`.

- [ ] **Step 1: Write the failing test**

```dart
// test/data/portfolio_data_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/data/portfolio_data.dart';

void main() {
  test('has six projects with unique ids', () {
    expect(PortfolioData.projects, hasLength(6));
    final ids = PortfolioData.projects.map((p) => p.id).toSet();
    expect(ids, hasLength(6));
  });

  test('splits three production and three enterprise projects', () {
    int count(ProjectCategory c) =>
        PortfolioData.projects.where((p) => p.category == c).length;
    expect(count(ProjectCategory.production), 3);
    expect(count(ProjectCategory.enterprise), 3);
  });

  test('every project carries bullets, tech and an impact headline', () {
    for (final p in PortfolioData.projects) {
      expect(p.bullets, isNotEmpty, reason: p.id);
      expect(p.tech, isNotEmpty, reason: p.id);
      expect(p.impact, isNotEmpty, reason: p.id);
    }
  });

  test('has four expertise items, six stack groups, three experiences', () {
    expect(PortfolioData.expertise, hasLength(4));
    expect(PortfolioData.stack, hasLength(6));
    expect(PortfolioData.experiences, hasLength(3));
  });

  test('no project has a cover asset yet', () {
    expect(PortfolioData.projects.every((p) => p.coverAsset == null), isTrue);
  });
}
```

- [ ] **Step 2: Run it and confirm it fails**

Run: `fvm flutter test test/data/portfolio_data_test.dart`
Expected: FAIL — `lib/data/portfolio_data.dart` does not exist.

- [ ] **Step 3: Transcribe the CV into `lib/data/portfolio_data.dart`**

Six projects, verbatim from the CV:

| id | name | domain | company | category | impact |
|---|---|---|---|---|---|
| `rocky-app` | Rocky App | B2B E-commerce Platform | Eggstech | production | Feature delivery ~30% faster |
| `champong` | Truyền thuyết Champong | F&B Chain Application | Eggstech | production | Image load 1.2s → 0.3s · storage −35% |
| `rfid-scanner` | RFID Scanner | Enterprise Inventory Management | Eggstech | enterprise | Scan cycle 3s → 0.8s · memory −45% |
| `rail-pro` | Rail Pro App | Point-of-Sale System | ECR Vietnam | enterprise | 60 FPS · load 8s → 2.5s · 100% uptime |
| `impl` | IMPL App | Logistics & Delivery (Singapore) | ECR Vietnam | enterprise | 99.9% crash-free · manual entry −70% |
| `eca` | eCa App | Automotive Community & Roadside Rescue | EcarAid | production | 50+ active communities |

Bullets, team sizes and tech lists come straight from the CV's PROFESSIONAL EXPERIENCE section. Expertise is the four KEY STRENGTHS items. Stack is the six TECHNICAL SKILLS groups. Experiences are Eggstech (May 2025 – Present, no logo), ECR Vietnam (Feb 2024 – Apr 2025, `assets/images/png/ic_ecr.png`), EcarAid (Jun 2022 – Jan 2024, `assets/images/png/ic_ecaraid.png`).

- [ ] **Step 4: Run the test and confirm it passes**

Run: `fvm flutter test test/data/portfolio_data_test.dart`
Expected: PASS, 5 tests.

- [ ] **Step 5: Commit**

```bash
git add lib/data test/data
git commit -m "feat(data): transcribe CV into the editorial data layer"
```

---

### Task 3: Motion widgets

**Files:**
- Create: `lib/widgets/motion/reveal_on_scroll.dart`
- Create: `lib/widgets/motion/ghost_heading.dart`
- Create: `lib/widgets/motion/hover_scale.dart`
- Create: `lib/widgets/motion/cursor_preview.dart`
- Test: `test/widgets/reveal_on_scroll_test.dart`

**Interfaces:**
- Produces:
  - `RevealOnScroll({required Widget child, Duration delay = Duration.zero, double threshold = 0.1, Key? key})`
  - `GhostHeading({required String ghost, required String label, double scrollOffset = 0, EditorialPalette palette = EditorialPalette.light, Widget? trailing})`
  - `HoverScale({required Widget child, Widget? overlay, double scale = 1.06})`
  - `CursorPreview({required Widget child, required int itemCount, required Widget Function(int) previewBuilder, required void Function(int?) onHoverIndex})` — a `Stack` that renders `child` and, when an index is hovered, the preview lerping toward the pointer with a `-6°` rotation. Disabled when `MediaQuery.sizeOf(context).width < 900`.

- [ ] **Step 1: Write the failing test for `RevealOnScroll`**

```dart
// test/widgets/reveal_on_scroll_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/theme/editorial_motion.dart';
import 'package:personal_portfolio/widgets/motion/reveal_on_scroll.dart';

void main() {
  testWidgets('starts hidden and becomes fully visible after revealing',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RevealOnScroll(child: Text('hello'))),
      ),
    );

    Opacity opacity() =>
        tester.widget<Opacity>(find.byType(Opacity).first);

    expect(opacity().opacity, 0.0);

    // VisibilityDetector fires on its own timer; drive it forward.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(EditorialMotion.revealDuration);

    expect(opacity().opacity, 1.0);
  });
}
```

- [ ] **Step 2: Run it and confirm it fails**

Run: `fvm flutter test test/widgets/reveal_on_scroll_test.dart`
Expected: FAIL — `reveal_on_scroll.dart` does not exist.

- [ ] **Step 3: Implement `RevealOnScroll`**

A `StatefulWidget` with `SingleTickerProviderStateMixin`. Wrap in `VisibilityDetector(key: ValueKey(hashCode))`. On first callback with `visibleFraction >= threshold`, wait `delay`, then `controller.forward()`. Build:

```dart
AnimatedBuilder(
  animation: _t,
  builder: (context, child) => Opacity(
    opacity: _t.value,
    child: ImageFiltered(
      enabled: _t.value < 1,
      imageFilter: ImageFilter.blur(
        sigmaX: 12 * (1 - _t.value),
        sigmaY: 12 * (1 - _t.value),
        tileMode: TileMode.decal,
      ),
      child: Transform.scale(scale: 0.96 + 0.04 * _t.value, child: child),
    ),
  ),
  child: widget.child,
)
```

Set `VisibilityDetectorController.instance.updateInterval = Duration.zero` in `main.dart` under test, or leave the default and let the test pump past it.

- [ ] **Step 4: Run the test and confirm it passes**

Run: `fvm flutter test test/widgets/reveal_on_scroll_test.dart`
Expected: PASS.

- [ ] **Step 5: Implement `GhostHeading`, `HoverScale`, `CursorPreview`**

`GhostHeading` is a `Stack(alignment: Alignment.topLeft)` — the ghost `Text` at `EditorialType.ghost(context)` in `palette.ghost`, translated by `scrollOffset * 0.06` on X, with the `/LABEL` `Text` in `palette.ink` in front, and an optional `trailing` widget pinned right.

`HoverScale` is a `MouseRegion` driving `AnimatedScale` (`EditorialMotion.hoverDuration`) plus an `AnimatedOpacity` for `overlay`.

`CursorPreview` keeps `Offset? _pointer` and `int? _index`, updated in `MouseRegion.onHover`, and lerps a stored `_rendered` offset toward `_pointer` by `EditorialMotion.cursorLerp` on each tick of a repeating `Ticker`.

- [ ] **Step 6: Verify analysis is clean and commit**

```bash
fvm flutter analyze
git add lib/widgets/motion test/widgets
git commit -m "feat(motion): add reveal, ghost heading, hover and cursor preview widgets"
```

---

### Task 4: Shared editorial widgets

**Files:**
- Create: `lib/widgets/pill_button.dart`
- Create: `lib/widgets/section_shell.dart`
- Create: `lib/widgets/editorial_chip.dart`

**Interfaces:**
- Produces: `PillButton({required String label, VoidCallback? onTap, bool filled = true, IconData? trailingIcon, EditorialPalette palette})`; `SectionShell({required Widget child, EditorialPalette palette, EdgeInsets? padding})` applying the max-width 1280 centered column and vertical rhythm; `EditorialChip({required String label, bool selected, VoidCallback? onTap})`.

- [ ] **Step 1: Implement the three widgets**

`PillButton` filled variant is `ink` background with `surface` text; outlined variant is transparent with a `hairline` border. Trailing icon defaults to `Icons.arrow_outward` at 14px. Hover lifts it 2px via `AnimatedSlide`.

`SectionShell` centres a `ConstrainedBox(maxWidth: 1280)` with horizontal padding `24` below 900px and `64` above, vertical padding `120` above 900px and `72` below.

`EditorialChip` is the filter chip — `hairline` border, `ink` fill and `surface` text when selected.

- [ ] **Step 2: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/widgets
git commit -m "feat(widgets): add pill button, section shell and chip"
```

---

### Task 5: Hero section

**Files:**
- Create: `lib/sections/hero_section.dart`

**Interfaces:**
- Consumes: `EditorialType`, `EditorialColors`, `PortfolioData.profile`, `RevealOnScroll`, `PillButton`.
- Produces: `HeroSection({Key? key})`.

- [ ] **Step 1: Build the wordmark**

Two lines. `HUYNH` uses outline text — a `Stack` of two `Text` widgets where the back one has `foreground = Paint()..style = PaintingStyle.stroke..strokeWidth = 1.5..color = EditorialColors.ink`. `DUY KHANG` is solid `EditorialColors.ink`.

- [ ] **Step 2: Layer the portrait**

`assets/images/png/avt.png` sits in the same `Stack`, centred, with `RevealOnScroll` supplying its rise. Paint order: outline line → portrait → solid line, so the photo passes behind `DUY KHANG` and in front of `HUYNH`.

- [ ] **Step 3: Add the two columns**

Left: `Mobile Engineer` (rowTitle), tagline `Flutter Expert · 4 years · 6+ production apps shipped` (body, `inkSoft`), filled `Let's collaborate ↗` pill scrolling to Contact.
Right: vertical stack of outlined GitHub / LinkedIn / Email / Phone pills, each wrapped in `RevealOnScroll(delay: index * EditorialMotion.staggerStep)`, opening via the existing `openUrl` helper.

- [ ] **Step 4: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/sections/hero_section.dart
git commit -m "feat(sections): add editorial hero"
```

---

### Task 6: Selected Work section

**Files:**
- Create: `lib/widgets/project_card.dart`
- Create: `lib/sections/work_section.dart`
- Test: `test/sections/work_filter_test.dart`

**Interfaces:**
- Produces: `ProjectCard({required ProjectItem project, required VoidCallback onTap})`; `WorkSection({required void Function(ProjectItem) onOpenProject})`; `List<ProjectItem> filterProjects(List<ProjectItem> all, ProjectCategory? category)` exported from `work_section.dart` for testing.

- [ ] **Step 1: Write the failing filter test**

```dart
// test/sections/work_filter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/data/portfolio_data.dart';
import 'package:personal_portfolio/sections/work_section.dart';

void main() {
  test('null category returns everything', () {
    expect(filterProjects(PortfolioData.projects, null), hasLength(6));
  });

  test('production category returns only production projects', () {
    final result =
        filterProjects(PortfolioData.projects, ProjectCategory.production);
    expect(result, hasLength(3));
    expect(result.every((p) => p.category == ProjectCategory.production), isTrue);
  });
}
```

- [ ] **Step 2: Run it and confirm it fails**

Run: `fvm flutter test test/sections/work_filter_test.dart`
Expected: FAIL — `work_section.dart` does not exist.

- [ ] **Step 3: Implement `ProjectCard`**

Typographic cover: a `Container` with a subtle vertical gradient from `#FAFAF9` to `#EFEFED`, a `hairline` border, `16` radius. Inside — the category badge top-left, the project name at `cardTitle` scaled up 1.6×, and the `impact` string at `meta` in `inkFaint` bottom-left. Wrapped in `HoverScale(scale: 1.06, overlay: circular ↗ button)`.

Below the cover: title, then a `Wrap` of the first four `tech` entries as chips.

- [ ] **Step 4: Implement `WorkSection`**

`GhostHeading(ghost: 'PROJECTS', label: '/SELECTED WORK')`, a row of `EditorialChip` filters (`All`, `Production`, `Enterprise`) with an outlined `GitHub ↗` pill pushed right, then a `Wrap` of cards at two columns above 900px and one below. Each card is wrapped in `RevealOnScroll(delay: index * EditorialMotion.staggerStep)`.

- [ ] **Step 5: Run the test and confirm it passes**

Run: `fvm flutter test test/sections/work_filter_test.dart`
Expected: PASS.

- [ ] **Step 6: Commit**

```bash
fvm flutter analyze
git add lib/widgets/project_card.dart lib/sections/work_section.dart test/sections
git commit -m "feat(sections): add selected work grid with category filter"
```

---

### Task 7: Project detail overlay

**Files:**
- Create: `lib/overlays/project_detail_overlay.dart`

**Interfaces:**
- Produces: `Route<void> projectDetailRoute(ProjectItem project)` returning a `PageRouteBuilder` with `opaque: false`, `transitionDuration: EditorialMotion.overlayDuration`, and a fade + 24px upward slide.
- Consumes: `ProjectItem`, `PillButton`, `RevealOnScroll`.

- [ ] **Step 1: Build the overlay body**

Scrollable, `canvas` background. Top bar: outlined `← Back` pill left, `● Available for New Project` right. Then the domain and company chips, the project name at hero-adjacent scale with `/{category}` suffix in `inkFaint`, and the description.

Right-hand meta column: `Role`, `Period`, `Team`, `Tech` — labels at `meta` in `inkFaint`, values at `body` in `ink`.

Then the bullet list, each row an `↳`-prefixed `body` paragraph wrapped in `RevealOnScroll` with an 80ms stagger. Store links render as filled pills when the project has them.

- [ ] **Step 2: Wire the hero transition**

Wrap the card cover in `Hero(tag: 'project-${project.id}')` in both `ProjectCard` and this overlay so the cover animates between them.

- [ ] **Step 3: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/overlays
git commit -m "feat(overlay): add project detail overlay with hero transition"
```

---

### Task 8: Expertise section

**Files:**
- Create: `lib/widgets/expertise_row.dart`
- Create: `lib/sections/expertise_section.dart`

**Interfaces:**
- Produces: `ExpertiseRow({required ExpertiseItem item, required int index})`, `ExpertiseSection()`.

- [ ] **Step 1: Implement the row**

A full-width `MouseRegion` row: title at `rowTitle`, trailing `↗` that slides 4px right on hover, `hairline` divider beneath. The description sits in an `AnimatedSize` that is collapsed at rest and expands on hover when width ≥ 900; below 900 it is always expanded.

- [ ] **Step 2: Implement the section**

`GhostHeading(ghost: 'STRENGTH', label: '/EXPERTISE')` then the four rows, each in `RevealOnScroll(delay: index * EditorialMotion.staggerStep)`.

- [ ] **Step 3: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/widgets/expertise_row.dart lib/sections/expertise_section.dart
git commit -m "feat(sections): add expertise rows"
```

---

### Task 9: Stack section

**Files:**
- Create: `lib/sections/stack_section.dart`

**Interfaces:**
- Produces: `StackSection()`.

- [ ] **Step 1: Implement**

`GhostHeading(ghost: 'TECH', label: '/STACK')`, then six groups. Each group is a two-column row above 900px — group title at `rowTitle` scaled 0.7× on the left, a `Wrap` of `EditorialChip(selected: false)` items on the right — stacking vertically below 900px. `hairline` divider between groups, each group in `RevealOnScroll` with an 80ms stagger.

- [ ] **Step 2: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/sections/stack_section.dart
git commit -m "feat(sections): add tech stack groups"
```

---

### Task 10: Experience section (dark)

**Files:**
- Create: `lib/widgets/experience_row.dart`
- Create: `lib/sections/experience_section.dart`

**Interfaces:**
- Produces: `ExperienceRow({required ExperienceItem item})`, `ExperienceSection()`.

- [ ] **Step 1: Implement the dark shell**

A `Container` with `EditorialColors.darkBg`, `borderRadius: 32`, horizontal margin 24, passing `EditorialPalette.dark` down to `GhostHeading(ghost: 'EXPERIENCE', label: '/EXPERIENCE', trailing: Text('4+ years of experience'))`.

- [ ] **Step 2: Implement the rows and cursor preview**

Three rows: company (rowTitle, `darkInk`) over role (`body`, `darkInkSoft`) on the left, period right. Divider in `darkInkSoft` at 18% opacity.

Wrap the row list in `CursorPreview`, where `previewBuilder(i)` returns a 220×140 rounded card showing that company's `logoAsset` on a `surface` background. Eggstech has no logo, so its preview shows the company monogram `E` at display weight instead.

- [ ] **Step 3: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/widgets/experience_row.dart lib/sections/experience_section.dart
git commit -m "feat(sections): add dark experience section with cursor preview"
```

---

### Task 11: Contact section

**Files:**
- Create: `lib/sections/contact_section.dart`

**Interfaces:**
- Produces: `ContactSection()`.
- Consumes: the existing `DownloadButton` from `lib/pages/widgets/download_button.dart` and `lib/ultils/download_file.dart`.

- [ ] **Step 1: Implement**

Centred column: `● Available for New Project` badge, `HAVE A PROJECT IN MIND?` at label scale ×1.4, a two-line supporting paragraph, a filled `Contact Me ↗` pill opening `mailto:`, then a centred `Wrap` of name / GitHub / LinkedIn / Email pills. Keep the Download CV button, restyled as an outlined pill.

- [ ] **Step 2: Verify analysis and commit**

```bash
fvm flutter analyze
git add lib/sections/contact_section.dart
git commit -m "feat(sections): add contact section"
```

---

### Task 12: Page assembly, nav, and removal of the old UI

**Files:**
- Create: `lib/pages/portfolio_page.dart`
- Create: `lib/widgets/editorial_nav.dart`
- Modify: `lib/main.dart` (point at `PortfolioPage`, set the light theme)
- Delete: `lib/pages/main_page.dart`, `lib/pages/home_page.dart`, `lib/pages/about_page.dart`, `lib/pages/skills_page.dart`, `lib/pages/experience_page.dart`, `lib/pages/strengths_page.dart`, `lib/pages/education_page.dart`, `lib/pages/contact_page.dart`, `lib/pages/widgets/milk_ui.dart`, `lib/pages/widgets/custom_appbar.dart`, `lib/global/app_themes.dart`, `lib/global/portfolio_data.dart`

**Interfaces:**
- Produces: `PortfolioPage()`, `EditorialNav({required Map<String,VoidCallback> destinations, required VoidCallback onTalk})`.

- [ ] **Step 1: Build `EditorialNav`**

A floating pill (`surface`, `hairline` border, radius 999, blur backdrop) holding the availability badge, the five destination labels with superscript counts, and the filled `Let's Talk ↗` pill. Below 900px it shows the availability badge and a hamburger that opens an endDrawer.

- [ ] **Step 2: Build `PortfolioPage`**

A `Scaffold` on `EditorialColors.canvas` with a `ScrollController`-driven `SingleChildScrollView` (replacing `ScrollablePositionedList`, since ghost parallax needs a raw pixel offset). Section anchors are `GlobalKey`s; nav taps call `Scrollable.ensureVisible` with `EditorialMotion.overlayDuration` and `Curves.easeInOutCubic`. The scroll offset is passed down to each `GhostHeading`.

`onOpenProject` pushes `projectDetailRoute(project)`.

- [ ] **Step 3: Update `main.dart`**

Swap `MainPage` for `PortfolioPage`, replace `milkinsideTheme` with an inline light `ThemeData(fontFamily: 'Geist', scaffoldBackgroundColor: EditorialColors.canvas)`, and set `VisibilityDetectorController.instance.updateInterval = const Duration(milliseconds: 100)`.

- [ ] **Step 4: Delete the old UI and fix fallout**

Run `fvm flutter analyze` and resolve every reference to the deleted files.

- [ ] **Step 5: Confirm the whole suite passes and commit**

```bash
fvm flutter analyze
fvm flutter test
git add -A
git commit -m "feat(page): assemble editorial portfolio and remove the dark UI"
```

---

### Task 13: Browser verification and responsive pass

**Files:**
- Modify: whichever section files the verification turns up problems in.
- Create: `.claude/launch.json` if it does not already exist.

- [ ] **Step 1: Start the dev server**

`.claude/launch.json` entry: `runtimeExecutable: "fvm"`, `runtimeArgs: ["flutter","run","-d","web-server","--web-port","5555"]`, `port: 5555`. Start it with `preview_start`.

- [ ] **Step 2: Check the console and network for errors**

Use `read_console_messages` and `preview_logs`. Expected: no exceptions, all five Geist faces resolving.

- [ ] **Step 3: Verify each motion pattern**

Scroll through and screenshot: sections reveal with blur-fade, ghost words parallax, project cards zoom on hover with the `↗` appearing, an experience row shows the tilted follower card, and a card opens the overlay with the cover animating across.

- [ ] **Step 4: Check three widths**

`resize_window` at 1440×900, 1024×768 and 390×844, reloading each time. Confirm the grid collapses to one column, the nav collapses to a hamburger, expertise descriptions are always visible, and nothing overflows horizontally.

- [ ] **Step 5: Fix what the pass turns up, then commit**

```bash
fvm flutter analyze
git add -A
git commit -m "fix(ui): responsive and motion corrections from browser verification"
```
