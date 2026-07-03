# Flux UI — Coding Standards

## 1. Naming Conventions

### 1.1 Files & Directories
- `snake_case.dart` for all Dart files
- `snake_case/` for directories
- One class per file (exceptions: private helpers, typedefs, extensions on the same type)
- File name matches the primary class: `flux_button.dart` contains `FluxButton`

### 1.2 Classes, Enums, Mixins, Extensions
- `PascalCase` for all public types
- `_PascalCase` for private types
- Prefix: `Flux` for all public widgets, themes, and utilities
- Suffix conventions:
  - `FluxButton` — widget
  - `FluxButtonTheme` — theme extension for a widget
  - `FluxButtonVariant` — variant enum for a widget
  - `FluxButtonSize` — size enum for a widget
  - `FluxButtonStyle` — style configuration class
  - `FluxButtonController` — controller for stateful widget
  - `FluxButtonService` — singleton service (e.g., `FluxToastService`)

### 1.3 Parameters & Variables
- `camelCase` for all parameters, variables, and functions
- `_camelCase` for private members
- Boolean parameters: use positive names (`enabled` not `disabled`, `visible` not `hidden`)
  - Exception: `destructive` is a style variant, not a boolean
- Use `required` for mandatory parameters, not nullable with assertion

### 1.4 Constants
- `camelCase` for const values (Dart convention): `const defaultDuration = Duration(milliseconds: 200);`
- `camelCase` for enum values: `FluxButtonVariant.primary`

### 1.5 Extensions
```dart
// On BuildContext
extension FluxBuildContextX on BuildContext { ... }

// On ThemeData
extension FluxThemeDataX on ThemeData { ... }

// On Widget
extension FluxWidgetX on Widget { ... }
```

### 1.6 Generics
- Single-letter: `T`, `E`, `K`, `V`
- Descriptive: `TValue`, `TItem`, `TData` when T is ambiguous

## 2. Formatting & Lint

### 2.1 Defaults
- Use `package:flutter_lints/flutter.yaml` as base
- All rules from `package:flutter_lints` are enforced
- Run `dart format` before every commit

### 2.2 Custom Lint Rules
```yaml
linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_const_literals_to_create_immutables
    - avoid_redundant_argument_values
    - use_super_parameters
    - require_trailing_commas
    - always_use_package_imports
    - prefer_final_parameters
    - prefer_final_locals
    - avoid_dynamic_calls
    - diagnostic_describe_all_properties
    - directives_ordering
    - sort_child_properties_last
    - use_key_in_widget_constructors
    - prefer_expression_function_bodies
    - unnecessary_null_checks
    - avoid_null_checks_in_equality_operators
```

### 2.3 Trailing Commas
- Always use trailing commas in constructor invocations, collection literals, and function arguments
- This enables proper `dart format` formatting

## 3. Documentation

### 3.1 Public API Documentation
- Every public declaration MUST have a doc comment
- Use `///` triple-slash comments
- Format: description, optional `{@template}`/`{@endtemplate}`, `{@macro}`, `{@tool}`

```dart
/// A button widget with support for multiple visual variants and sizes.
///
/// [FluxButton] is the primary action widget. It supports four variants:
/// [FluxButtonVariant.primary], [FluxButtonVariant.secondary],
/// [FluxButtonVariant.outline], and [FluxButtonVariant.ghost].
///
/// {@macro flux_ui.widgets.common.parameters}
class FluxButton extends StatelessWidget {
  /// Creates a Flux button.
  ///
  /// The [child] parameter is optional when [icon] is provided for icon-only
  /// buttons. The [onPressed] callback must not be null for interactive buttons.
  const FluxButton({ ... });
}
```

### 3.2 Parameter Documentation
- Document every public parameter with `///`
- Mention default values
- Mention nullability behavior

### 3.3 Package-Level Documentation
- `README.md` per package with: description, installation, basic usage, links
- `CHANGELOG.md` per package following [Keep a Changelog](https://keepachangelog.com/) format

## 4. Public API Rules

### 4.1 Constructor Design
- Always `const` constructor if the class permits it
- Use `super.key` parameter
- Parameters ordered: 1) required data, 2) callbacks, 3) styling, 4) `key`
- `child` is always the last required parameter
- For multi-child: `children` is the last required parameter

```dart
const FluxButton({
  super.key,
  this.variant = FluxButtonVariant.primary,
  this.size = FluxButtonSize.md,
  this.onPressed,
  this.child,
});
```

### 4.2 Callback Design
- `onX` for callbacks: `onPressed`, `onChanged`, `onFocusChange`
- `onX` returns `void`
- Callbacks are nullable (optional)
- Never use `required` for callbacks — a button without `onPressed` is disabled

### 4.3 Controller Pattern
- Use `FluxXController` for stateful widget controllers
- Controllers are optional parameters (default to internal state)
- Controllers extend `ChangeNotifier` or `ValueNotifier`

```dart
FluxTextField(
  controller: myController, // optional, creates internal if null
)
```

### 4.4 Builder Pattern
- Use `X.builder()` factory constructor for custom builders
- Accept `Widget Function(BuildContext)` for builder parameters

### 4.5 `copyWith`
- `copyWith` is allowed ONLY on immutable data/configuration classes (theme extensions, style classes, tokens)
- `copyWith` is FORBIDDEN on widgets (widgets are immutable descriptions)

### 4.6 `styleFrom()`
- Use `static XStyle styleFrom(...)` factory for creating style presets
- Mirrors Material `Button.styleFrom()` pattern

## 5. Deprecation Policy

### 5.1 Deprecation Process
1. Add `@Deprecated('Use ... instead')` annotation with the version
2. Keep the deprecated API for 3 minor versions or 6 months (whichever is longer)
3. Remove in the next major version
4. Document migration path in `CHANGELOG.md`

### 5.2 Deprecation Message Format
```dart
@Deprecated(
  'Use [FluxButtonVariant.primary] instead. '
  'This parameter will be removed in v2.0.0.',
)
```

## 6. Breaking Changes

### 6.1 Allowed at Major Version Only
- No breaking changes in minor or patch releases
- Breaking = any change that requires consumer code modification

### 6.2 Communication
- RFC issue must be opened and discussed for 2 weeks before a breaking change
- Migration guide must be published alongside the release
- At least one minor version with deprecation warnings before removal

## 7. Performance Rules

### 7.1 Const-First
- All widgets must have `const` constructors
- Prefer `const` for all internal widget creation
- Avoid creating new `Widget` instances in `build()` — extract to fields or use `const`

### 7.2 Avoid Unnecessary Rebuilds
- Use `const` child widgets where possible
- Use `RepaintBoundary` for complex paint operations
- Use `AnimatedBuilder` / `ValueListenableBuilder` instead of `setState` for localized rebuilds
- Extract sub-widgets to `StatelessWidget` to minimize rebuild scope

### 7.3 Minimal Allocations
- Avoid closures in build methods — extract to methods or use tear-offs
- Cache `WidgetStateProperty` instances
- Avoid `List.generate` in build methods — pre-compute children

### 7.4 Overlay Reuse
- Reuse `OverlayEntry` instances instead of creating new ones for every frame
- Use `CompositedTransformFollower`/`Leader` for overlay positioning (no layout recalculation)

### 7.5 When to Use RenderObject
`RenderObject` is allowed when:
- Custom layout algorithm is needed (e.g., masonry, flow layout)
- Custom hit testing is required
- Custom painting with specific repaint boundaries
- Performance measurements show `RenderBox` is significantly faster than composition

**Default to composition** — only use `RenderObject` when measurement proves necessity.

### 7.6 When to Use CustomPainter
`CustomPainter` is allowed when:
- Complex custom drawing (gradients, patterns, charts)
- Shimmer/glass effects
- Focus rings (to avoid layout side effects)
- `Canvas` operations are significantly more efficient than widget composition

### 7.7 When to Avoid StatefulWidget
Avoid `StatefulWidget` when:
- State can be managed by `ValueNotifier` + `ValueListenableBuilder`
- State is lifted to a parent `InheritedWidget`
- A simple `AnimationController` with `AnimatedBuilder` suffices
- The widget only needs `TickerProviderStateMixin` — use a dedicated `TickerWidget`

## 8. Theme Rules

### 8.1 Extension-Based Lookup
- Every component reads its specific `ThemeExtension`
- Never read the monolithic `FluxThemeData` — always use the domain-specific extension
- Provide fallback defaults if the extension is not registered

```dart
final buttonTheme = Theme.of(context).extension<FluxButtonTheme>()
    ?? FluxButtonTheme.defaults();
```

### 8.2 Extension Registration
- All extensions registered via `FluxProvider` or `ThemeData.extensions`
- Each extension must implement `lerp()`, `==`, `hashCode`, `merge()`, `copyWith()`

### 8.3 Token Inheritance
- Component-specific theme extensions inherit defaults from global extensions
- Never duplicate token values across extensions

## 9. Accessibility Rules

### 9.1 Mandatory Semantics
- Every interactive widget MUST include `Semantics`
- Use correct roles: `button`, `checkbox`, `slider`, `tab`, `progressbar`, etc.
- All images MUST have `semanticLabel` or be marked `excludeSemantics: true`

### 9.2 Keyboard Navigation
- All interactive widgets accept `FocusNode`
- Support `onKey` or `Actions` for keyboard handlers
- Arrow keys, Enter, Escape, Tab must work for navigation widgets
- `FluxDialog` must trap focus

### 9.3 Focus Traversal
- `FocusTraversalGroup` for logical focus ordering
- Default to `ReadingOrderTraversalPolicy`
- `ExcludeFocus` for non-interactive decorative elements

### 9.4 Reduced Motion
- Check `MediaQuery.reducedMotion` before playing animations
- Provide static alternatives when reduced motion is active

### 9.5 High Contrast
- Check `MediaQuery.highContrast`
- Use `FluxHighContrastTheme` when active

### 9.6 Large Text
- Respect `MediaQuery.textScaleFactor`
- All text widgets must not overflow at 200% text scale
- Use `SoftWrap`, `overflow`, `maxLines` appropriately

## 10. Testing Rules

### 10.1 Unit Tests
- Every utility function, extension, and helper MUST have unit tests
- Test edge cases: null inputs, empty collections, boundary values

### 10.2 Widget Tests
- Every component MUST have widget tests for:
  - All variants
  - All states (enabled, disabled, hovered, focused, pressed)
  - All sizes
  - Interactive behavior (tap, swipe, keyboard)
  - Controlled and uncontrolled modes
  - RTL layout
  - Theme integration
  - Semantics

### 10.3 Golden Tests
- Every component MUST have golden tests for visual regression
- Light and dark themes
- RTL layout
- High contrast mode
- Reference images stored in `test/goldens/`

## 11. Animation Rules

### 11.1 Duration Precedence
1. Explicit `duration` parameter on the widget
2. `FluxAnimationTheme` per-component duration
3. Global `FluxAnimationTheme` default
4. Hardcoded fallback (200ms)

### 11.2 Curve Precedence
Same as duration — explicit > component theme > global theme > fallback

### 11.3 Animation Controllers
- `AnimationController` with `vsync: this` via `TickerProviderStateMixin` or `SingleTickerProviderStateMixin`
- Always dispose controllers in `dispose()`
- Prefer `ImplicitlyAnimatedWidget` over manual controllers

### 11.4 Enter/Exit Animations
- Use `FluxAnimatedVisibility` for enter/exit transitions
- Use `AnimatedSwitcher` for content switching
- Use `AnimatedCrossFade` for subtle cross-fading

## 12. Null Safety & Const Usage

### 12.1 Null Safety
- All code must pass sound null safety
- `required` for parameters that must always be provided
- Nullable for optional parameters with defaults
- Avoid `late` — prefer late-initialization via `late final` only when necessary
- Avoid `!` null assertions — prefer pattern matching or explicit checks

### 12.2 Const Usage
- Every widget constructor MUST be `const`
- Every `ThemeExtension` MUST be `const`-constructible
- Prefer `const Color(0xFF...)` over `Color.fromARGB(...)` or `Colors.blue`
- Prefer const lists/maps where values are known at compile time

## 13. Composition Rules

### 13.1 Widget Composition
- Favor composition over inheritance
- Wrap existing widgets rather than extending them
- Use `StatelessWidget` unless imperative state is required

### 13.2 InheritedWidget
- Use `InheritedNotifier` or `InheritedWidget` for propagating state down the tree
- Never use `InheritedWidget` for frequently-changing state (use `ListenableBuilder`)

### 13.3 Builder Parameters
- Accept `Widget?` for optional content (more flexible than `String?` for labels)
- Accept `Widget Function(BuildContext)?` for context-dependant content

## 14. Widget Lifecycle

### 14.1 Lifecycle Rules
- `createState()` → keep minimal, no logic
- `initState()` → initialize controllers, add listeners, start animations
- `didChangeDependencies()` → update inherited widget references, rebuild if needed
- `didUpdateWidget()` → compare old/new configuration, update controllers
- `build()` → pure function of configuration and state
- `dispose()` → dispose controllers, remove listeners, stop animations

### 14.2 Restoration
- Override `restorationMixin` for widgets that should preserve state
- Use `RestorableProperty` for values to restore
- Assign `restorationId` for each restorable widget

## 15. Deprecation & Removal Process

```
v1.0.0: API introduced as stable
v1.2.0: Replacement API introduced, old API marked @Deprecated("Use X since v1.2.0")
v2.0.0: Old API removed
         Migration guide published
         Changelog entry with breaking change notice
```

Minimum timeline: 3 minor versions or 6 months deprecation window.
