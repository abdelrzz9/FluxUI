# fluxui_kit

[![pub.dev](https://img.shields.io/pub/v/fluxui_kit.svg)](https://pub.dev/packages/fluxui_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-02569B?logo=flutter)](https://flutter.dev)

**A token-driven Flutter UI system — 30 components, zero hardcoded values.**

Every color, spacing value, typography style, and animation duration resolves
through strongly typed design tokens. Light and dark built in. Fully customisable.

---

## Installation

```yaml
dependencies:
  fluxui_kit: ^0.1.0
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
| `AppTheme.custom(tokens, brightness)` | Fully custom theme |

Custom branding in 3 lines:

```dart
final myTheme = AppTheme.custom(
  tokens: AppDesignTokens.light.copyWith(
    colors: AppColorTokens.light.copyWith(primary: Color(0xFF6366F1)),
  ),
  brightness: Brightness.light,
);
```

---

## Accessing tokens in widgets

```dart
// Inside any build method — no BuildContext threading required
final colors  = context.appColors;
final spacing = context.appSpacing;
final radius  = context.appRadius;
final sizes   = context.appSizes;
final typo    = context.appTypography;
```

---

## Components (30)

| Category | Widgets |
|----------|---------|
| **Buttons** | `AppButton` — primary · secondary · outline · ghost; sm/md/lg |
| **Cards** | `AppCard` — surface · outlined · muted |
| **Display** | `AppCarousel` · `AppAvatar` · `AppBadge` |
| **Feedback** | `AppAlert` · `AppProgress` · `AppDialog` · `AppBottomSheet` · `AppToast` · `AppSkeleton` |
| **Inputs** | `AppTextField` · `AppCombobox` · `AppOtpField` · `AppSearchBar` · `AppSlider` |
| **Layouts** | `Gap` · `HStack` · `VStack` |
| **Navigation** | `AppAppBar` · `AppBottomNav` · `AppNavigationMenu` · `AppPagination` · `AppTabs` |
| **Roadmap** | `AppRoadmapItem` |
| **Selection** | `AppCheckbox` · `AppChip` · `AppRadio` · `AppSwitch` |
| **Typography** | `AppText` — 15 type scale variants, 7 semantic tones |

---

## Design tokens

`fluxui_kit` re-exports `flutter_ui_tokens` which provides:

| Class | Covers |
|-------|--------|
| `AppColorTokens` | Primary, secondary, surface, status, border roles |
| `AppSpacingTokens` | Scale 0 dp → 64 dp |
| `AppRadiusTokens` | Corner radius scale |
| `AppSizeTokens` | Icon sizes (12–32 dp) and control heights (32–60 dp) |
| `AppMotionTokens` | Animation durations |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles) |
| `AppDesignTokens` | Aggregate — `.light` and `.dark` static constants |

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
