# flutter_ui

Developer-first composable Flutter UI system built on typed tokens. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

> **Note:** `flutter_ui` mirrors the [`fluxui_kit`](../fluxui/README.md) package. Both provide the same components, theme API, and token integrations. Use whichever package name fits your project.

---

## Features

- **Zero hardcoded values** — every color, size, and spacing resolves through `AppDesignTokens`
- **Light and dark built-in** — `AppTheme.light()` and `AppTheme.dark()` wrap a full `ThemeData`
- **Fully customisable** — pass any `AppDesignTokens` to `AppTheme.custom()`
- **Optional theme override** — `FluxThemeData` lets you override individual token groups via `ThemeExtension`
- **30+ production-ready widgets** across buttons, inputs, layout, navigation, and more
- **Material 3** — `useMaterial3: true` by default

---

## Installation

```yaml
dependencies:
   fluxui_kit: ^0.1.0
```

---

## Quick start

```dart
import 'package:flutter_ui/index.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(
        body: Center(
          child: AppButton(
            text: 'Get started',
            onPressed: () {},
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

All methods accept optional `fontFamily` and `useMaterial3` parameters.

### Custom branding

```dart
final myTokens = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(primary: const Color(0xFF6366F1)),
);

MaterialApp(
  theme: AppTheme.custom(
    tokens: myTokens,
    brightness: Brightness.light,
    fontFamily: 'Inter',
  ),
);
```

### Optional theme override with `FluxThemeData`

Override specific token groups without replacing the entire token set:

```dart
MaterialApp(
  theme: AppTheme.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      ...AppTheme.light().extensions.values,
      FluxThemeData(
        colors: AppColorTokens.light.copyWith(
          primary: Color(0xFF6366F1),
        ),
      ),
    ],
  ),
);
```

If no `FluxThemeData` is provided, the system behaves identically to the default setup.

---

## Widgets (30+)

| Category | Widgets |
|----------|---------|
| **Buttons** | `AppButton` — 4 variants (primary · secondary · outline · ghost), 3 sizes, loading state |
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

## Accessing tokens in widgets

```dart
// Inside any build method when AppTheme is applied:
final colors     = context.appColors;
final spacing    = context.appSpacing;
final radius     = context.appRadius;
final sizes      = context.appSizes;
final motion     = context.appMotion;
final typography = context.appTypography;

// Check for optional FluxThemeData overrides:
final flux = context.fluxTheme; // FluxThemeData?
```

---

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- `flutter_ui_tokens: ^0.1.0`
- `flutter_ui_utils: ^0.1.0`

---

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [flutter_ui_tokens](../tokens/README.md) — design tokens
- [flutter_ui_utils](../utils/README.md) — helpers and extensions
- [flutter_ui_cli](../cli/README.md) — component copy tool
