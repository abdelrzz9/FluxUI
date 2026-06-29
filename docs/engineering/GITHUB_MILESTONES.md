# Flux UI — Milestone Planning

## Milestone Structure

```
Flux UI v1.0.0
├── M1: Foundation (Phase 1)
├── M2: Primitives (Phase 1b)
├── M3: Interactive Components (Phase 2a)
├── M4: Input & Display (Phase 2b)
├── M5: Feedback (Phase 2c)
├── M6: Navigation (Phase 3)
├── M7: Layout (Phase 3b)
├── M8: Overlays (Phase 4)
├── M9: Data Display (Phase 5)
├── M10: Animation & Polish (Phase 6)
├── M11: Testing & CI (Phase 6b)
├── M12: Documentation (Phase 7a)
├── M13: v1.0 Release (Phase 7b)
└── M14: Post-v1.0 (Future)

Each milestone = 2-4 weeks of work
Target: v1.0 in ~12 months
```

---

## Milestone 1: Foundation (Weeks 1-3)

**Goal**: Build the infrastructure that all other work depends on.

**Issues**:
- #1: `FluxPressable` — Base Interaction Primitive
- #2: `FluxFocusRing` — Reusable Focus Ring
- #3: `FluxAnimatedVisibility` — Enter/Exit Animation Wrapper
- #4: `FluxProvider` — Root Theme Provider
- #5: `FluxPortal` — Overlay Portal
- #6: `FluxIcon` — Icon Wrapper
- #7: `FluxText` — Typography Widget
- #68: Context Extensions Package
- #69: Widget Extensions
- #70: Color Utilities
- #71: Shadow Utilities
- #72: Animation Helpers
- #73: Typography Utilities
- #74: Shape Utilities
- #78: Lint & Analysis Configuration
- #84: Barrel Export Reorganization

**Dependencies**: None (new project)

**Estimated effort**: 32 hrs

**Deliverables**:
- All 7 primitives implemented and tested
- All utility extensions implemented
- Lint rules configured
- Import structure established

---

## Milestone 2: Theme System (Weeks 4-6)

**Goal**: Complete, testable theme system with all extensions.

**Issues**:
- #8: Split `FluxThemeData` into Focused Theme Extensions
- #9: Implement High Contrast Theme
- #10: Implement `lerp` for All Theme Extensions
- #11: Map Flux Tokens to M3 `ColorScheme`
- #12: Map Flux Tokens to M3 `TextTheme`
- #13: Dynamic Color / Material You Support
- #63: `FluxThemeProvider` — Theme Switcher
- #64: `FluxLocalizationProvider` — i18n Support
- #65: `FluxGap` — Fixed-Size Spacer
- #66: `FluxSafeArea` — Themed Safe Area
- #67: `FluxConstrainedBox` — Max-Width Container

**Dependencies**: M1 (primitives provide context extensions)

**Estimated effort**: 28 hrs

**Deliverables**:
- 11 focused `ThemeExtension` subclasses with `lerp`
- High contrast theme with WCAG AAA compliance
- Dynamic color from seed
- `FluxThemeProvider` with light/dark/system/highContrast modes
- Full M3 `ColorScheme` + `TextTheme` mapping

---

## Milestone 3: Interactive Components (Weeks 7-10)

**Goal**: Buttons, checkboxes, switches, radio, slider, OTP, dropdown menu.

**Issues**:
- #14: `FluxButton` — Refactor
- #15: `FluxCheckbox` — Refactor
- #16: `FluxInputOtp` — Refactor
- #17: `FluxDropdownMenu` — Flutter-Native Rewrite
- #18: `FluxSlider` — Implement
- #19: `FluxSwitch` — Refactor
- #20: `FluxRadio` — Refactor

**Dependencies**: M1 (primitives: FocusRing, Pressable), M2 (theme extensions)

**Estimated effort**: 40 hrs

**Deliverables**:
- All interactive components with WidgetStateProperty support
- Keyboard navigation, RTL, Semantics for all
- Widget tests + golden tests

---

## Milestone 4: Input & Display (Weeks 11-13)

**Goal**: Text fields, search, select, card, avatar, badge, chip, tag, divider.

**Issues**:
- #21: `FluxTextField` — Refactor
- #22: `FluxSearchField` — Refactor
- #23: `FluxSelect` — Refactor
- #24: `FluxCard` — Refactor
- #25: `FluxAvatar` — Refactor
- #26: `FluxBadge` — Refactor
- #27: `FluxChip` — Refactor
- #28: `FluxTag` — Refactor
- #54: `FluxDivider` — Refactor

**Dependencies**: M3 (interactive input patterns shared)

**Estimated effort**: 32 hrs

**Deliverables**:
- All input and display components
- Form integration patterns established
- Validation states, theming

---

## Milestone 5: Feedback (Weeks 14-16)

**Goal**: Alerts, toasts, snackbar, progress, skeleton, shimmer, spinner, loading.

**Issues**:
- #29: `FluxAlert` — Refactor
- #30: `FluxToast` — Refactor with `FluxToastService`
- #31: `FluxSnackbar` — Refactor
- #32: `FluxProgress` — Refactor
- #33: `FluxSkeleton` — Refactor
- #34: `FluxShimmer` — Refactor
- #35: `FluxSpinner` — Refactor
- #59: `FluxLoading` — Refactor

**Dependencies**: M1 (FluxPortal for Toast), M2 (theme)

**Estimated effort**: 24 hrs

**Deliverables**:
- All feedback components with enter/exit animations
- Toast queue/stack management
- Skeleton/shimmer loading patterns

---

## Milestone 6: Navigation (Weeks 17-20)

**Goal**: Tabs, accordion, breadcrumb, pagination, navigation rail, drawer, stepper, sidebar.

**Issues**:
- #40: `FluxTabs` — Refactor
- #41: `FluxAccordion` — Refactor
- #42: `FluxBreadcrumb` — Refactor
- #43: `FluxPagination` — Refactor
- #44: `FluxNavigationRail` — Refactor
- #45: `FluxDrawer` — Refactor
- #62: `FluxStepper` + `FluxSidebar` — Implement

**Dependencies**: M1 (AnimatedVisibility), M2 (theme)

**Estimated effort**: 32 hrs

**Deliverables**:
- Full navigation suite
- Keyboard navigation, RTL
- Responsive behavior (persistent vs temporary drawer)

---

## Milestone 7: Layout (Weeks 17-20, parallel with M6)

**Goal**: Responsive layout, adaptive layout, grid, masonry, stack, overlay, gap, safe area, constrained box.

**Issues**:
- #60: `FluxResponsiveLayout` — Refactor
- #61: `FluxAdaptiveLayout` — Refactor
- #51: `FluxGrid` — Refactor
- #52: `FluxStack` — Refactor
- #53: `FluxOverlay` — Refactor
- #50: `FluxMasonry` — Refactor
- #55: `FluxEmptyState` — Refactor
- #56: `FluxErrorState` — Refactor
- #57: `FluxHero` — Refactor
- #58: `FluxBanner` — Refactor

**Dependencies**: M1, M2

**Estimated effort**: 24 hrs

---

## Milestone 8: Overlays (Weeks 21-23)

**Goal**: Dialog, bottom sheet, popover, tooltip.

**Issues**:
- #36: `FluxDialog` — Refactor with focus trapping
- #37: `FluxBottomSheet` — Refactor with snap points
- #38: `FluxPopover` — Refactor with positioning
- #39: `FluxTooltip` — Refactor with delays

**Dependencies**: M1 (Portal, AnimatedVisibility), M2 (theme)

**Estimated effort**: 20 hrs

**Deliverables**:
- Complete overlay components with enter/exit animations
- Focus trapping, keyboard dismiss, responsive positioning
- All overlay tests passing

---

## Milestone 9: Data Display (Weeks 24-26)

**Goal**: Table, timeline, carousel, image.

**Issues**:
- #46: `FluxTable<T>` — Implement with generics
- #47: `FluxTimeline` — Implement
- #48: `FluxCarousel` — Implement
- #49: `FluxImage` — Implement
- #85: Sliver variant support

**Dependencies**: M2 (theme extensions for data components)

**Estimated effort**: 24 hrs

**Deliverables**:
- Sortable, selectable data table
- Vertical timeline with sliver variant
- Auto-play carousel
- Image with placeholder + hero support

---

## Milestone 10: Animation & Polish (Weeks 27-28)

**Goal**: Transition system, effects, shimmer refactor, animation utilities.

**Issues**:
- Transition wrappers (Fade, Slide, Scale, Spring, SharedAxis)
- Page transition theme
- RippleEffect
- GlassEffect
- FluxGradients
- FluxShadows

**Dependencies**: M1 (animation helpers)

**Estimated effort**: 16 hrs

**Deliverables**:
- Reusable transition wrappers
- Glass effect, gradient utilities
- Page transition theme for MaterialApp

---

## Milestone 11: Testing & CI (Weeks 29-30)

**Goal**: Complete test suite, CI/CD pipeline, DevTools integration.

**Issues**:
- #75: Testing Infrastructure — Golden Tests
- #76: Testing Infrastructure — Widget Tests
- #77: CI/CD Pipeline
- #82: Performance Benchmarks
- #83: Flutter DevTools Integration
- #86: Restoration Support
- #87: Hero / Shared Element Transitions
- #88: Accessibility Audit

**Dependencies**: M3-M10 (all components must exist)

**Estimated effort**: 40 hrs

**Deliverables**:
- Golden tests for all components
- CI pipeline with analyze, test, golden, build
- Performance benchmark infrastructure
- DevTools debuggability for all components
- Accessibility audit results

---

## Milestone 12: Documentation (Weeks 31-32)

**Goal**: Complete documentation, migration guides, example app.

**Issues**:
- #79: Documentation — Migration Guide
- #80: Documentation — Example App
- #81: Documentation — Component Docs Enhancement

**Dependencies**: M3-M10 (all components documented)

**Estimated effort**: 32 hrs

**Deliverables**:
- Complete `docs/components/*.md` for every component
- Migration guide from Material/Cupertino
- Working example app showing all components
- Code snippets for every component

---

## Milestone 13: v1.0 Release (Week 33-34)

**Goal**: Finalize, publish, announce.

**Tasks**:
- [ ] Final API review
- [ ] Breaking change audit
- [ ] Complete CHANGELOG.md
- [ ] Migration guide v0.x → v1.0
- [ ] Pub.dev dry-run
- [ ] Publish to pub.dev
- [ ] GitHub release with release notes
- [ ] Announce on social channels
- [ ] Post-release retrospective

**Dependencies**: All previous milestones

**Estimated effort**: 16 hrs

---

## Milestone 14: Post-v1.0 (Future)

**Areas**:
- Web-specific optimizations
- Platform channels for native features
- `Cupertino`-style companion theme
- Advanced form validation library
- Database-backed state management integration
- Animation studio (visual animation editor)
- Desktop-specific components (menu bar, title bar, resizable panels)

---

## Milestone Timeline

```
Month 1-2   │ M1 (Foundation) │ M2 (Theme)
Month 2-3   │ M3 (Interactive)
Month 3-4   │ M4 (Input & Display)
Month 4-5   │ M5 (Feedback)
Month 5-7   │ M6 (Navigation) │ M7 (Layout)
Month 7-8   │ M8 (Overlays)
Month 8-9   │ M9 (Data Display)
Month 9-10  │ M10 (Animation, Polish) │ M11 (Testing, CI)
Month 10-11 │ M12 (Documentation)
Month 11-12 │ M13 (v1.0 Release)
            │
v1.0 ───────┼─────────────────────────────────────────►
```
