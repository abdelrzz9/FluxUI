# flutter_ui

[![pub.dev](https://img.shields.io/pub/v/flutter_ui.svg)](https://pub.dev/packages/flutter_ui)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-blue)](https://flutter.dev)

Developer-first composable Flutter UI system built on typed tokens. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) ecosystem.

## Features

- **Token-driven** — zero hardcoded colors or sizes; everything resolves through `AppDesignTokens`
- **Light & dark out of the box** — `AppTheme.light()` / `AppTheme.dark()` wrap a standard `ThemeData`
- **Fully customisable** — pass your own `AppDesignTokens` to `AppTheme.custom()` for brand theming
- **19 production-ready widgets** spanning buttons, inputs, layout, navigation, and more
- **Material 3** — built on top of Flutter's Material library with `useMaterial3: true` by default

## Installation

```yaml
dependencies:
  flutter_ui: ^0.1.0
```

## Quick start

```FluxUI/packages/ui/lib/core/theme/app_theme.dart#L1-3
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

## Theme API

| Method | Description |
|---|---|
| `AppTheme.light()` | Material 3 light theme using `AppDesignTokens.light` |
| `AppTheme.dark()` | Material 3 dark theme using `AppDesignTokens.dark` |
| `AppTheme.custom(tokens, brightness)` | Fully custom theme from any `AppDesignTokens` |

All three methods accept an optional `fontFamily` and `useMaterial3` flag.

## Widgets

| Category | Widgets |
|---|---|
| **Buttons** | `AppButton` — 4 variants (`primary`, `secondary`, `outline`, `ghost`), 3 sizes (`sm`, `md`, `lg`), loading state |
| **Cards** | `AppCard` |
| **Display** | `AppCarousel` |
| **Feedback** | `AppAlert`, `AppProgress` |
| **Inputs** | `AppTextField`, `AppCombobox`, `AppOtpField` |
| **Layouts** | `Gap`, `HStack`, `VStack` |
| **Navigation** | `AppNavigationMenu`, `AppPagination`, `AppTabs` |
| **Roadmap** | `AppRoadmapItem` |
| **Selection** | `AppCheckbox`, `AppSwitch` |
| **Typography** | `AppText` |

## Custom theming

```FluxUI/packages/ui/lib/core/theme/app_theme.dart#L1-3
final myTokens = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(
    primary: const Color(0xFF6366F1),
  ),
);

MaterialApp(
  theme: AppTheme.custom(
    tokens: myTokens,
    brightness: Brightness.light,
    fontFamily: 'Inter',
  ),
);
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- [`flutter_ui_tokens`](https://pub.dev/packages/flutter_ui_tokens) `^0.1.0`
- [`flutter_ui_utils`](https://pub.dev/packages/flutter_ui_utils) `^0.1.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [Issue tracker](https://github.com/abdelrzz9/FluxUI/issues)
- [`flutter_ui_tokens` — design tokens](https://pub.dev/packages/flutter_ui_tokens)
- [`flutter_ui_utils` — helpers & extensions](https://pub.dev/packages/flutter_ui_utils)
- [`flutter_ui_cli` — component copy tool](https://github.com/abdelrzz9/FluxUI/tree/main/packages/cli)
