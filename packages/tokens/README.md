# flutter_ui_tokens

Strongly typed design tokens for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

---

## Token classes

| Class | Covers |
|-------|--------|
| `AppColorTokens` | Primary, secondary, surface, border, shadow, overlay, status (`info` · `success` · `warning` · `error`) |
| `AppSpacingTokens` | Spacing scale: `none` (0) · `xxxs` (2) · `xxs` (4) · `xs` (8) · `sm` (12) · `md` (16) · `lg` (20) · `xl` (24) · `x2l` (32) · `x3l` (40) · `x4l` (48) · `x5l` (64) |
| `AppRadiusTokens` | Corner radius: `none` (0) · `xs` (4) · `sm` (8) · `md` (12) · `lg` (16) · `xl` (24) · `pill` (999) |
| `AppSizeTokens` | Icon sizes (`iconXs` 12 → `iconXl` 32), control heights (`controlXs` 32 → `controlXl` 60), container widths (`containerXs` 280 → `containerXl` 960) |
| `AppMotionTokens` | Durations: `instant` (75 ms) · `fast` (150 ms) · `moderate` (250 ms) · `slow` (400 ms) · `emphasized` (600 ms) |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles: display, headline, title, body, label × large/medium/small) |
| `AppDesignTokens` | Aggregate — combines all token classes with `.light` and `.dark` static constants |

All token classes are:

- `@immutable` with `const` constructors
- `copyWith` — override only the fields you need
- `lerp` static — interpolate between two instances for smooth theme animation

---

## Installation

```yaml
dependencies:
  flutter_ui_tokens: ^0.1.0
```

> **Note:** `flutter_ui_tokens` is bundled with `fluxui_kit` — you only need this package directly if you want tokens without the UI components.

---

## Usage

```dart
import 'package:flutter_ui_tokens/index.dart';

// Built-in light and dark presets
final light = AppDesignTokens.light;
final dark  = AppDesignTokens.dark;

// Access individual token groups
final primary = light.colors.primary;       // Color(0xFF2563EB)
final gap16   = light.spacing.md;           // 16.0
final corner  = light.radius.lg;            // 16.0
final icon    = light.sizes.iconMd;         // 20.0
final speed   = light.motion.moderate;      // Duration(milliseconds: 250)

// Create a custom token set
final branded = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(
    primary: const Color(0xFF6366F1),
  ),
);

// Animate between two sets
final animated = AppDesignTokens.lerp(light, dark, animationValue);
```

---

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`

---

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [fluxui_kit](../fluxui/README.md) — primary UI component package
- [flutter_ui_utils](../utils/README.md) — helpers and extensions
