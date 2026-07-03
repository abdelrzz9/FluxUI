# Flux UI — Architecture Review & Improvements

## Part 1: Architecture Issues Found

### Issue 1.1 — Flat Component Directory
**Problem**: All 42 components in a single `components/` directory. No sub-categorization.
**Fix**: Use sub-directories matching the React source's organizational categories:
```
components/
  inputs/          # TextField, SearchField, Select, Slider, Switch, Checkbox, Radio, OTP
  buttons/         # Button, IconButton, FAB, ButtonGroup
  navigation/      # Tabs, Accordion, Breadcrumb, Pagination, NavigationRail, Drawer
  surfaces/        # Card, Surface, Accordion, Carousel
  feedback/        # Alert, Toast, Snackbar, Progress, Skeleton, Shimmer, Spinner, Loading
  overlay/         # Dialog, BottomSheet, Popover, Tooltip, Drawer, Overlay
  data-display/    # Table, Timeline, Avatar, Badge, Chip, Tag, Divider, Image
  layout/          # Grid, Masonry, Stack, Hero, Banner, EmptyState, ErrorState
```
**Migration Impact**: Low — only moves file paths; exports remain unchanged via barrel.

### Issue 1.2 — No Widget Sub-Components Pattern
**Problem**: Components like DropdownMenu define sub-widgets (Item, Separator, Group, etc.) but the architecture doesn't prescribe a naming convention.
**Fix**: Use the `.` accessor pattern via static methods or top-level classes:
- `FluxDropdownMenu` — root
- `FluxDropdownMenu.item(...)` — item
- `FluxDropdownMenu.separator(...)` — separator
Or use dedicated files per sub-component in a directory:
```
flux_dropdown_menu/
  __init__.dart
  flux_dropdown_menu.dart
  flux_dropdown_item.dart
  flux_dropdown_separator.dart
  flux_dropdown_content.dart
```
**Preference**: Top-level classes with `Flux` prefix for discoverability. Avoid nested classes in Dart — they cause verbose usage.

### Issue 1.3 — Theme Extension Architecture
**Problem**: `FluxThemeData` is a single monolithic extension. This prevents tree-shaking and forces users to import everything.
**Fix**: Split into focused `ThemeExtension` sub-classes:
- `FluxColorTheme` — color tokens
- `FluxTypographyTheme` — text styles
- `FluxShapeTheme` — border radii
- `FluxSpacingTheme` — spacing scale
- `FluxShadowTheme` — elevation/shadows
- `FluxAnimationTheme` — durations and curves
- `FluxButtonTheme` — button-specific tokens
- `FluxCardTheme` — card-specific tokens
- ... one per component family

Each component reads only its own theme extension. This enables lazy loading and better testability.

### Issue 1.4 — `FluxSize` Enum as Global
**Problem**: `FluxSize.md` is globally defined but `md` means different sizes per component (checkbox md=20px, button md=32px, input md=40px).
**Fix**: Make sizes component-specific:
```dart
enum FluxButtonSize { sm, md, lg, xl }
enum FluxCheckboxSize { sm, md }
```
Or use the global enum only as a naming convention, with actual dimensions resolved per component via theme.

**Better**: Use `FluxComponentSize` as a marker interface; let each component define its own size values.

### Issue 1.5 — Missing State Management Pattern
**Problem**: No prescribed pattern for controlled vs. uncontrolled components.
**Fix**: Follow Flutter's established pattern:
```dart
// Controlled
FluxCheckbox(
  value: isChecked,
  onChanged: (v) => setState(() => isChecked = v),
)

// Uncontrolled (internal state)
FluxCheckbox(
  initialValue: false,
  onChanged: (v) => print(v),
)
```
Document that all form-like components offer both patterns.

### Issue 1.6 — Missing Restoration Support
**Problem**: No mention of `RestorationMixin` for preserving widget state across hot reload / app lifecycle.
**Fix**: Add `RestorationMixin` to stateful components. Use `restorationId` property.

### Issue 1.7 — `copyWith` on Widgets Anti-Pattern
**Problem**: Previous architecture proposed `copyWith` on widgets. In Flutter, widgets are immutable configuration descriptions — `copyWith` on a widget is non-idiomatic (unlike React where components are long-lived).
**Fix**: Remove `copyWith` from widget interfaces. Instead:
- Use `Theme` / `InheritedWidget` for style overrides
- Use constructor parameters for configuration
- Use `FluxButton.styleFrom()` static method (matching Material pattern)

### Issue 1.8 — Barrel Export Structure
**Problem**: Single `lib/flux_ui.dart` barrel exports everything. No granular imports.
**Fix**: Multi-level barrel exports:
```dart
lib/
  flux_ui.dart                    # Everything (convenience)
  flux_theme.dart                 # Theme only
  flux_components.dart            # Components only
  flux_tokens.dart                # Design tokens only
  src/
    flux_button.dart              # Or just rely on top-level
    flux_checkbox.dart
```
All top-level files re-export from `src/` subdirectories. Users can `import 'package:flux_ui/flux_ui.dart'` for convenience or import specific modules.

---

## Part 2: Flutter Best Practices Audit

### 2.1 — Const Constructors
All widgets MUST have `const` constructors. Already specified. Verify via lint rule `prefer_const_constructors`.

### 2.2 — Immutable Classes
All configuration classes (themes, styles, tokens) must use `@immutable` annotation and `final` fields.

### 2.3 — Diagnostics
Every widget should override `debugFillProperties` to show key properties in Flutter DevTools:
```dart
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  properties.add(EnumProperty<FluxButtonVariant>('variant', variant));
  properties.add(DiagnosticsProperty<bool>('loading', loading));
}
```

### 2.4 — WidgetStateProperty Support
Interactive components (Button, Checkbox, Switch, etc.) should accept `WidgetStateProperty` for state-dependant styling:
```dart
FluxButton(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) return Colors.blue[700];
      if (states.contains(WidgetState.pressed)) return Colors.blue[800];
      return Colors.blue;
    }),
  ),
)
```

### 2.5 — Focus & Keyboard Navigation
All interactive widgets must:
- Accept `FocusNode` parameter
- Support `onFocusChange` callback
- Use `Focus` / `FocusScope` for keyboard traversal
- Implement `Actions` / `Shortcuts` for keyboard handlers

### 2.6 — Semantics
Every widget must include:
```dart
Semantics(
  label: semanticLabel,
  enabled: !disabled,
  button: true,
  onTap: onPressed != null ? () => onPressed?.call() : null,
  child: ...
)
```

### 2.7 — MouseRegion for Hover
Desktop hover effects must use `MouseRegion`:
```dart
MouseRegion(
  onEnter: ...,
  onExit: ...,
  cursor: disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
  child: ...
)
```

### 2.8 — RTL Support
All directional widgets must use `Directionality` and respond to RTL. Use `TextDirection` from context. Avoid hard-coded `EdgeInsets.only(left: ...)` — use `EdgeInsetsDirectional` instead.

### 2.9 — Localization Readiness
All user-facing strings (labels, hints, error messages) should accept `String?` with fallback to default locale. Use `MaterialLocalizations` where appropriate.

### 2.10 — Null Safety
All code must be sound null safety. Use `required` for mandatory parameters. Avoid `late` where possible.

### 2.11 — Generic Typing
Data-display components (Table, Select) should use generics:
```dart
class FluxTable<T> extends StatelessWidget {
  final List<FluxColumn<T>> columns;
  final List<FluxRow<T>> rows;
  ...
}
```

### 2.12 — Lint Compliance
Add `package:flutter_lints/flutter.yaml` as base. Add custom rules:
- `prefer_const_constructors`
- `avoid_redundant_argument_values`
- `use_super_parameters`
- `require_trailing_commas`

### 2.13 — Sliver Support
Scrollable components (Table, Timeline, Carousel) should offer `Sliver` variants for use in `CustomScrollView`.

### 2.14 — Hero Support
Navigation-aware components (Card, Image) should support `Hero` tag for shared element transitions.

### 2.15 — Hit Test Behavior
Overlay components (Popover, Tooltip, Dialog) must manage hit testing correctly — tapping outside should dismiss the overlay. Use `Stack` with `Positioned` + `GestureDetector` on barrier.

---

## Part 3: Public API Review

### 3.1 — Button API Issues
| Issue | Current | Fix |
|-------|---------|-----|
| `leading`/`trailing` naming | React naming | Use `icon` and `trailing` consistent with Material |
| `loading` as bool | Works but can't customize | Change to `loading: Widget?` — pass custom loader |
| `destructive` as bool | Boolean flag | Promote to variant: `FluxButtonVariant.destructive` |
| `child` required | Makes icon-only awkward | Make `child` optional when `icon` is `only` |

### 3.2 — Checkbox API Issues
| Issue | Current | Fix |
|-------|---------|-----|
| `text` + `supportText` | Strings only | Accept `Widget?` for label customization |
| `size` | Global `FluxSize` | Use `FluxCheckboxSize` |
| Missing `tristate` visual | Tristate uses dash | Must document the visual for indeterminate |

### 3.3 — DropdownMenu API Issues
| Issue | Current | Fix |
|-------|---------|-----|
| React port (`MenuPrimitive`) | Too low-level | Use Flutter's `showMenu` or custom `OverlayEntry` |
| Submenu nesting | Inline children | Flutter submenus need different positioning |

### 3.4 — All Components: Use `required` Properly
- `child` should almost always be `required` (or `children` for lists)
- `onPressed` should be optional (for disabled state)
- `value` / `initialValue` for stateful components

---

## Part 4: Theme System Review

### 4.1 — Missing Lerp
`ThemeExtension` subclasses MUST implement `lerp` for smooth theme transitions.

### 4.2 — ColorScheme Mapping
Map every Flux color token to a `ColorScheme` color:
| Flux Token | ColorScheme Property |
|-----------|---------------------|
| `--primary` | `primary` |
| `--primary-foreground` | `onPrimary` |
| `--secondary` | `secondary` |
| `--secondary-foreground` | `onSecondary` |
| `--background` | `surface` |
| `--foreground` | `onSurface` |
| `--destructive` | `error` |
| `--destructive-foreground` | `onError` |
| `--surface` | `surfaceContainerLow` |
| `--muted` | `surfaceContainerHigh` |
| `--border` | `outlineVariant` |
| `--ring` | `outline` |

### 4.3 — Dynamic Color
When using Material You dynamic color, Flux brand themes should be disabled and tokens should derive from `ColorScheme.fromSeed()`.

### 4.4 — Typography Scale
Map header/paragraph utilities to `TextTheme` styles:
| Flux Token | TextTheme Style |
|-----------|----------------|
| header-xl | `displayLarge` |
| header-lg | `displayMedium` |
| header-md | `displaySmall` |
| header-sm | `headlineLarge` |
| header-xs | `headlineMedium` |
| paragraph-xl | `titleLarge` |
| paragraph-lg | `titleMedium` |
| paragraph-md | `bodyLarge` |
| paragraph-sm | `bodyMedium` |
| paragraph-xs | `bodySmall` |

### 4.5 — High Contrast Mode
Provide a `FluxHighContrastTheme` that ensures WCAG AAA compliance. Override colors to meet 7:1 contrast ratio.

---

## Part 5: Component Documentation Issues Found

### 5.1 — Missing Sections
Across all docs:
- **Migration notes**: what to do when coming from Material/Cupertino
- **Testing notes**: how to widget-test the component
- **Accessibility**: incomplete — missing ARIA roles mapping, screen reader behavior
- **Composition**: how to compose with other Flux widgets

### 5.2 — Inconsistent Terminology
- Mixed use of "variant" vs "type" vs "style"
- Some docs use `FluxButtonVariant.primary` others use `FluxButtonVariant.filled`
- Standardize on: `variant` for visual style, `size` for dimension, `mode` for behavior

### 5.3 — Missing API Examples
- No "All Properties" example
- No "Custom Theme" example
- No "Nested in Form" example

---

## Part 6: Roadmap Issues

### 6.1 — Wrong Implementation Order
**Problem**: Animation & Polish (Phase 6) is after all components. Animations are needed DURING component development.
**Fix**: Move animation core (curves, durations, transition widgets) to Phase 1. Component-specific animations implemented per-component.

### 6.2 — Missing Parallel Work
Phase 2-5 can run in parallel with different contributors:
- Buttons + Inputs (parallel)
- Feedback + Overlay (parallel)  
- Navigation + Data Display (parallel)

### 6.3 — Underestimated Hours
- Theme engine: 8hrs → 16hrs (need lerp, dynamic color, brand themes)
- Testing: 4hrs → 16hrs (golden tests, widget tests, a11y tests)
- Documentation: 8hrs → 16hrs (API docs, migration guide, examples)

### 6.4 — Missing CI/CD Milestone
No CI pipeline defined. Add:
- GitHub Actions: `analyze`, `test`, `format-check`
- `pub.dev` publishing automation
- `coverage` badge

---

## Part 7: COMPONENTS.md Issues

### 7.1 — Missing Components
From the original React audit:
- `FluxProvider` — theme provider wrapper
- `FluxIcon` — icon sizing/theme wrapper
- `FluxText` — typography text widget
- `FluxPortal` — portal/overlay support
- `FluxFocusRing` — reusable focus ring
- `FluxPressable` — base press interaction
- `FluxRipple` — ripple container
- `FluxAnimatedVisibility` — animation wrapper

### 7.2 — Incorrect Priorities
- `Skeleton` and `Shimmer` should be P1 not P0 (they depend on animation core)
- `Table` should be P2 not P1 (complex, rare in mobile-first apps)
- `DropdownMenu` @ P0 is correct (blocking for forms)

### 7.3 — Duplicate Entries
- `Button (McButton)` and `Button (base)` are essentially the same — the base button is an internal variant. Merge into one `FluxButton` entry.

---

## Part 8: Flutter-Native Alternatives to React Patterns

### Replace CVA with Theme Extensions
React: `class-variance-authority` resolves variant class strings
Flutter: `ThemeExtension` + `WidgetStateProperty` + style classes

### Replace `cn()` with Style Composition
React: `cn(clsx(twMerge(...)))` merges Tailwind classes
Flutter: Merge `BoxDecoration`, `ButtonStyle`, `TextStyle` using `.copyWith` or custom `merge()` methods

### Replace `@base-ui/react` with Flutter Primitives
React: `@base-ui/react/button` provides accessible button primitive
Flutter: `Semantics` + `Focus` + `Actions` + `GestureDetector` provide the same natively

### Replace Portal with Overlay
React: `createPortal()` renders outside DOM hierarchy
Flutter: `Overlay.of(context).insert()` / `OverlayEntry` provides the same

### Replace CSS Animations with Implicit Animations
React: Tailwind `transition-all`, `animate-in`, `animate-out`
Flutter: `AnimatedContainer`, `TweenAnimationBuilder`, `AnimatedSwitcher`, `AnimatedCrossFade`

---

## Part 9: Missing Components

### Primitives
- [ ] `FluxPressable` — base interaction mixin (hover, press, focus, disabled states)
- [ ] `FluxFocusRing` — reusable focus ring widget
- [ ] `FluxAnimatedVisibility` — enter/exit animation wrapper

### Providers
- [ ] `FluxProvider` — root widget (provides theme + media query overrides)
- [ ] `FluxThemeProvider` — theme notifier + switcher
- [ ] `FluxLocalizationProvider` — i18n support

### Layout
- [ ] `FluxSafeArea` — safe area with Flux padding
- [ ] `FluxGap` — fixed-size spacing widget (like SwiftUI `Spacer().frame(height:)`)
- [ ] `FluxConstrainedBox` — max-width container

### Data Display
- [ ] `FluxDataTable` — paginated/sortable data grid
- [ ] `FluxTreeView` — hierarchical list
- [ ] `FluxMarkdown` — markdown renderer

### Navigation
- [ ] `FluxStepper` — step indicator
- [ ] `FluxSidebar` — responsive sidebar navigation

---

## Part 10: Missing Utilities

### Context Extensions
```dart
extension FluxBuildContext on BuildContext {
  FluxColorTheme get fluxColors => Theme.of(this).extension<FluxColorTheme>()!;
  FluxTypographyTheme get fluxTypography => Theme.of(this).extension<FluxTypographyTheme>()!;
  FluxSpacingTheme get fluxSpacing => Theme.of(this).extension<FluxSpacingTheme>()!;
  FluxShapeTheme get fluxShapes => Theme.of(this).extension<FluxShapeTheme>()!;
  FluxShadowTheme get fluxShadows => Theme.of(this).extension<FluxShadowTheme>()!;
  FluxAnimationTheme get fluxAnimations => Theme.of(this).extension<FluxAnimationTheme>()!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
}
```

### Responsive Utilities
```dart
enum FluxBreakpoint { xs, sm, md, lg, xl, xxl }
FluxBreakpoint get breakpoint => ...
bool get isMobile => breakpoint.index <= FluxBreakpoint.sm.index;
bool get isTablet => breakpoint == FluxBreakpoint.md;
bool get isDesktop => breakpoint.index >= FluxBreakpoint.lg.index;
```

### Theme Extensions
```dart
extension FluxThemeDataX on ThemeData {
  FluxColorTheme get fluxColors => extension<FluxColorTheme>()!;
  // ... etc
}
```

### Color Utilities
```dart
extension FluxColorX on Color {
  Color darken(double amount) => Color.fromARGB(alpha, (r * (1 - amount)).round(), ...);
  Color lighten(double amount) => Color.fromARGB(alpha, (r + (255 - r) * amount).round(), ...);
  Color withOpacity(double opacity) => Color.fromARGB((255 * opacity).round(), r, g, b);
  bool get isLight => computeLuminance() > 0.5;
}
```

### Animation Helpers
```dart
class FluxAnimationDurations {
  static const Duration fastest = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration slower = Duration(milliseconds: 500);
}

class FluxAnimationCurves {
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve spring = Curves.easeOutBack;
  static const Curve emphasis = Curves.easeInOutCubic;
}
```

### Padding/Margin Helpers
```dart
extension FluxPadding on Widget {
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value));
  Widget paddingSymmetric({double? h, double? v}) => Padding(padding: EdgeInsets.symmetric(horizontal: h ?? 0, vertical: v ?? 0));
  Widget paddingOnly({double? l, double? t, double? r, double? b}) => ...
}
```

### Shadow Utilities
```dart
extension FluxShadowBox on BoxDecoration {
  BoxDecoration withShadow(FluxShadowTheme shadows, FluxShadowSize size) => ...
}
```

---

## Parts 11 & 12: GitHub Issues

All issues are generated below in GitHub-flavored markdown, ready to paste into GitHub Issues.
