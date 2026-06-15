# fluxui_kit

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.4-0175C2?logo=dart)](https://dart.dev)

**A token-driven Flutter UI system — 30+ components, zero hardcoded values.**

Every color, spacing value, typography style, and animation duration resolves
through strongly typed design tokens. Light and dark built in. Fully customisable.

Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

---

## Installation

```yaml
dependencies:
  fluxui_kit: ^0.2.0
```

---

## Quick start

```dart
import 'package:fluxui_kit/fluxui_kit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              AppButton(text: 'Primary', onPressed: () {}),
              AppButton.secondary(text: 'Secondary', onPressed: () {}),
              AppTextField(labelText: 'Email', hintText: 'you@example.com'),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Theme API

| Method | Description |
|--------|-------------|
| `AppTheme.light()` | Material 3 light theme using `AppDesignTokens.light` |
| `AppTheme.dark()` | Material 3 dark theme using `AppDesignTokens.dark` |
| `AppTheme.custom(tokens, brightness)` | Fully custom theme from any `AppDesignTokens` |

All methods accept optional `fontFamily`, `seedColor`, and `overrides` parameters.

### Custom branding

```dart
final myTheme = AppTheme.custom(
  tokens: AppDesignTokens.light.copyWith(
    colors: AppColorTokens.light.copyWith(primary: Color(0xFF6366F1)),
  ),
  brightness: Brightness.light,
);
```

### Dynamic colour with `seedColor`

Generate a complete Material You colour scheme from a single seed colour:

```dart
MaterialApp(
  theme: AppTheme.light(seedColor: Color(0xFF6366F1)),
);
```

When `seedColor` is set, `ColorScheme.fromSeed()` is used instead of the token-based colour mapping.

### Partial overrides with the `overrides` callback

Override specific tokens inline without building a full `AppDesignTokens`:

```dart
MaterialApp(
  theme: AppTheme.light(
    overrides: (tokens) => tokens.copyWith(
      colors: tokens.colors.copyWith(primary: Color(0xFF6366F1)),
      spacing: tokens.spacing.copyWith(md: 20),
    ),
  ),
);
```

---

## Accessing tokens in widgets

```dart
final colors     = context.appColors;
final spacing    = context.appSpacing;
final radius     = context.appRadius;
final sizes      = context.appSizes;
final motion     = context.appMotion;
final typography = context.appTypography;
```

---

## Components (30+)

| Category | Widgets |
|----------|---------|
| **Buttons** | `AppButton` — primary · secondary · outline · ghost; sm/md/lg; loading state |
| **Cards** | `AppCard` — surface · outlined · muted |
| **Display** | `AppAvatar` · `AppBadge` · `AppCarousel` |
| **Feedback** | `AppAlert` · `AppBottomSheet` · `AppDialog` · `AppProgress` · `AppSkeleton` · `AppToast` |
| **Inputs** | `AppCombobox` · `AppOtpField` · `AppSearchBar` · `AppSlider` · `AppTextField` |
| **Layouts** | `Gap` · `HStack` · `VStack` |
| **Navigation** | `AppAppBar` · `AppBottomNav` · `AppNavigationMenu` · `AppPagination` · `AppTabs` |
| **Roadmap** | `AppRoadmapItem` |
| **Selection** | `AppCheckbox` · `AppChip` · `AppRadio` · `AppSwitch` |
| **Typography** | `AppText` — 15 type-scale variants, 7 semantic tones |

---

## Design tokens

`fluxui_kit` re-exports [`flutter_ui_tokens`](../tokens/README.md) which provides:

| Class | Covers |
|-------|--------|
| `AppColorTokens` | Primary, secondary, surface, status, border, overlay, shadow |
| `AppSpacingTokens` | Scale `none` (0 dp) → `x5l` (64 dp) |
| `AppRadiusTokens` | Corner radius scale `none` → `pill` |
| `AppSizeTokens` | Icon sizes (12–32 dp), control heights (32–60 dp), container widths |
| `AppMotionTokens` | Durations: `instant` · `fast` · `moderate` · `slow` · `emphasized` |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles) |
| `AppDesignTokens` | Aggregate — `.light` and `.dark` static constants |

---

## Theme resolution order

When a component reads tokens (e.g. `context.appColors`), the resolution is:

1. **`AppThemeTokens`** (injected by `AppTheme.light()`/`.dark()`/`.custom()`)
2. **Brightness-based defaults** (`AppDesignTokens.light` or `.dark`) if no `AppTheme` is applied

---

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`

---

## Repository

[github.com/abdelrzz9/FluxUI](https://github.com/abdelrzz9/FluxUI)
— monorepo containing `flutter_ui_tokens`, `flutter_ui_utils`, `fluxui_kit`, and the `flux` CLI.

## License

MIT — see [LICENSE](LICENSE).
