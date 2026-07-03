# MColi UI → Flux UI — Component Migration Tracking

> Updated: June 2026 · See `docs/architecture/ARCHITECTURE_REVIEW.md` for full findings.

## Legend
- [x] = Done · [~] = In Progress · [ ] = Not Started
- Priority: P0 (blocking) > P1 (important) > P2 (nice to have)

## Core Interactive Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [x] | Button | `FluxButton` | P0 | 4 variants, 4 sizes, icon modes, loading, destructive. Needs `WidgetStateProperty`, `FocusNode`, `styleFrom()` refactor |
| [x] | Checkbox | `FluxCheckbox` | P0 | 2 sizes, label + support text, indeterminate. Needs `FluxCheckboxSize`, `Widget` label, `tristate` |
| [x] | Input OTP | `FluxInputOtp` | P0 | Slot-based, separator, caret blink. Needs paste support, `onCompleted` |
| [x] | Dropdown Menu | `FluxDropdownMenu` | P0 | Full menu: items, submenu, checkbox, radio, separator. Needs Flutter-native `OverlayEntry` rewrite |
| [ ] | Slider | `FluxSlider` | P1 | Single/range, discrete/continuous |
| [ ] | Switch | `FluxSwitch` | P1 | On/off, sizes, labels |
| [ ] | Radio | `FluxRadio` | P1 | Group management, labels |

## Input Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Text Field | `FluxTextField` | P0 | Outlined/filled, textarea, validation, password toggle |
| [ ] | Search Field | `FluxSearchField` | P2 | Search icon, clear button, debounce |
| [ ] | Select | `FluxSelect` | P2 | Single/multiple, searchable dropdown |

## Display Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Card | `FluxCard` | P0 | Elevated/outlined/tonal. Needs `Hero` support, `onTap` |
| [ ] | Avatar | `FluxAvatar` | P1 | Image, initials, badges, sizes |
| [ ] | Badge | `FluxBadge` | P1 | Dot, count, variants, positions |
| [ ] | Chip | `FluxChip` | P1 | Label, dismissible, selected |
| [ ] | Tag | `FluxTag` | P1 | Colored tags |
| [ ] | Divider | `FluxDivider` | P1 | Horizontal, vertical, with label |

## Feedback Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Alert | `FluxAlert` | P1 | Success/warning/error/info, dismissible |
| [ ] | Toast | `FluxToast` | P0 | Auto-dismiss, action, stackable. Needs `FluxToastService` + `FluxPortal` |
| [ ] | Snackbar | `FluxSnackbar` | P1 | Themed wrapper around native SnackBar |
| [ ] | Progress | `FluxProgress` | P1 | Linear, circular, determinate, indeterminate |
| [ ] | Skeleton | `FluxSkeleton` | P1 | Text, circle, rectangle shimmer. Depends on `FluxShimmer` |
| [ ] | Shimmer | `FluxShimmer` | P0 | Reusable shimmer effect. Used by Skeleton, Loading |
| [ ] | Spinner | `FluxSpinner` | P1 | Loading spinner, sizes |

## Overlay Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Dialog | `FluxDialog` | P0 | Alert, confirmation, custom, fullscreen. Needs `FluxPortal` + focus trapping |
| [ ] | Bottom Sheet | `FluxBottomSheet` | P1 | Standard, expanded, draggable, snap points |
| [ ] | Popover | `FluxPopover` | P1 | Anchored, dismissible. Needs `CompositedTransformFollower` |
| [ ] | Tooltip | `FluxTooltip` | P1 | Rich content, all positions, show/hide delay |
| [ ] | Drawer | `FluxDrawer` | P1 | Left/right, persistent/temporary, swipe gesture |
| [ ] | Overlay | `FluxOverlay` | P1 | Modal overlay with dimming, dismiss on backdrop |

## Navigation Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Tabs | `FluxTabs` | P0 | Horizontal, vertical, scrollable, keyboard nav |
| [ ] | Accordion | `FluxAccordion` | P1 | Collapse/expand, single/multiple, animated |
| [ ] | Breadcrumb | `FluxBreadcrumb` | P2 | Navigation trail, overflow handling |
| [ ] | Pagination | `FluxPagination` | P2 | Page buttons, prev/next, ellipsis |
| [ ] | Navigation Rail | `FluxNavigationRail` | P2 | Desktop navigation rail, collapsed/expanded |
| [ ] | Stepper | `FluxStepper` | P2 | Step indicator with completed/active/pending |
| [ ] | Sidebar | `FluxSidebar` | P2 | Responsive sidebar, collapsible |

## Data Display Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Table | `FluxTable` | P1 | Data table, sortable, selectable, generics `<T>` |
| [ ] | Timeline | `FluxTimeline` | P2 | Vertical timeline with nodes |
| [ ] | Carousel | `FluxCarousel` | P2 | Image carousel, auto-play, dots |
| [ ] | Image | `FluxImage` | P2 | Optimized image with placeholder |
| [ ] | Masonry | `FluxMasonry` | P2 | Masonry layout |
| [ ] | Grid | `FluxGrid` | P1 | Responsive grid |
| [ ] | Stack | `FluxStack` | P1 | Overlapping items |

## Layout & Status Components

| Status | Component | Flutter Target | Priority | Notes |
|--------|-----------|---------------|----------|-------|
| [ ] | Responsive Layout | `FluxResponsiveLayout` | P1 | Breakpoint-aware layout |
| [ ] | Adaptive Layout | `FluxAdaptiveLayout` | P2 | Platform-adaptive layout |
| [ ] | Loading | `FluxLoading` | P1 | Full-page loading overlay |
| [ ] | Empty State | `FluxEmptyState` | P1 | Icon, message, action |
| [ ] | Error State | `FluxErrorState` | P1 | Error message, retry |
| [ ] | Hero | `FluxHero` | P1 | Large hero section |
| [ ] | Banner | `FluxBanner` | P2 | Top banner, dismissible |

## Primitives (Missing — New)

| Status | Component | Priority | Notes |
|--------|-----------|----------|-------|
| [ ] | `FluxPressable` | P0 | Base interaction mixin (hover, press, focus, disabled) |
| [ ] | `FluxFocusRing` | P0 | Reusable focus ring widget |
| [ ] | `FluxAnimatedVisibility` | P0 | Enter/exit animation wrapper (shadcn `animate-in`/`animate-out`) |
| [ ] | `FluxProvider` | P0 | Root theme provider |
| [ ] | `FluxPortal` | P0 | Overlay portal (React `createPortal`) |
| [ ] | `FluxIcon` | P0 | Icon sizing/theme wrapper |
| [ ] | `FluxText` | P0 | Typography text widget |

## Providers (Missing — New)

| Status | Component | Priority | Notes |
|--------|-----------|----------|-------|
| [ ] | `FluxThemeProvider` | P1 | Theme notifier + switcher (light/dark/highContrast) |
| [ ] | `FluxLocalizationProvider` | P2 | i18n support |

## Utilities (Missing — New)

| Status | Utility | Priority | Notes |
|--------|---------|----------|-------|
| [ ] | Context Extensions | P0 | `context.fluxColors`, `context.breakpoint`, etc. |
| [ ] | Widget Extensions | P1 | `.paddingAll()`, `.center()`, `.onTap()`, etc. |
| [ ] | Color Utilities | P1 | `Color.darken()`, `.lighten()`, `.isLight`, `Color.hex()` |
| [ ] | Shadow Utilities | P1 | `FluxShadowSize`, `BoxDecoration.withShadow()` |
| [ ] | Animation Helpers | P1 | `FluxAnimationDurations`, `FluxAnimationCurves`, `FluxTweenBuilder` |
| [ ] | Typography Utilities | P1 | `TextStyle.applyFluxStyle()` |
| [ ] | Shape Utilities | P1 | `RoundedRectangleBorder.flux()` |
| [ ] | `FluxGap` | P1 | Fixed-size spacer |
| [ ] | `FluxSafeArea` | P1 | Themed safe area wrapper |
| [ ] | `FluxConstrainedBox` | P1 | Max-width container |

## Theme System

| Status | Component | Priority | Notes |
|--------|-----------|----------|-------|
| [x] | Light Theme | P0 | Light token presets |
| [x] | Dark Theme | P0 | Dark token presets |
| [x] | Primary Brand | P0 | Deep blue |
| [x] | Secondary Brand | P0 | Purple |
| [x] | GameDev Brand | P1 | Yellow/pink |
| [x] | Robotics Brand | P1 | High-contrast |
| [x] | IT Brand | P1 | Green/navy |
| [ ] | High Contrast Theme | P1 | WCAG AAA compliant |
| [ ] | Dynamic Color (M3) | P1 | `ColorScheme.fromSeed()` |
| [ ] | Split Theme Extensions | P0 | One `ThemeExtension` per domain |
| [ ] | `lerp` for all extensions | P0 | Smooth theme transitions |
| [ ] | ColorScheme mapping | P0 | Flux tokens → M3 `ColorScheme` |
| [ ] | TextTheme mapping | P0 | Flux typography → M3 `TextTheme` |

## React → Flutter Pattern Replacements

| React Pattern | Flutter Replacement | Status |
|---------------|--------------------|--------|
| `cva()` (class-variance-authority) | `ThemeExtension` + `WidgetStateProperty` | [ ] |
| `cn()` / `twMerge()` | `BoxDecoration.merge()`, `ButtonStyle.merge()` | [ ] |
| `@base-ui/react/button` | `FluxPressable` + `Semantics` + `Focus` | [ ] |
| `createPortal()` | `FluxPortal` + `OverlayEntry` | [ ] |
| CSS `transition-all` | `AnimatedContainer`, `TweenAnimationBuilder` | [ ] |
| `use client` / `"use client"` | `StatefulWidget` (always client) | N/A |

**Key**: [x] = Done, [ ] = Not Started, [~] = In Progress
