# Flux UI — GitHub Issues

> Generated from `docs/architecture/ARCHITECTURE_REVIEW.md`
> ~50 issues across components, primitives, utilities, theme, and project

---

## Batch 1: Primitives & Foundation (P0)

### Issue 1: `FluxPressable` — Base Interaction Primitive
**Priority**: P0 · **Est**: 4 hrs · **Deps**: None

Create a base interaction widget that handles hover, press, focus, and disabled states through a unified `WidgetState` pattern.

**Requirements**:
- [ ] Accept `WidgetStateProperty` for all style properties (background, foreground, elevation, etc.)
- [ ] Handle `MouseRegion` for hover effects on desktop
- [ ] Handle `Focus` node with `onFocusChange` callback
- [ ] Handle `GestureDetector` for press states (onTap, onLongPress, etc.)
- [ ] Expose `WidgetState` set for consumers to build custom visual feedback
- [ ] Accept `onHover`, `onPressIn`, `onPressOut` callbacks
- [ ] Manage cursor changes via `SystemMouseCursors`
- [ ] Include `Semantics` wrapper for accessibility
- [ ] Include `debugFillProperties` override

**Design**: Similar to Material's `InkWell` but generic and not tied to Material ripple. Renamed from `FluxRipple` concept — this is the core primitive; ripple is a visual effect layered on top.

---

### Issue 2: `FluxFocusRing` — Reusable Focus Ring
**Priority**: P0 · **Est**: 2 hrs · **Deps**: None

A widget that paints a focus ring around any child when focused.

**Requirements**:
- [ ] Accept `FocusNode` or listen to `Focus.of(context)`
- [ ] Use `InkWell` or custom `Decoration` for ring painting
- [ ] Support configurable: `color`, `width`, `gap`, `borderRadius`, `animationDuration`
- [ ] Read defaults from `FluxAnimationTheme` and `FluxColorTheme`
- [ ] Animate ring appearance/disappearance
- [ ] Support `WidgetState` to match `FluxPressable` disabled state
- [ ] Use `CompositedTransformFollower`/`Leader` for overlay rendering (no layout shift)

**Design**: Should work as a standalone wrapper or be composable inside `FluxPressable`.

---

### Issue 3: `FluxAnimatedVisibility` — Enter/Exit Animation Wrapper
**Priority**: P0 · **Est**: 3 hrs · **Deps**: `FluxAnimationTheme`

An `AnimatedSwitcher`-like widget with configurable enter/exit transitions mirroring shadcn's `animate-in` / `animate-out` CSS classes.

**Requirements**:
- [ ] Support animation types: `fade`, `scale`, `slide` (up/down/left/right), `size`
- [ ] Accept different `enter` and `exit` animation configs
- [ ] Accept `FluxAnimationDurations` and `FluxAnimationCurves`
- [ ] Accept `onEntered` / `onExited` callbacks
- [ ] Support `keepAlive` option to preserve child state during exit animation
- [ ] Support `animateFirst` flag to skip animation on first mount (default: true)
- [ ] Work with `FluxPortal` for overlay animations
- [ ] Use `AnimatedSwitcher` or custom `AnimatedList`/`AnimatedCrossFade` internally
- [ ] Include `debugFillProperties`

---

### Issue 4: `FluxProvider` — Root Theme Provider
**Priority**: P0 · **Est**: 3 hrs · **Deps**: Theme extensions

Root widget that provides `FluxThemeData` and optional overrides to the entire widget subtree.

**Requirements**:
- [ ] Wraps `MaterialApp` or `Theme` with Flux theme
- [ ] Accept `FluxThemeData?` for overrides
- [ ] Accept `brightness` override  
- [ ] Accept `locale` for RTL support
- [ ] Automatically configure `Directionality`
- [ ] Expose `MediaQuery` overrides for responsive breakpoints
- [ ] Register all theme extensions in `ThemeData.extensions`
- [ ] Support `copyWith` for immutable updates

---

### Issue 5: `FluxPortal` — Overlay Portal
**Priority**: P0 · **Est**: 3 hrs · **Deps**: None

A portal widget for rendering children in an `OverlayEntry`, matching React's `createPortal`.

**Requirements**:
- [ ] Insert child into nearest `Overlay`
- [ ] Accept `OverlayEntry` configuration (opaque, maintainState, etc.)
- [ ] Support `onTapOutside` for dismiss behavior
- [ ] Accept `enter`/`exit` transitions via `FluxAnimatedVisibility`
- [ ] Manage z-index ordering
- [ ] Support nested portals
- [ ] Remove entry from overlay when disposed

---

### Issue 6: `FluxIcon` — Icon Wrapper
**Priority**: P0 · **Est**: 1 hr · **Deps**: `FluxColorTheme`, `FluxIconTheme`

A wrapper for `Icon`/`IconData` that reads color and size from theme.

**Requirements**:
- [ ] Accept `FluxIconData` (wrapper over `IconData`) or standard `IconData`
- [ ] Accept optional `color` override
- [ ] Accept optional `size` override (default from theme)
- [ ] Accept `semanticLabel`
- [ ] Accept `applyTextScaleFactor` option
- [ ] Support `WidgetState` for dynamic sizing/coloring

---

### Issue 7: `FluxText` — Typography Widget
**Priority**: P0 · **Est**: 2 hrs · **Deps**: `FluxTypographyTheme`

A typography widget that maps `header-*` / `paragraph-*` tokens to Flutter `TextStyle`.

**Requirements**:
- [ ] Accept `FluxTextVariant` enum (`headerXl` ... `paragraphXs`)
- [ ] Accept optional `color` from `FluxColorTheme`
- [ ] Accept optional `alignment`, `maxLines`, `overflow`, `softWrap`
- [ ] Accept `semanticLabel`
- [ ] Map variants to `TextStyle` from theme automatically
- [ ] Support `textScaleFactor` from `MediaQuery`
- [ ] Include `locale` for RTL support

---

## Batch 2: Theme System (P0)

### Issue 8: Split `FluxThemeData` into Focused Theme Extensions
**Priority**: P0 · **Est**: 8 hrs · **Deps**: All tokens

Break the monolithic `FluxThemeData` into separate `ThemeExtension` subclasses for lazy loading and testability.

**Requirements**:
- [ ] Create `FluxColorTheme` — color tokens (`ThemeExtension`)
- [ ] Create `FluxTypographyTheme` — text styles
- [ ] Create `FluxShapeTheme` — border radii
- [ ] Create `FluxSpacingTheme` — spacing scale
- [ ] Create `FluxShadowTheme` — elevation/shadows
- [ ] Create `FluxAnimationTheme` — durations and curves
- [ ] Create `FluxButtonTheme` — button-specific tokens
- [ ] Create `FluxCardTheme` — card-specific tokens
- [ ] Create `FluxInputTheme` — input-field specific tokens
- [ ] Create `FluxNavigationTheme` — navigation-specific tokens
- [ ] Create `FluxOverlayTheme` — overlay-specific tokens
- [ ] Each must implement `lerp()` and `hashCode`/`==`
- [ ] Each must include `copyWith` and `merge`
- [ ] Register all in `ThemeData.extensions` via `FluxProvider`
- [ ] Provide context extensions on `BuildContext` for each (`context.fluxColors`, etc.)
- [ ] Update all components to read only their specific extension (not the monolithic one)

---

### Issue 9: Implement High Contrast Theme
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

Create a high-contrast theme variant ensuring WCAG AAA compliance (7:1 contrast ratio for all text).

**Requirements**:
- [ ] Generate `FluxHighContrastTheme` with contrast-optimized colors
- [ ] Override all `FluxColorTheme` tokens to meet 7:1 ratio
- [ ] Increase border widths for visual clarity
- [ ] Increase focus ring size
- [ ] Add `isHighContrast` flag to `BuildContext` extension
- [ ] Support `MediaQuery.highContrast` for automatic activation
- [ ] Test with accessibility checker

---

### Issue 10: Implement `lerp` for All Theme Extensions
**Priority**: P0 · **Est**: 4 hrs · **Deps**: Issue #8

Add smooth theme animation support by implementing `lerp` across all theme extensions.

**Requirements**:
- [ ] Add `lerp` to `FluxColorTheme` (lerp each color independently)
- [ ] Add `lerp` to `FluxTypographyTheme` (lerp each `TextStyle`)
- [ ] Add `lerp` to `FluxShapeTheme` (lerp each radius)
- [ ] Add `lerp` to `FluxSpacingTheme` (lerp each spacing)
- [ ] Add `lerp` to `FluxShadowTheme` (lerp each shadow offset/blur)
- [ ] Add `lerp` to `FluxAnimationTheme` (lerp each duration/curve)
- [ ] Write unit tests for all lerp methods
- [ ] Ensure `t` parameter is in range `0.0..1.0`

---

### Issue 11: Map Flux Tokens to Material 3 ColorScheme
**Priority**: P0 · **Est**: 2 hrs · **Deps**: Issue #8

Map every Flux color token to a `ColorScheme` property for seamless Material 3 integration.

**Requirements**:
- [ ] Map `primary` ↔ `ColorScheme.primary`
- [ ] Map `primaryForeground` ↔ `ColorScheme.onPrimary`
- [ ] Map `secondary` ↔ `ColorScheme.secondary`
- [ ] Map `secondaryForeground` ↔ `ColorScheme.onSecondary`
- [ ] Map `background` ↔ `ColorScheme.surface`
- [ ] Map `foreground` ↔ `ColorScheme.onSurface`
- [ ] Map `destructive` ↔ `ColorScheme.error`
- [ ] Map `destructiveForeground` ↔ `ColorScheme.onError`
- [ ] Map `surface` ↔ `ColorScheme.surfaceContainerLow`
- [ ] Map `muted` ↔ `ColorScheme.surfaceContainerHigh`
- [ ] Map `border` ↔ `ColorScheme.outlineVariant`
- [ ] Map `ring` ↔ `ColorScheme.outline`
- [ ] Map `chart-1..5` ↔ `ColorScheme.tertiary` etc.
- [ ] Document mapping in THEMES.md

---

### Issue 12: Map Flux Typography to Material 3 TextTheme
**Priority**: P0 · **Est**: 1 hr · **Deps**: Issue #8

Map every header/paragraph token to a `TextTheme` style.

**Requirements**:
- [ ] `header-xl` → `displayLarge`
- [ ] `header-lg` → `displayMedium`
- [ ] `header-md` → `displaySmall`
- [ ] `header-sm` → `headlineLarge`
- [ ] `header-xs` → `headlineMedium`
- [ ] `paragraph-xl` → `titleLarge`
- [ ] `paragraph-lg` → `titleMedium`
- [ ] `paragraph-md` → `bodyLarge`
- [ ] `paragraph-sm` → `bodyMedium`
- [ ] `paragraph-xs` → `bodySmall`
- [ ] Add optional `monospace` font family token
- [ ] Document mapping in THEMES.md

---

### Issue 13: Dynamic Color / Material You Support
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #8, #11

When `useMaterial3: true`, disable brand themes and derive tokens from `ColorScheme.fromSeed()`.

**Requirements**:
- [ ] Detect `useMaterial3` flag
- [ ] When `dynamicColor: true`, call `ColorScheme.fromSeed(seedColor: ...)` 
- [ ] Map M3 `ColorScheme` back to Flux color tokens
- [ ] Disable brand theme overrides when dynamic color is active
- [ ] Support `tonalSurface` option (M3 surface tint)
- [ ] Add `FluxDynamicColorConfig` with `seedColor`, `contrastLevel`, `isDark` options

---

## Batch 3: Component Issues (P0–P2)

### Issue 14: `FluxButton` — Refactor for Flutter Idioms
**Priority**: P0 · **Est**: 6 hrs · **Deps**: Issue #1, #2, #8

Refactor `FluxButton` to use Flutter-native patterns.

**Requirements**:
- [ ] Replace `leading`/`trailing` → `icon`/`trailing` consistent with Material naming
- [ ] Change `loading: bool` → `loading: Widget?` for custom loader
- [ ] Change `destructive: bool` → add `FluxButtonVariant.destructive`
- [ ] Make `child` optional when `icon` is used as icon-only
- [ ] Integrate `FluxPressable` for interaction states
- [ ] Integrate `FluxFocusRing` for keyboard navigation
- [ ] Accept `WidgetStateProperty` for style overrides
- [ ] Accept `FocusNode` and `onFocusChange`
- [ ] Add `styleFrom()` static factory matching Material pattern
- [ ] Add `FluxButtonTheme` extension for button-specific tokens
- [ ] Add `debugFillProperties` for DevTools
- [ ] Remove `copyWith` from widget (non-idiomatic in Flutter)
- [ ] Support `Hero` tag for shared element transitions
- [ ] Write widget tests for all variants and states
- [ ] Write golden tests for visual regression

---

### Issue 15: `FluxCheckbox` — Refactor
**Priority**: P0 · **Est**: 4 hrs · **Deps**: Issue #1, #2, #8

**Requirements**:
- [ ] Replace `FluxSize.md` with `FluxCheckboxSize` enum
- [ ] Change `text`/`supportText` to accept `Widget?` for label
- [ ] Add controlled + uncontrolled pattern
- [ ] Add `tristate` support with visual dash for indeterminate
- [ ] Integrate `FluxPressable`
- [ ] Integrate `FluxFocusRing`
- [ ] Accept `FocusNode` / `onFocusChange`
- [ ] Add `FluxCheckboxTheme` extension
- [ ] Add proper `Semantics` (checked/unchecked/mixed role)
- [ ] Use `EdgeInsetsDirectional` for RTL support
- [ ] Add `debugFillProperties`
- [ ] Add widget tests + golden tests

---

### Issue 16: `FluxInputOtp` — Refactor
**Priority**: P0 · **Est**: 4 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Add `FluxInputOtpTheme` extension
- [ ] Support `onCompleted` callback when all slots filled
- [ ] Support paste from clipboard
- [ ] Add `keyboardType` option (number, text, etc.)
- [ ] Add proper `Semantics` for each slot
- [ ] Support RTL layout
- [ ] Add `restorationId` for state preservation
- [ ] Add `debugFillProperties`
- [ ] Write widget tests + golden tests

---

### Issue 17: `FluxDropdownMenu` — Refactor for Flutter
**Priority**: P0 · **Est**: 8 hrs · **Deps**: Issue #5, #8

Rewrite using Flutter's `OverlayEntry` / `showMenu` instead of React's portal pattern.

**Requirements**:
- [ ] Use `FluxPortal` + `OverlayEntry` for dropdown positioning
- [ ] Create sub-widgets: `FluxDropdownMenu.item`, `.separator`, `.group`, `.checkboxItem`, `.radioItem`
- [ ] Support submenu nesting with proper positioning
- [ ] Accept `FluxDropdownMenuTheme` extension
- [ ] Support keyboard navigation (arrow keys, Enter, Escape)
- [ ] Support `onOpenChange` callback
- [ ] Use `FocusScope` for menu traversal
- [ ] Add proper `Semantics` (menu, menuitem roles)
- [ ] Add `FluxPopover` for hover-triggered submenus
- [ ] Add `debugFillProperties`
- [ ] Write widget tests

---

### Issue 18: `FluxSlider` — Implement
**Priority**: P1 · **Est**: 6 hrs · **Deps**: Issue #1, #2, #8

**Requirements**:
- [ ] Support single thumb and range (dual thumb) modes
- [ ] Support discrete (snap to values) and continuous modes
- [ ] Accept `min`, `max`, `step`, `divisions`
- [ ] Accept `value` / `values` for single/range
- [ ] Accept `onChanged`, `onChangeStart`, `onChangeEnd`
- [ ] Integrate `FluxPressable` for thumb interaction
- [ ] Integrate `FluxFocusRing` for keyboard adjustment
- [ ] Add `FluxSliderTheme` extension
- [ ] Add `Semantics` with `Slider` role
- [ ] Support RTL (reverse direction)
- [ ] Add tooltip on thumb for current value
- [ ] Add `debugFillProperties`

---

### Issue 19: `FluxSwitch` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #1, #2, #8

**Requirements**:
- [ ] Change `FluxSize.md` → `FluxSwitchSize` enum
- [ ] Accept `Widget?` for label
- [ ] Integrate `FluxPressable`
- [ ] Integrate `FluxFocusRing`
- [ ] Add `FluxSwitchTheme` extension
- [ ] Add `Semantics` with `Switch` role
- [ ] Animate thumb position and track color
- [ ] Use `WidgetStateProperty` for track/thumb colors
- [ ] Add `debugFillProperties`

---

### Issue 20: `FluxRadio` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #1, #2, #8

**Requirements**:
- [ ] Create `FluxRadioGroup` for managing radio state
- [ ] Change `FluxSize.md` → `FluxRadioSize` enum
- [ ] Accept `Widget?` for label
- [ ] Integrate `FluxPressable`
- [ ] Add `FluxRadioTheme` extension
- [ ] Add `Semantics` with `Radio` role
- [ ] Support controlled + uncontrolled
- [ ] Animate selected indicator
- [ ] Add `debugFillProperties`

---

### Issue 21: `FluxTextField` — Refactor
**Priority**: P0 · **Est**: 6 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Add `FluxTextFieldTheme` extension
- [ ] Support outlined and filled variants
- [ ] Support textarea (multiline)
- [ ] Support validation states: `none`, `error`, `success`, `warning`
- [ ] Accept `prefix` and `suffix` widgets
- [ ] Accept `counter` for character counting
- [ ] Support `password` toggle visibility
- [ ] Add proper `Semantics`
- [ ] Add `FocusNode` / `onFocusChange`
- [ ] Add `restorationId`
- [ ] Support keyboard type, action, and `onSubmitted`
- [ ] Add `debugFillProperties`

---

### Issue 22: `FluxSearchField` — Refactor
**Priority**: P2 · **Est**: 3 hrs · **Deps**: Issue #21

**Requirements**:
- [ ] Build on top of `FluxTextField`
- [ ] Add automatic search icon
- [ ] Add clear button when text is non-empty
- [ ] Add `onSearch` callback (debounced)
- [ ] Add `debounceDuration` parameter
- [ ] Support `onClear` callback

---

### Issue 23: `FluxSelect` — Refactor
**Priority**: P2 · **Est**: 5 hrs · **Deps**: Issue #17, #21

**Requirements**:
- [ ] Build on top of `FluxTextField` + `FluxDropdownMenu`
- [ ] Support single and multiple selection
- [ ] Show selected value(s) in the input area
- [ ] Support search/filter within dropdown
- [ ] Support `onCreate` custom option
- [ ] Support clearable selection
- [ ] Add `FluxSelectTheme` extension

---

### Issue 24: `FluxCard` — Refactor
**Priority**: P0 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support variants: `elevated`, `outlined`, `tonal`, `ghost`
- [ ] Add `FluxCardTheme` extension
- [ ] Accept `onTap` for clickable cards
- [ ] Integrate `FluxPressable` when `onTap` is provided
- [ ] Accept `Hero` tag for shared element transitions
- [ ] Accept `padding` override
- [ ] Add proper `Semantics`
- [ ] Add `debugFillProperties`

---

### Issue 25: `FluxAvatar` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support image, initials (from name), and fallback icon
- [ ] Support sizes: `sm`, `md`, `lg`, `xl`
- [ ] Support badge overlay via `FluxBadge`
- [ ] Accept `onTap` for clickable
- [ ] Add `FluxAvatarTheme` extension
- [ ] Accept `Hero` tag
- [ ] Add proper `Semantics`

---

### Issue 26: `FluxBadge` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support variants: `dot`, `count`, `icon`
- [ ] Support positions: `topRight`, `topLeft`, `bottomRight`, `bottomLeft`
- [ ] Support `maxCount` for overflow display (e.g., "99+")
- [ ] Support `color` variants: `primary`, `secondary`, `success`, `error`, `warning`
- [ ] Add `FluxBadgeTheme` extension
- [ ] Animate count changes

---

### Issue 27: `FluxChip` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support variants: `label`, `dismissible`, `selected`, `input`
- [ ] Accept `avatar` widget for leading avatar
- [ ] Accept `onDeleted` for dismissible chips
- [ ] Accept `onSelected` for selected chips
- [ ] Add `FluxChipTheme` extension
- [ ] Integrate `FluxPressable` for interactive chips
- [ ] Animate selection state

---

### Issue 28: `FluxTag` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support color variants: `primary`, `secondary`, `success`, `warning`, `error`, `info`
- [ ] Accept custom `color` override
- [ ] Small, compact design
- [ ] Add `FluxTagTheme` extension

---

### Issue 29: `FluxAlert` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support variants: `success`, `warning`, `error`, `info`
- [ ] Include icon, title, description, optional action
- [ ] Support dismissible variant
- [ ] Add `FluxAlertTheme` extension
- [ ] Add proper `Semantics` (alert role, live region)

---

### Issue 30: `FluxToast` — Refactor
**Priority**: P0 · **Est**: 4 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Manage queue of toasts via `FluxToastService` (singleton/InheritedWidget)
- [ ] Support variants: `success`, `error`, `info`, `warning`
- [ ] Support action button
- [ ] Support auto-dismiss with configurable duration
- [ ] Support stackable toasts
- [ ] Use `FluxPortal` for overlay rendering
- [ ] Use `FluxAnimatedVisibility` for enter/exit animations
- [ ] Support swipe-to-dismiss
- [ ] Add `FluxToastTheme` extension

---

### Issue 31: `FluxSnackbar` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Themed wrapper around Flutter's `SnackBar`
- [ ] Override `SnackBarTheme` from Flux tokens
- [ ] Support action button
- [ ] Support `duration`, `behavior`, `shape`, `elevation`

---

### Issue 32: `FluxProgress` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support `linear` and `circular` variants
- [ ] Support `determinate` (with value) and `indeterminate` modes
- [ ] Add `FluxProgressTheme` extension
- [ ] Animate value changes
- [ ] Add proper `Semantics` (progressbar role)
- [ ] Support size variants

---

### Issue 33: `FluxSkeleton` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support shapes: `text` (line), `circle`, `rectangle`
- [ ] Accept `width` and `height` overrides
- [ ] Use shimmer animation from `FluxShimmer`
- [ ] Add `FluxSkeletonTheme` extension
- [ ] Animate pulse/shimmer effect
- [ ] Accept `borderRadius` override

---

### Issue 34: `FluxShimmer` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Reusable shimmer/gradient animation widget
- [ ] Accept custom gradient colors
- [ ] Accept animation `duration` and `curve`
- [ ] Accept `direction` (left-to-right, top-to-bottom, etc.)
- [ ] Support `FluxShimmerTheme` extension
- [ ] Use `AnimatedBuilder` with `AnimationController`

---

### Issue 35: `FluxSpinner` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support sizes: `sm`, `md`, `lg`, `xl`
- [ ] Accept `color` override
- [ ] Add `FluxSpinnerTheme` extension
- [ ] Use `AnimationController` for rotation

---

### Issue 36: `FluxDialog` — Refactor
**Priority**: P0 · **Est**: 6 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Support variants: `alert`, `confirmation`, `custom`, `fullscreen`
- [ ] Use `FluxPortal` for overlay
- [ ] Use `FluxAnimatedVisibility` for enter/exit
- [ ] Support barrier dismissible option
- [ ] Accept `title`, `content`, `actions`, `icon`
- [ ] Support `onOpen`, `onClose` callbacks
- [ ] Add `FluxDialogTheme` extension
- [ ] Add proper `Semantics` (dialog role, modal)
- [ ] Manage focus trapping within dialog
- [ ] Handle Escape key to dismiss

---

### Issue 37: `FluxBottomSheet` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Support `standard` and `expanded` variants
- [ ] Support drag handle for grab gesture
- [ ] Support snap points (e.g., collapsed, half, expanded)
- [ ] Use `DraggableScrollableSheet` internally
- [ ] Use `FluxPortal` for overlay
- [ ] Use `FluxAnimatedVisibility` for animation
- [ ] Add `FluxBottomSheetTheme` extension
- [ ] Support `onOpen`, `onClose` callbacks

---

### Issue 38: `FluxPopover` — Refactor
**Priority**: P1 · **Est**: 6 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Support anchor positioning (top, bottom, left, right, center)
- [ ] Support alignment variants (start, center, end)
- [ ] Accept `FluxAnimatedVisibility` for transitions
- [ ] Use `FluxPortal` for overlay
- [ ] Support `onOpenChange` callback
- [ ] Support dismiss on click outside
- [ ] Use `CompositedTransformFollower`/`Leader` for positioning
- [ ] Add `FluxPopoverTheme` extension
- [ ] Support keyboard dismiss (Escape)

---

### Issue 39: `FluxTooltip` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Support rich content (not just text)
- [ ] Support all positions (top, bottom, left, right)
- [ ] Use `FluxPortal` for overlay
- [ ] Use `FluxAnimatedVisibility` for animation
- [ ] Support `showDelay` and `hideDelay`
- [ ] Support `onShow`, `onHide` callbacks
- [ ] Use `MouseRegion` for hover trigger
- [ ] Add `FluxTooltipTheme` extension

---

### Issue 40: `FluxTabs` — Refactor
**Priority**: P0 · **Est**: 5 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support `horizontal` and `vertical` orientations
- [ ] Support scrollable tabs
- [ ] Accept list of `FluxTab` items (title, icon, badge)
- [ ] Support `FluxTabs` content with automatic tab panel switching
- [ ] Animate indicator position
- [ ] Add `FluxTabsTheme` extension
- [ ] Add proper `Semantics` (tablist, tab, tabpanel roles)
- [ ] Keyboard navigation (arrow keys, Home, End)

---

### Issue 41: `FluxAccordion` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: Issue #3, #8

**Requirements**:
- [ ] Support `single` and `multiple` expand modes
- [ ] Accept list of `FluxAccordionItem` with title + content
- [ ] Use `FluxAnimatedVisibility` for expand/collapse
- [ ] Animate chevron rotation
- [ ] Add `FluxAccordionTheme` extension
- [ ] Support `onExpandedChange` callback

---

### Issue 42: `FluxBreadcrumb` — Refactor
**Priority**: P2 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Accept list of `FluxBreadcrumbItem` with label + optional link
- [ ] Support separator customization (default: `/`)
- [ ] Support icon separators
- [ ] Collapse on overflow (show ellipsis)
- [ ] Add proper `Semantics` (nav, breadcrumb roles)

---

### Issue 43: `FluxPagination` — Refactor
**Priority**: P2 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Support page number buttons with prev/next
- [ ] Support ellipsis for large page ranges
- [ ] Support sibling count (pages around current)
- [ ] Support boundary count (pages at start/end)
- [ ] Accept `total`, `current`, `onChanged`
- [ ] Add `FluxPaginationTheme` extension
- [ ] Add proper `Semantics`

---

### Issue 44: `FluxNavigationRail` — Refactor
**Priority**: P2 · **Est**: 4 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Vertical navigation rail for desktop
- [ ] Support icons, labels, badges
- [ ] Support collapsed/expanded states
- [ ] Add `FluxNavigationRailTheme` extension
- [ ] Use `FluxButton` for each nav item
- [ ] Support `selectedIndex` and `onChanged`

---

### Issue 45: `FluxDrawer` — Refactor
**Priority**: P1 · **Est**: 5 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Support left and right positioning
- [ ] Support persistent (always visible) and temporary (overlay) modes
- [ ] Use `FluxAnimatedVisibility` for slide animation
- [ ] Support swipe-to-open gesture
- [ ] Add `FluxDrawerTheme` extension

---

### Issue 46: `FluxTable` — Refactor
**Priority**: P1 · **Est**: 8 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Generic typing: `FluxTable<T>`
- [ ] Sortable columns with `onSort` callback
- [ ] Selectable rows with checkbox column
- [ ] Support horizontal scroll for many columns
- [ ] Support sticky header
- [ ] Support empty state
- [ ] Support loading state (show skeleton rows)
- [ ] Add `FluxTableTheme` extension
- [ ] Add proper `Semantics` (table, grid roles)

---

### Issue 47: `FluxTimeline` — Refactor
**Priority**: P2 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Vertical timeline with alternating left/right items
- [ ] Customizable dot/icon for each item
- [ ] Connector line between items
- [ ] Add `FluxTimelineTheme` extension
- [ ] Support `FluxSliverTimeline` for `CustomScrollView`

---

### Issue 48: `FluxCarousel` — Refactor
**Priority**: P2 · **Est**: 4 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Image carousel with dot indicators
- [ ] Support `PageView` or custom sliding animation
- [ ] Auto-play with configurable interval
- [ ] Support infinite loop
- [ ] Support `onPageChanged` callback
- [ ] Add `FluxCarouselTheme` extension

---

### Issue 49: `FluxImage` — Refactor
**Priority**: P2 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Optimized image with placeholder
- [ ] Support `Hero` tag
- [ ] Support loading, error, and empty states
- [ ] Support `fit`, `alignment`, `filterQuality`
- [ ] Use `FadeInImage` or `cached_network_image`

---

### Issue 50: `FluxMasonry` — Refactor
**Priority**: P2 · **Est**: 4 hrs · **Deps**: None

**Requirements**:
- [ ] Masonry grid layout with variable-height items
- [ ] Accept item count or list of widgets
- [ ] Support custom cross-axis count
- [ ] Support `SliverMasonryGrid` for `CustomScrollView`
- [ ] Animate item insertion/removal

---

### Issue 51: `FluxGrid` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: None

**Requirements**:
- [ ] Responsive grid similar to CSS Grid
- [ ] Support `columns`, `gap`, `padding` properties
- [ ] Auto-wrap children at breakpoints
- [ ] Support `SliverGrid` delegate
- [ ] Accept `FluxBreakpoint` for responsive column count

---

### Issue 52: `FluxStack` — Refactor
**Priority**: P1 · **Est**: 1 hr · **Deps**: None

**Requirements**:
- [ ] Stack overlapping items with alignment
- [ ] Wrapper around Flutter `Stack` with Flux defaults
- [ ] Accept `alignment` and `fit` from theme

---

### Issue 53: `FluxOverlay` — Refactor
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #3, #5, #8

**Requirements**:
- [ ] Modal overlay with dimming background
- [ ] Use `FluxPortal` for overlay layer
- [ ] Use `FluxAnimatedVisibility` for animation
- [ ] Support dismiss on backdrop tap
- [ ] Support `onDismiss` callback
- [ ] Manage focus trapping

---

### Issue 54: `FluxDivider` — Refactor
**Priority**: P1 · **Est**: 1 hr · **Deps**: Issue #8

**Requirements**:
- [ ] Support horizontal and vertical orientations
- [ ] Support label in horizontal mode (similar to `<hr>` with text)
- [ ] Add `FluxDividerTheme` extension

---

### Issue 55: `FluxEmptyState` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Icon, message, and optional action button
- [ ] Support custom illustration widget
- [ ] Add `FluxEmptyStateTheme` extension

---

### Issue 56: `FluxErrorState` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Error message with optional retry button
- [ ] Accept `error` object for detailed message
- [ ] Add `FluxErrorStateTheme` extension

---

### Issue 57: `FluxHero` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Large hero section for page headers
- [ ] Support background image with overlay
- [ ] Support title, subtitle, action buttons

---

### Issue 58: `FluxBanner` — Refactor
**Priority**: P2 · **Est**: 2 hrs · **Deps**: Issue #3, #8

**Requirements**:
- [ ] Top banner, dismissible
- [ ] Support variants: `info`, `success`, `warning`, `error`
- [ ] Use `FluxAnimatedVisibility` for slide-down animation

---

### Issue 59: `FluxLoading` — Refactor
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] Full-page loading overlay
- [ ] Use `FluxSpinner` or custom loader
- [ ] Support optional message below spinner
- [ ] Support `FluxLoadingTheme` extension

---

## Batch 4: Navigation & Layout Additional

### Issue 60: `FluxResponsiveLayout` — Refactor
**Priority**: P1 · **Est**: 4 hrs · **Deps**: `FluxBreakpoint` system

**Requirements**:
- [ ] Breakpoint-aware layout switching
- [ ] Support breakpoints: `xs` (0), `sm` (640), `md` (768), `lg` (1024), `xl` (1280), `xxl` (1536)
- [ ] Accept builders per breakpoint
- [ ] Use `LayoutBuilder` + `MediaQuery` for responsive detection
- [ ] Provide `FluxBreakpoint` enum and `BuildContext` extension

---

### Issue 61: `FluxAdaptiveLayout` — Refactor
**Priority**: P2 · **Est**: 2 hrs · **Deps**: None

**Requirements**:
- [ ] Platform-adaptive layout (material vs. cupertino)
- [ ] Detect `Theme.platform` or `defaultTargetPlatform`
- [ ] Switch between `FluxResponsiveLayout` and platform-specific widgets

---

### Issue 62: Missing Navigation Primitives — `FluxStepper`, `FluxSidebar`
**Priority**: P2 · **Est**: 4 hrs each · **Deps**: Issue #8

**Requirements**:
- `FluxStepper`: Step indicator with completed/active/pending states, optional labels, horizontal and vertical layout
- `FluxSidebar`: Responsive sidebar navigation, collapsible, with `FluxNavigationRail` integration

---

## Batch 5: Missing Providers & Layout

### Issue 63: `FluxThemeProvider` — Theme Switcher
**Priority**: P1 · **Est**: 3 hrs · **Deps**: Issue #4, #8

**Requirements**:
- [ ] InheritedWidget/ChangeNotifier for theme state
- [ ] Support `FluxThemeMode` enum: `light`, `dark`, `system`, `highContrast`
- [ ] Support brand switching
- [ ] Provide `FluxThemeNotifier` for consumers
- [ ] Persist theme preference (optional)

---

### Issue 64: `FluxLocalizationProvider` — i18n Support
**Priority**: P2 · **Est**: 4 hrs · **Deps**: Issue #4

**Requirements**:
- [ ] InheritedWidget for locale state
- [ ] Map Flux string catalog to translated strings
- [ ] Support `FluxLocalizationDelegate` for custom loaders
- [ ] Provide context extension: `context.fluxLocale.tr('key')`

---

### Issue 65: `FluxGap` — Fixed-Size Spacer
**Priority**: P1 · **Est**: 1 hr · **Deps**: None

**Requirements**:
- [ ] Fixed-size spacing widget (width/height from `FluxSpacingTheme`)
- [ ] Accept `FluxSpacingToken` or raw double
- [ ] Support `horizontal` and `vertical` variants
- [ ] Swifty SwiftUI `Spacer(frame:)` pattern

---

### Issue 66: `FluxSafeArea` — Themed Safe Area
**Priority**: P1 · **Est**: 1 hr · **Deps**: None

**Requirements**:
- [ ] Wrapper around `SafeArea` with Flux padding defaults
- [ ] Accept `FluxSpacingToken` for minimum padding

---

### Issue 67: `FluxConstrainedBox` — Max-Width Container
**Priority**: P1 · **Est**: 1 hr · **Deps**: `FluxBreakpoint`

**Requirements**:
- [ ] Constrain content to max-width (optimizing for readability)
- [ ] Support breakpoint-aware max widths
- [ ] Center content horizontally

---

## Batch 6: Missing Utilities

### Issue 68: Context Extensions Package
**Priority**: P0 · **Est**: 3 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] `context.fluxColors`, `context.fluxTypography`, etc. for all theme extensions
- [ ] `context.isDark`, `context.isRTL`
- [ ] `context.mediaQuery`, `context.screenWidth`, `context.screenHeight`
- [ ] `context.breakpoint` → `FluxBreakpoint`
- [ ] `context.isMobile`, `context.isTablet`, `context.isDesktop`
- [ ] `context.theme` → `ThemeData` shortcut

---

### Issue 69: Widget Extensions (Fluent API)
**Priority**: P1 · **Est**: 2 hrs · **Deps**: None

**Requirements**:
- [ ] `.paddingAll(value)`
- [ ] `.paddingSymmetric({h, v})`
- [ ] `.paddingOnly({l, t, r, b})`
- [ ] `.marginAll(value)` (via Container)
- [ ] `.sliver()` → wrap in `SliverToBoxAdapter`
- [ ] `.center()` → wrap in `Center`
- [ ] `.expanded()` → wrap in `Expanded`
- [ ] `.flexible()` → wrap in `Flexible`
- [ ] `.tooltip(message)` → wrap in `Tooltip`
- [ ] `.onTap(callback)` → wrap in `GestureDetector`

---

### Issue 70: Color Utilities
**Priority**: P1 · **Est**: 2 hrs · **Deps**: None

**Requirements**:
- [ ] `Color.darken(amount)` — darken by 0..1
- [ ] `Color.lighten(amount)` — lighten by 0..1
- [ ] `Color.isLight` → bool
- [ ] `Color.isDark` → bool
- [ ] `Color.withOpacity(opacity)` — typed convenience
- [ ] `Color.hex(String)` — parse from hex string
- [ ] `Color.lerp(Color a, Color b, double t)` — static
- [ ] `Color.hsl(H, S, L)` — create from HSL
- [ ] `List<Color>` gradient creation helpers

---

### Issue 71: Shadow Utilities
**Priority**: P1 · **Est**: 1 hr · **Deps**: Issue #8

**Requirements**:
- [ ] `FluxShadowSize` enum (xs through 3xl)
- [ ] `BoxDecoration.withShadow(FluxShadowTheme, FluxShadowSize)`
- [ ] `Material.withFluxShadow(FluxShadowTheme, FluxShadowSize)`

---

### Issue 72: Animation Helpers
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Issue #8

**Requirements**:
- [ ] `FluxAnimationDurations` — fastest (100ms), fast (150ms), normal (200ms), slow (300ms), slower (500ms)
- [ ] `FluxAnimationCurves` — default, spring, emphasis
- [ ] `FluxTweenBuilder` — generic tween builder
- [ ] `FluxDelayedAnimation` — delay + animate
- [ ] `FluxStaggeredAnimation` — multi-step animation

---

### Issue 73: Typography Utilities
**Priority**: P1 · **Est**: 1 hr · **Deps**: Issue #8

**Requirements**:
- [ ] `TextStyle.applyFluxStyle(FluxTypographyTheme)`
- [ ] `TextStyle.withFontFamily(String)`
- [ ] `TextStyle.withColor(Color)`

---

### Issue 74: Shape/RoundedRectangle Utilities
**Priority**: P1 · **Est**: 1 hr · **Deps**: Issue #8

**Requirements**:
- [ ] `FluxBorderRadius` — all radii from `FluxShapeTheme`
- [ ] `BorderRadiusGeometry.flux(FluxShapeTheme, 'md')` builder
- [ ] `RoundedRectangleBorder.flux(FluxShapeTheme, 'md')` builder

---

## Batch 7: Project-Level (P0)

### Issue 75: Testing Infrastructure — Golden Tests
**Priority**: P0 · **Est**: 8 hrs · **Deps**: None

**Requirements**:
- [ ] Set up `flutter_test` golden test infrastructure
- [ ] Create `test/goldens/` directory
- [ ] Add `flutter test --update-goldens` workflow
- [ ] Golden test for every component (all variants)
- [ ] Golden test for light and dark themes
- [ ] Golden test for RTL layout
- [ ] Golden test for high contrast
- [ ] GitHub Action to verify goldens on PR

---

### Issue 76: Testing Infrastructure — Widget Tests
**Priority**: P0 · **Est**: 8 hrs · **Deps**: None

**Requirements**:
- [ ] Widget tests for every component
- [ ] Test all variants, states, sizes
- [ ] Test interactive behaviors (tap, hover, focus, keyboard)
- [ ] Test edge cases (null values, empty lists, overflow)
- [ ] Test RTL behavior
- [ ] Test accessibility (semantics)
- [ ] Test with and without `FluxProvider`

---

### Issue 77: CI/CD Pipeline
**Priority**: P0 · **Est**: 6 hrs · **Deps**: None

**Requirements**:
- [ ] GitHub Actions: `ci.yml` for PR validation
- [ ] Jobs: `format` → `analyze` → `test` → `test:goldens` → `build`
- [ ] `publish-dry-run.yml` for manual publishing check
- [ ] Melos workflow integration
- [ ] Code coverage reporting (Codecov or Coveralls)
- [ ] Status badges in README

---

### Issue 78: Lint & Analysis Configuration
**Priority**: P0 · **Est**: 2 hrs · **Deps**: None

**Requirements**:
- [ ] Add `package:flutter_lints/flutter.yaml` as base
- [ ] Custom rules: `prefer_const_constructors`, `avoid_redundant_argument_values`, `use_super_parameters`, `require_trailing_commas`
- [ ] Add `always_use_package_imports` for clean imports
- [ ] Add `prefer_final_parameters` for constructor params
- [ ] Add `diagnostic_describe_all_properties` to ensure `debugFillProperties` on all widgets

---

### Issue 79: Documentation — Migration Guide
**Priority**: P1 · **Est**: 4 hrs · **Deps**: All components

**Requirements**:
- [ ] Migration guide from Material Design to Flux UI
- [ ] Migration guide from Cupertino to Flux UI
- [ ] Migration guide from shadcn/ui / React to Flux UI
- [ ] Per-component migration notes in each component doc

---

### Issue 80: Documentation — Example App
**Priority**: P1 · **Est**: 8 hrs · **Deps**: All components

**Requirements**:
- [ ] Working Flutter app in `apps/example/`
- [ ] Exercise every public widget
- [ ] Show all variants, states, and sizes
- [ ] Support light/dark/high-contrast toggle
- [ ] Support brand theme picker
- [ ] Support RTL toggle
- [ ] Include code snippets for each component
- [ ] Include interactive controls to change properties

---

### Issue 81: Documentation — Component Docs Enhancement
**Priority**: P1 · **Est**: 8 hrs · **Deps**: All components

**Requirements**:
- [ ] Every `docs/components/*.md` must include:
  - [ ] Description
  - [ ] API reference with all parameters
  - [ ] Usage examples (basic, all variants, custom theme)
  - [ ] Code snippets with Dart/Flutter
  - [ ] Accessibility notes
  - [ ] Testing notes
  - [ ] Migration notes (from Material/Cupertino)
  - [ ] Composition notes (with other Flux widgets)
- [ ] "All Properties" example for every component
- [ ] "Custom Theme" example for every component

---

### Issue 82: Performance — Benchmarks
**Priority**: P2 · **Est**: 6 hrs · **Deps**: All components

**Requirements**:
- [ ] `FlutterPerformance` benchmarks for each component
- [ ] Build time benchmarks
- [ ] Layout time benchmarks
- [ ] Paint time benchmarks
- [ ] Memory usage benchmarks
- [ ] Compare against Material widgets
- [ ] Add to CI as performance regression detection

---

### Issue 83: Flutter DevTools Integration
**Priority**: P1 · **Est**: 4 hrs · **Deps**: All widgets

**Requirements**:
- [ ] Every widget has `debugFillProperties` override with all key properties
- [ ] Theme extensions are inspectable in DevTools
- [ ] Add `DiagnosticsNode` for complex states
- [ ] Add `DiagnosticsProperty` for all enums and flags
- [ ] Ensure `toStringShort` and `toStringDeep` are useful

---

### Issue 84: Barrel Export Reorganization
**Priority**: P0 · **Est**: 2 hrs · **Deps**: None

**Requirements**:
- [ ] Create multi-level barrel exports:
  - `lib/flux_ui.dart` — everything (convenience)
  - `lib/flux_theme.dart` — theme only
  - `lib/flux_components.dart` — components only
  - `lib/flux_tokens.dart` — design tokens only
- [ ] Each barrel re-exports from `src/` subdirectories
- [ ] Document import paths in ARCHITECTURE.md

---

### Issue 85: Sliver Variant Support
**Priority**: P2 · **Est**: 4 hrs · **Deps**: All scrollable components

**Requirements**:
- [ ] Add `SliverFluxTable` for use in `CustomScrollView`
- [ ] Add `SliverFluxTimeline` for use in `CustomScrollView`
- [ ] Add `SliverFluxCarousel` for use in `CustomScrollView`
- [ ] Add `SliverFluxGrid` delegate for `CustomScrollView`
- [ ] Add `SliverFluxMasonry` delegate for `CustomScrollView`
- [ ] Add `SliverFluxEmptyState` / `SliverFluxErrorState`

---

### Issue 86: Restoration Support
**Priority**: P1 · **Est**: 3 hrs · **Deps**: All stateful components

**Requirements**:
- [ ] Add `RestorationMixin` to all stateful widgets
- [ ] Add `restorationId` property to every stateful component
- [ ] Preserve scroll position, selection, input values, open/close states
- [ ] Widget tests verifying restoration behavior

---

### Issue 87: Hero / Shared Element Transitions
**Priority**: P1 · **Est**: 2 hrs · **Deps**: Card, Image, Avatar, Dialog

**Requirements**:
- [ ] Add `heroTag` property to `FluxCard`, `FluxImage`, `FluxAvatar`, `FluxDialog`
- [ ] Create `FluxHero` wrapper widget
- [ ] Document shared element transition patterns
- [ ] Example in the example app

---

### Issue 88: Accessibility Audit
**Priority**: P1 · **Est**: 6 hrs · **Deps**: All components

**Requirements**:
- [ ] Audit every component for `Semantics` compliance
- [ ] Ensure all interactive elements have proper roles (button, checkbox, slider, tab, etc.)
- [ ] Ensure all labels are localized
- [ ] Ensure keyboard navigation works for all widgets
- [ ] Ensure focus order is logical
- [ ] Test with screen readers (TalkBack, VoiceOver)
- [ ] Test with high contrast mode
- [ ] Test with large font sizes
- [ ] Add `flutter test --integration` accessibility tests
- [ ] Document accessibility in each component doc

---

## Summary

| Batch | Issues | Focus |
|-------|--------|-------|
| 1 | #1–#7 | Primitives & Foundation |
| 2 | #8–#13 | Theme System |
| 3 | #14–#59 | All Component Refactors |
| 4 | #60–#62 | Navigation & Layout |
| 5 | #63–#67 | Missing Providers & Layout |
| 6 | #68–#74 | Missing Utilities |
| 7 | #75–#88 | Project-Level Infrastructure |

**Total: 88 issues**
