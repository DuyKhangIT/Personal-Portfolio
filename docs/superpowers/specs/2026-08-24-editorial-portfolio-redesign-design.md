# Editorial Portfolio Redesign — Design

**Date:** 2026-08-24
**Status:** Approved

## Goal

Replace the entire dark "Milkinside" UI of this Flutter Web portfolio with the
light editorial, typography-driven design from Dribbble shot 26995447
("Personal Portfolio Website — Animations" by Dymas Alfin / Mikan Team),
reproducing its seven motion patterns. All content comes from the CV at
`~/Desktop/Huynh_Duy_Khang_Flutter_Developer.pdf` — projects, personal
introduction, and tech stack only.

## Decisions

| Question | Decision |
|---|---|
| Palette | Light editorial, matching the video, with the Experience section flipping to dark |
| Project detail | Full-screen overlay opened in place, with a hero transition from the card and a `← Back` control. No URL routing. |
| Display font | Geist (copied locally from `~/Desktop/Geist/static/`), Inter retained for body |
| `/SERVICE` section maps to | Two sections: `/EXPERTISE` then `/STACK` |
| Project cover art | Typographic covers (no screenshots exist in `assets/`), with a slot for real screenshots later |
| Viewport detection | `visibility_detector` package |

## Non-goals

- Education and Languages sections are dropped — the brief asked for projects,
  introduction, and tech only.
- No URL routing per project. `router.dart` stays commented out.
- New UI copy is English-only. The `easy_localization` infrastructure stays
  wired up (`main.dart` is untouched) but the new sections do not use it.

## Design tokens

### Color — `lib/theme/editorial_colors.dart`

| Token | Value | Use |
|---|---|---|
| `canvas` | `#F4F4F3` | page background |
| `surface` | `#FFFFFF` | cards, raised sections |
| `ink` | `#0A0A0A` | primary text |
| `inkSoft` | `#6B6B6B` | descriptions, meta |
| `inkFaint` | `#9A9A98` | tertiary meta |
| `hairline` | `#E5E5E3` | rules, chip borders |
| `ghost` | `#EAEAE8` | oversized background word |
| `available` | `#22C55E` | "Available for work" dot |
| `darkBg` | `#1B1B1B` | Experience section background |
| `darkGhost` | `#2A2A2A` | Experience oversized word |
| `darkInk` | `#FFFFFF` | Experience primary text |
| `darkInkSoft` | `#8A8A88` | Experience meta |

A `EditorialPalette` object carries the light and dark variants so section
widgets read tokens from one place instead of branching on a boolean.

### Type — `lib/theme/editorial_type.dart`

Display face **Geist** (`Regular/Medium/SemiBold/Bold/Black`), body face
**Inter** (already bundled).

| Role | Size (min → max) | Weight | Tracking | Leading |
|---|---|---|---|---|
| Hero wordmark | 64 → 160 | 700 | -0.04em | 0.90 |
| Ghost word | 120 → 220 | 700 | -0.03em | 1.0 |
| Section label (`/SELECTED WORK`) | 28 → 44 | 600 | -0.02em | 1.05 |
| Row title (Expertise, Experience) | 24 → 40 | 500 | -0.02em | 1.1 |
| Card title | 18 → 22 | 500 | -0.01em | 1.25 |
| Body (Inter) | 14 → 16 | 400 | 0 | 1.6 |
| Meta / chip | 12 → 13 | 500 | +0.02em | 1.2 |

Sizes interpolate on viewport width between the 900px and 1440px breakpoints.

### Motion — `lib/theme/editorial_motion.dart`

| Constant | Value |
|---|---|
| `revealDuration` | 700ms |
| `revealCurve` | `Curves.easeOutCubic` |
| `staggerStep` | 80ms |
| `hoverDuration` | 260ms |
| `hoverCurve` | `Curves.easeOut` |
| `overlayDuration` | 520ms |
| `cursorLerp` | 0.16 per frame |

## Architecture

```
lib/theme/          editorial_colors · editorial_type · editorial_motion
lib/data/           portfolio_data (extended) · project_detail
lib/widgets/motion/ reveal_on_scroll · ghost_heading · cursor_preview · hover_scale
lib/widgets/        editorial_nav · project_card · expertise_row · experience_row
                    stack_group · pill_button · section_shell
lib/sections/       hero · work · expertise · stack · experience · contact
lib/overlays/       project_detail_overlay
lib/pages/          portfolio_page
```

Each motion widget has one job and takes a child, so sections stay declarative:

- **`RevealOnScroll`** — wraps any child. When ≥10% visible it animates blur
  `12→0`, opacity `0→1`, scale `0.96→1`. Takes an optional `delay` used by
  callers to stagger. Fires once.
- **`GhostHeading`** — a `Stack` of the oversized `ghost`-colored word behind a
  `/LABEL`. Applies a small parallax offset driven by the page scroll offset.
- **`CursorPreview`** — desktop-only. Wraps a list; on hover of row `i` it
  shows that row's image, lerping toward the pointer with a `-6°` rotation.
  Disabled when the pointer is a touch device or width < 900.
- **`HoverScale`** — scales its child and cross-fades an overlay child (used
  for the circular `↗` button on project cards).

### Deletions

`lib/pages/widgets/milk_ui.dart` (671 lines, dark-only), the seven
`lib/pages/*_page.dart` files, `lib/global/app_themes.dart`.

### Retained untouched

`lib/ultils/download_file.dart`, `open_url.dart`, `string_utils.dart`,
`lib/main.dart`, `lib/application_config.dart`, the bloc/cubit and service
layers under `lib/core/`.

`lib/ultils/color_utils.dart` keeps its existing tokens so any remaining
references compile; the new palette lives in `lib/theme/`.

## Sections

### 0. Nav

A floating pill: `● Available for New Project` · `Work⁽⁶⁾` · `Expertise⁽⁴⁾` ·
`Stack` · `Experience⁽³⁾` · `Contact` · black `Let's Talk ↗` pill.
Below 900px it collapses to a hamburger opening the existing drawer pattern.

### 1. Hero

`HUYNH` rendered as outline text, `DUY KHANG` solid, on two lines.
`assets/images/png/avt.png` rises from below and overlaps the wordmark
(the photo sits above the outline line, below the solid line).

Left column: "Mobile Engineer" / "Flutter Expert · 4 years · 6+ production
apps shipped" / black `Let's collaborate ↗` pill.
Right column: vertical stack of GitHub, LinkedIn, Email, Phone pills,
staggered in.

### 2. `/SELECTED WORK` — ghost word `PROJECTS`

Filter chips `All · Production · Enterprise`, a `GitHub ↗` control in the
video's "View All Work" position (there is no separate all-work page, so it
links to the GitHub profile), and a two-column grid of six project cards. Each card: typographic cover, badge
(`PRODUCTION` / `ENTERPRISE`), title, tech chips. Hover zooms the cover and
fades in a circular `↗`. Click opens the detail overlay.

Classification: **Production** = shipped to app stores (Rocky, Champong, eCa).
**Enterprise** = internal tooling (RFID Scanner, Rail Pro, IMPL).

### 3. `/EXPERTISE` — ghost word `STRENGTH`

Four full-width rows from the CV's KEY STRENGTHS, each with a trailing `↗`,
revealed with an 80ms stagger. At ≥900px the description is collapsed and
expands on hover; below 900px it is always visible, since there is no hover.

### 4. `/STACK` — ghost word `TECH`

Seven groups from the CV's TECHNICAL SKILLS, rendered as label + chip cluster.

### 5. `/EXPERIENCE` — dark section

Background flips to `darkBg` with a large corner radius. `4+ years of
experience` sits at the right of the heading. Three company rows
(company / role — period). Hovering a row shows a tilted logo card that
follows the cursor.

### 6. `/CONTACT`

`HAVE A PROJECT IN MIND?` headline, `Contact Me ↗` pill, a row of social
pills, and the existing Download CV button (wiring preserved).

## Data model

`lib/data/portfolio_data.dart` extends the current shape:

```dart
class ProjectItem {
  final String id;            // 'rocky-app'
  final String name;
  final String domain;        // 'B2B E-commerce Platform'
  final String company;
  final String? role;         // 'Lead Mobile' where applicable
  final String period;
  final String teamSize;      // '10 (1 lead Mobile, 2 Mobile, 3 BE, ...)'
  final ProjectCategory category;   // production | enterprise
  final String impact;        // headline metric for the card
  final List<String> bullets;
  final List<String> tech;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? coverAsset;   // null today; typographic cover used instead
}
```

`coverAsset` is the slot for real screenshots later. When null, the card and
overlay render the typographic cover.

Six projects, four expertise items, seven stack groups, and three experience
entries are transcribed verbatim from the CV.

## Responsive behaviour

| Width | Layout |
|---|---|
| ≥ 1200 | Two-column work grid, full nav pill, all hover motion active |
| 900–1200 | Two-column grid, condensed nav |
| < 900 | Single column, hamburger drawer, hover patterns replaced by tap; `CursorPreview` disabled |

## Verification

Run the app with `fvm flutter run -d chrome` and confirm in the browser
preview: each section reveals on scroll, the ghost words parallax, project
cards respond to hover and open the overlay, the experience rows show the
cursor-following card, and the layout holds at 1440 / 1024 / 390 widths.
`fvm flutter analyze` must be clean.
