# Flux UI — Implementation Roadmap

## Phase 1: Foundation (Priority: Critical, ~32 hrs)

### Milestone 1.1 — Project Scaffold (2 hrs)
- [x] Create `packages/flux_ui/` directory structure
- [x] Set up `pubspec.yaml` with dependencies (flutter, meta, etc.)
- [x] Create barrel exports (`lib/flux_ui.dart`, `lib/theme.dart`)
- [x] Set up analysis_options.yaml

### Milestone 1.2 — Design Tokens (6 hrs)
- [x] `lib/src/core/tokens/colors.dart` — All ~100 raw color tokens
- [x] `lib/src/core/tokens/typography.dart` — Font sizes, weights, families
- [x] `lib/src/core/tokens/spacing.dart` — 4px-based spacing scale
- [x] `lib/src/core/tokens/radius.dart` — Border radius tokens
- [x] `lib/src/core/tokens/elevation.dart` — Shadow/elevation tokens
- [x] `lib/src/core/tokens/opacity.dart` — Opacity levels
- [x] `lib/src/core/tokens/animation.dart` — Durations & curves
- [x] `lib/src/core/tokens/breakpoints.dart` — Responsive breakpoints
- [x] `lib/src/core/tokens/z_index.dart` — Z-index layer system

### Milestone 1.3 — Theme Engine (8 hrs → **16 hrs**)
- [x] `lib/src/core/theme/flux_theme_data.dart` — Theme extension class
- [ ] **Split into focused `ThemeExtension` subclasses** (Issue #8):
  - `FluxColorTheme`, `FluxTypographyTheme`, `FluxShapeTheme`
  - `FluxSpacingTheme`, `FluxShadowTheme`, `FluxAnimationTheme`
  - `FluxButtonTheme`, `FluxCardTheme`, `FluxInputTheme`, `FluxNavigationTheme`, `FluxOverlayTheme`
- [ ] **Implement `lerp` for all extensions** (Issue #10)
- [ ] **Map Flux tokens → M3 `ColorScheme`** (Issue #11)
- [ ] **Map Flux typography → M3 `TextTheme`** (Issue #12)
- [x] `lib/src/core/theme/light_theme.dart` — Light theme factory
- [x] `lib/src/core/theme/dark_theme.dart` — Dark theme factory
- [ ] `lib/src/core/theme/high_contrast_theme.dart` — High contrast (WCAG AAA)
- [x] `lib/src/core/theme/brand_themes/` — 5 brand themes
- [x] `lib/src/core/theme/extensions/` — ColorScheme, TextTheme, ShapeTheme, etc.
- [ ] **Dynamic Color / Material You** (Issue #13)

### Milestone 1.4 — Primitives (New — **8 hrs**)
- [ ] `FluxPressable` — Base interaction primitive (Issue #1)
- [ ] `FluxFocusRing` — Reusable focus ring (Issue #2)
- [ ] `FluxAnimatedVisibility` — Enter/exit animation wrapper (Issue #3)
- [ ] `FluxProvider` — Root theme provider (Issue #4)
- [ ] `FluxPortal` — Overlay portal (Issue #5)
- [ ] `FluxIcon` — Icon wrapper (Issue #6)
- [ ] `FluxText` — Typography widget (Issue #7)

### Milestone 1.5 — Core Utilities (4 hrs → **8 hrs**)
- [x] `lib/src/utils/flux_cn.dart` — Class merge utility
- [x] `lib/src/utils/flux_variant.dart` — Variant enum system
- [x] `lib/src/utils/flux_size.dart` — Size enum system
- [x] `lib/src/core/extensions/build_context_ext.dart` — Context helpers
- [x] `lib/src/core/extensions/widget_ext.dart` — Widget helpers
- [ ] **Context Extensions** — `context.fluxColors`, `context.breakpoint`, etc. (Issue #68)
- [ ] **Widget Extensions** — `.paddingAll()`, `.center()`, etc. (Issue #69)
- [ ] **Color/Shadow/Typography/Shape Utilities** (Issues #70–#74)
- [ ] **Barrel Export Reorganization** (Issue #84)

## Phase 2: Core Components (Priority: High, ~56 hrs)

### Milestone 2.1 — Interactive Components (16 hrs → **24 hrs**)
- [x] `FluxButton` — **Refactor needed** (Issue #14)
- [x] `FluxCheckbox` — **Refactor needed** (Issue #15)
- [x] `FluxInputOtp` — **Refactor needed** (Issue #16)
- [x] `FluxDropdownMenu` — **Flutter-native rewrite needed** (Issue #17)
- [ ] `FluxSlider` — Implement (Issue #18)
- [ ] `FluxSwitch` — Refactor (Issue #19)
- [ ] `FluxRadio` — Refactor (Issue #20)

### Milestone 2.2 — Input Components (10 hrs)
- [ ] `FluxTextField` — Implement (Issue #21)
- [ ] `FluxSearchField` — Implement (Issue #22)
- [ ] `FluxSelect` — Implement (Issue #23)

### Milestone 2.3 — Display Components (8 hrs → **12 hrs**)
- [ ] `FluxCard` — Implement with `Hero`, `onTap` (Issue #24)
- [ ] `FluxAvatar` — Implement (Issue #25)
- [ ] `FluxBadge` — Implement (Issue #26)
- [ ] `FluxChip` — Implement (Issue #27)
- [ ] `FluxTag` — Implement (Issue #28)
- [ ] `FluxDivider` — Implement (Issue #54)

### Milestone 2.4 — Feedback Components (6 hrs → **12 hrs**)
- [ ] `FluxAlert` — Implement (Issue #29)
- [ ] `FluxToast` — Implement with `FluxToastService` (Issue #30)
- [ ] `FluxSnackbar` — Implement (Issue #31)
- [ ] `FluxProgress` — Implement (Issue #32)
- [ ] `FluxSkeleton` — Implement, depends on `FluxShimmer` (Issue #33)
- [ ] `FluxShimmer` — Implement (Issue #34)
- [ ] `FluxSpinner` — Implement (Issue #35)

## Phase 3: Navigation & Layout (Priority: High, ~28 hrs)

### Milestone 3.1 — Navigation (12 hrs)
- [ ] `FluxTabs` — Implement (Issue #40)
- [ ] `FluxAccordion` — Implement (Issue #41)
- [ ] `FluxBreadcrumb` — Implement (Issue #42)
- [ ] `FluxPagination` — Implement (Issue #43)
- [ ] `FluxNavigationRail` — Implement (Issue #44)
- [ ] `FluxDrawer` — Implement (Issue #45)
- [ ] `FluxStepper` — Implement (Issue #62)
- [ ] `FluxSidebar` — Implement (Issue #62)

### Milestone 3.2 — Layout (12 hrs)
- [ ] `FluxResponsiveLayout` — Implement (Issue #60)
- [ ] `FluxAdaptiveLayout` — Implement (Issue #61)
- [ ] `FluxGrid` — Implement (Issue #51)
- [ ] `FluxMasonry` — Implement (Issue #50)
- [ ] `FluxStack` — Implement (Issue #52)
- [ ] `FluxOverlay` — Implement (Issue #53)
- [ ] `FluxGap` — Implement (Issue #65)
- [ ] `FluxSafeArea` — Implement (Issue #66)
- [ ] `FluxConstrainedBox` — Implement (Issue #67)

## Phase 4: Overlay & Feedback (Priority: Medium, ~22 hrs)

### Milestone 4.1 — Modal Components (8 hrs)
- [ ] `FluxDialog` — Implement with focus trapping (Issue #36)
- [ ] `FluxBottomSheet` — Implement with snap points (Issue #37)
- [ ] `FluxPopover` — Implement with positioning (Issue #38)
- [ ] `FluxTooltip` — Implement with delays (Issue #39)

### Milestone 4.2 — Empty & Error States (6 hrs)
- [ ] `FluxEmptyState` — Implement (Issue #55)
- [ ] `FluxErrorState` — Implement (Issue #56)
- [ ] `FluxLoading` — Implement (Issue #59)
- [ ] `FluxHero` — Implement (Issue #57)
- [ ] `FluxBanner` — Implement (Issue #58)

## Phase 5: Data Display (Priority: Medium, ~22 hrs)

### Milestone 5.1 — Table & Timeline (12 hrs)
- [ ] `FluxTable<T>` — Implement with generics, sortable, selectable (Issue #46)
- [ ] `FluxTimeline` — Implement (Issue #47)
- [ ] Sliver variants (Issue #85)

### Milestone 5.2 — Carousel & Image (10 hrs)
- [ ] `FluxCarousel` — Implement with auto-play (Issue #48)
- [ ] `FluxImage` — Implement with placeholder (Issue #49)

## Phase 6: Animation & Polish (Priority: Medium, ~16 hrs)

### Milestone 6.1 — Transition System (8 hrs)
- [ ] `FadeTransition` wrapper
- [ ] `SlideTransition` wrapper
- [ ] `ScaleTransition` wrapper
- [ ] `SpringAnimation` wrapper
- [ ] `SharedAxisTransition` (Hero-like)
- [ ] Page transition theme
- [ ] `FluxAnimatedVisibility` — already in primitives

### Milestone 6.2 — Effects (8 hrs)
- [ ] `RippleEffect` — Material ripple
- [ ] `GlassEffect` — Frosted glass blur
- [ ] `FluxGradients` — Gradient utilities
- [ ] `FluxShadows` — Shadow painting

## Phase 7: Documentation & Release (Priority: Medium, ~30 hrs)

### Milestone 7.1 — Documentation (12 hrs)
- [x] Component markdown files in `docs/components/`
- [x] API reference
- [ ] **Enhance all component docs** with: testing, accessibility, migration notes (Issue #81)
- [ ] **Migration guide** from Material/Cupertino (Issue #79)
- [ ] **Example app** exercising all components (Issue #80)

### Milestone 7.2 — Testing (10 hrs)
- [x] Unit tests for tokens and utils
- [ ] **Widget tests for all components** (Issue #76)
- [ ] **Golden tests for visual regression** (Issue #75)
- [ ] **Accessibility tests** (Issue #88)
- [ ] **Performance benchmarks** (Issue #82)

### Milestone 7.3 — Infrastructure (8 hrs)
- [ ] **CI/CD Pipeline** (Issue #77)
- [ ] **Lint & Analysis** (Issue #78)
- [ ] **DevTools integration** — `debugFillProperties` on all widgets (Issue #83)
- [ ] **Restoration support** — `RestorationMixin` on all stateful widgets (Issue #86)
- [ ] **Hero / Shared element transitions** (Issue #87)

### Milestone 7.4 — Release (4 hrs)
- [ ] Publish to pub.dev
- [ ] GitHub release with changelog
- [ ] Release checklist (see `docs/publishing.md`)

## Effort Summary

| Phase | Old Hours | **New Hours** | Components | Dependencies |
|-------|-----------|--------------|------------|--------------|
| 1. Foundation | 20 | **32** | 8 milestones | None |
| 2. Core Components | 40 | **56** | 20+ components | Phase 1 |
| 3. Navigation & Layout | 24 | **28** | 12+ components | Phase 1 |
| 4. Overlay & Feedback | 16 | **22** | 8+ components | Phase 1–2 |
| 5. Data Display | 16 | **22** | 4+ components | Phase 1 |
| 6. Animation & Polish | 12 | **16** | 5 milestones | Phase 1 |
| 7. Documentation & Release | 16 | **30** | 3 milestones | Phase 2–6 |
| **Total** | **~144 hrs** | **~206 hrs** | **~70+ files** | |

> Adjusted estimates reflect: split theme extensions, lerp, primitives, migration guide, CI/CD, golden tests, accessibility audit, Flutter-native rewrite of React patterns, and documentation enhancement.

## Dependencies Graph

```
Phase 1 (Tokens + Theme + Primitives)
    ├── Phase 2 (Core Components)
    │   ├── Phase 3 (Navigation & Layout)
    │   ├── Phase 4 (Overlay & Feedback)
    │   └── Phase 5 (Data Display)
    ├── Phase 6 (Animation & Polish)
    └── Phase 7 (Documentation + Testing + CI)
```

## Parallel Work Tracks

| Track | Phases | Team |
|-------|--------|------|
| Theme & Primitives | Phase 1 | Lead engineer |
| Buttons + Inputs | Phase 2.1–2.2 | Engineer A |
| Feedback + Display | Phase 2.3–2.4 | Engineer B |
| Navigation | Phase 3.1 | Engineer C |
| Layout | Phase 3.2 | Engineer D |
| Overlays | Phase 4 | Engineer A |
| Data Display | Phase 5 | Engineer B |
| Animation | Phase 6 | Engineer C |
| Docs + Test + CI | Phase 7 | All (staggered) |

## Key Milestones

1. **MVP (Phase 1 complete)**: Library installable, themes working, all primitives ready
2. **Alpha (Phase 2 complete)**: All core components functional, tested
3. **Beta (Phase 3–5 complete)**: Production-ready full component set
4. **RC (Phase 6–7 complete)**: Full documentation, tests, CI, pub.dev release
5. **1.0**: Stable release on pub.dev
