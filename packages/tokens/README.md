# flutter_ui_tokens

[![pub.dev](https://img.shields.io/pub/v/flutter_ui_tokens.svg)](https://pub.dev/packages/flutter_ui_tokens)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-blue)](https://flutter.dev)

Strongly typed design tokens for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) ecosystem.

## Features

- **Fully typed** — every token is a named, typed Dart field, no raw `Color(0x...)` in your widgets
- **Immutable** — all token classes are `@immutable` and use `const` constructors
- **Lerp-ready** — every token class ships a `lerp` static method for smooth theme animations
- **Light & dark built-in** — `AppDesignTokens.light` and `AppDesignTokens.dark` out of the box
- **Customisable** — `copyWith` on any token class to override only what you need

## Token categories

| Class | Covers |
|---|---|
| `AppColorTokens` | Primary, secondary, surface, border, semantic (success / warning / error / info) |
| `AppSpacingTokens` | Scale from `xxxs` (2 dp) to `x5l` (64 dp) |
| `AppRadiusTokens` | Corner radius scale |
| `AppSizeTokens` | Icon sizes and component heights |
| `AppMotionTokens` | Durations and curves |
| `AppTypographyTokens` | Full Material 3 text style scale |

## Installation

```yaml
dependencies:
  flutter_ui_tokens: ^0.1.0
```

## Usage

### Access the built-in themes

```FluxUI/packages/tokens/lib/src/app_design_tokens.dart#L1-3
final tokens = AppDesignTokens.light; // or AppDesignTokens.dark
final primary = tokens.colors.primary;
final gap = tokens.spacing.md; // 16.0
```

### Use individual token classes

```FluxUI/packages/tokens/lib/src/app_color_tokens.dart#L1-3
const colors = AppColorTokens.light;
// colors.primary, colors.surface, colors.error, ...

const spacing = AppSpacingTokens.regular;
// spacing.xs (8), spacing.md (16), spacing.xl (24), ...
```

### Create a custom token set

```FluxUI/packages/tokens/lib/src/app_design_tokens.dart#L1-3
final myTokens = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(
    primary: const Color(0xFF6366F1),
  ),
);
```

### Animate between token sets

```FluxUI/packages/tokens/lib/src/app_design_tokens.dart#L1-3
final animated = AppDesignTokens.lerp(
  AppDesignTokens.light,
  AppDesignTokens.dark,
  animationValue, // 0.0 → 1.0
);
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [Issue tracker](https://github.com/abdelrzz9/FluxUI/issues)
- [`flutter_ui` — UI component library](https://pub.dev/packages/flutter_ui)
- [`flutter_ui_utils` — helpers & extensions](https://pub.dev/packages/flutter_ui_utils)
