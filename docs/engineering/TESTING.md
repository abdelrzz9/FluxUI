# Flux UI — Testing Strategy

## Test Categories

### 1. Unit Tests

**Target**: All non-widget code (utilities, extensions, tokens, theme data)

**Requirements**:
- Every utility function, extension method, and helper has unit tests
- Test edge cases: null, empty, boundary values, overflow
- Test `lerp` on all theme extensions (0.0, 0.5, 1.0, and out-of-range)
- Test `copyWith` and `merge` on all data classes
- Test `==` and `hashCode` on all value objects
- Test enum parsing and serialization

**File pattern**: `test/src/<package>/<name>_test.dart`

**Coverage target**: 100% of utility/helper code

### 2. Widget Tests

**Target**: Every component

**Requirements per component**:
- Render all variants (e.g., primary, secondary, outline, ghost for button)
- Render all sizes (sm, md, lg, xl where applicable)
- All states: enabled, disabled, focused, hovered (via `handleOnEvent`), pressed
- Interactive behavior: tap, long press, swipe, drag
- Controlled mode (external state) and uncontrolled mode (internal state)
- Callbacks are invoked correctly (onPressed, onChanged, etc.)
- Callbacks are NOT invoked when disabled
- RTL layout renders correctly
- Theme integration — with and without custom theme extension
- Sizes match expected values from tokens

**File pattern**: `test/src/components/<category>/<name>_test.dart`

**Coverage target**: 95%+ line coverage for widget files

### 3. Golden Tests

**Target**: Every component, every visual variant

**Requirements**:
- One golden test per (component × variant × theme) combination
- Light theme and dark theme
- RTL layout
- High contrast mode
- Focused state (focus ring visible)
- Disabled state (greyed out)
- All interactive states (hover, press via `WidgetController`)
- Reference images stored in `test/goldens/`
- CI verifies goldens match; manual approval required for changes

**Tooling**: `matchesGoldenFile()` from `flutter_test`

**Update command**: `flutter test --update-goldens`

**File pattern**: `test/goldens/<component>_<variant>_<theme>.png`

**Coverage target**: All public API visual outputs

### 4. Integration Tests

**Target**: Full application flows

**Requirements**:
- Component catalog app loads all components
- Theme switching works (light → dark → high contrast → brand themes)
- RTL toggle works
- Navigation between component categories
- No crashes on route transitions
- Memory profile: no leaks after navigating through all components

**Tooling**: `integration_test` package

**File pattern**: `test/integration/`

### 5. Accessibility Tests

**Target**: Every interactive component

**Requirements**:
- `Semantics` nodes exist with correct roles
- Labels are non-empty for interactive elements
- All touch targets meet minimum size (48×48 dp)
- Focus order is logical (`ReadingOrderTraversalPolicy` works)
- Keyboard navigation works (Tab, Enter, Escape, Arrow keys)
- Screen reader announcements are correct

**Tooling**: `flutter_test` semantics APIs, `SemanticsTester`

```dart
final semantics = tester.getSemantics(find.byType(FluxButton));
expect(semantics, hasSemantics(TestSemantics(
  label: 'Submit',
  action: SemanticsAction.tap,
  flags: <SemanticsFlag>[SemanticsFlag.isButton],
)));
```

### 6. Performance Benchmarks

**Target**: Every component, key operations

**Requirements**:
- Widget build time (first frame)
- Widget rebuild time (state change)
- Layout time
- Paint time
- Memory allocation per build
- Widget tree depth (max depth constraint)

**Tooling**: `FlutterPerformance`, `Timeline`, `trace.json` analysis

**File pattern**: `benchmarks/lib/<component>_benchmark.dart`

**Thresholds** (see PERFORMANCE.md for exact numbers):
- Build time < 5ms per component (debug mode)
- Rebuild < 1ms (no unnecessary repaints)
- Widget tree depth < 20 for any component
- Memory allocation < 50KB per component instance

### 7. Visual Regression Tests

**Target**: All components across all themes

**Requirements**:
- Screen-by-screen comparison against stored reference images
- Pixel-level diff with tolerance for anti-aliasing
- Automatic failure on >0.1% pixel difference
- Weekly scheduled runs to catch Flutter SDK regressions
- Manual review process for golden updates

**Tooling**: `matchesGoldenFile()` with `flutter test --update-goldens`

### 8. Theme Tests

**Target**: Theme system

**Requirements**:
- All brand themes produce valid `ThemeData` without crashes
- Light and dark variants for each brand theme
- High contrast theme meets 7:1 contrast ratios (tested programmatically)
- `lerp` between any two theme extensions is smooth
- Dynamic color from seed produces consistent tokens
- `FluxProvider` correctly registers all extensions
- All component theme extensions have valid defaults

### 9. RTL Tests

**Target**: Every component with directional layout

**Requirements**:
- Component renders correctly under `Directionality(TextDirection.rtl)`
- Padding/margin uses `EdgeInsetsDirectional` or responds to `Directionality`
- Alignment reverses correctly
- Icons and text flow right-to-left
- Golden tests exist for RTL layout

### 10. Localization Tests

**Target**: Components with user-facing strings

**Requirements**:
- Default strings exist in English
- Custom strings override defaults
- Custom strings appear in rendered output
- Non-ASCII characters render correctly

### 11. Platform Tests

**Target**: All components

**Requirements**:
| Platform | Test Level | Notes |
|----------|-----------|-------|
| Android | Widget + Integration | Touch behavior, Material theming |
| iOS | Widget + Integration | Cupertino compatibility |
| Web | Widget | Mouse hover, keyboard, responsive |
| Desktop | Widget | Hover, focus, keyboard, window resize |

**Coverage target**: All widgets tested on Android + Web (CI); iOS + Desktop tested manually before release

## Coverage Requirements

| Metric | Target | Enforcement |
|--------|--------|-------------|
| Line coverage (tokens) | 100% | CI fail below 95% |
| Line coverage (theme) | 95% | CI fail below 90% |
| Line coverage (components) | 90% | CI fail below 85% |
| Line coverage (utilities) | 100% | CI fail below 95% |
| Widget test coverage (components) | 100% of components | PR review |
| Golden test coverage (components) | 100% of visual variants | CI fail |
| Accessibility test coverage | 100% of interactive components | CI warning |

## Test File Organization

```
test/
├── integration/
│   └── app_test.dart
├── goldens/
│   ├── flux_button_primary_light.png
│   ├── flux_button_primary_dark.png
│   ├── flux_button_outline_light.png
│   └── ...
├── src/
│   ├── core/
│   │   ├── tokens/
│   │   │   ├── colors_test.dart
│   │   │   ├── typography_test.dart
│   │   │   └── ...
│   │   ├── theme/
│   │   │   ├── flux_color_theme_test.dart
│   │   │   ├── flux_button_theme_test.dart
│   │   │   └── ...
│   │   └── primitives/
│   │       ├── flux_pressable_test.dart
│   │       └── ...
│   └── components/
│       ├── buttons/
│       │   ├── flux_button_test.dart
│       │   └── flux_button_golden_test.dart
│       ├── inputs/
│       │   ├── flux_checkbox_test.dart
│       │   └── ...
│       └── ...
```

## CI Integration

| Test Type | CI Job | Trigger |
|-----------|--------|---------|
| Unit tests | `test` | Every PR, push to dev/main |
| Widget tests | `test` | Every PR, push to dev/main |
| Golden tests | `golden-tests` | Every PR, manual approval |
| Integration tests | `integration-test` | Release branches only |
| Accessibility tests | `test` | Every PR |
| Performance benchmarks | `benchmarks` | Nightly, release branches |
| Visual regression | `golden-tests` | Weekly scheduled |

## Test Helpers

Shared test utilities in `packages/flux_testing/`:

- `pumpFluxApp()` — pump a MaterialApp with Flux theme
- `FluxTestWidget` — generic test wrapper
- `expectSemantics()` — semantic assertion helper
- `expectGolden()` — golden test with region capture
- `mockFluxTheme()` — create mock theme extension for isolation
- `pumpWithRTL()` — pump with RTL Directionality
- `pumpWithReducedMotion()` — pump with reduced motion
- `pumpWithHighContrast()` — pump with high contrast
- `screenCapture()` — capture widget to image for manual review
