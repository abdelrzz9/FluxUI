# flutter_ui_tokens

Strongly typed design tokens for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

## Token classes

| Class | Covers |
|-------|--------|
| `AppColorTokens` | Primary, secondary, surface, border, shadow, overlay, status (info / success / warning / error) |
| `AppSpacingTokens` | Spacing scale from `xxxs` (2 dp) to `x5l` (64 dp) |
| `AppRadiusTokens` | Corner radius scale (`xs` → `pill`) |
| `AppSizeTokens` | Icon sizes (`iconXs` → `iconXl`) and control heights (`controlSm/Md/Lg`) |
| `AppMotionTokens` | Animation durations (`fast`, `normal`, `slow`) |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles) |
| `AppDesignTokens` | Aggregate — combines all token classes with `.light` and `.dark` constants |

All token classes are:
- `@immutable` with `const` constructors
- `copyWith` — override only the fields you need
- `lerp` static — interpolate between two instances for smooth theme animation

## Installation

```yaml
dependencies:
  flutter_ui_tokens: ^0.1.0
```

## Usage

```dart
import 'package:flutter_ui_tokens/index.dart';

// Built-in light and dark presets
final light = AppDesignTokens.light;
final dark  = AppDesignTokens.dark;

// Access individual token groups
final primary = light.colors.primary;
final gap16   = light.spacing.md;    // 16.0
final radius  = light.radius.lg;

// Create a custom token set
final branded = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(
    primary: const Color(0xFF6366F1),
  ),
);

// Animate between two sets
final animated = AppDesignTokens.lerp(light, dark, animationValue);
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [flutter_ui](https://pub.dev/packages/flutter_ui) — UI component library
- [flutter_ui_utils](https://pub.dev/packages/flutter_ui_utils) — helpers and extensions
