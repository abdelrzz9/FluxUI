# flutter_ui

Developer-first composable Flutter UI system built on typed tokens. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

## Features

- **Zero hardcoded values** — every color, size, and spacing resolves through `AppDesignTokens`
- **Light and dark built-in** — `AppTheme.light()` and `AppTheme.dark()` wrap a full `ThemeData`
- **Fully customisable** — pass any `AppDesignTokens` to `AppTheme.custom()`
- **18 production-ready widgets** across buttons, inputs, layout, navigation, and more
- **Material 3** — `useMaterial3: true` by default

## Installation

```yaml
dependencies:
  flutter_ui: ^0.1.0
```

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

## Theme API

| Method | Description |
|--------|-------------|
| `AppTheme.light()` | Material 3 light theme using `AppDesignTokens.light` |
| `AppTheme.dark()` | Material 3 dark theme using `AppDesignTokens.dark` |
| `AppTheme.custom(tokens, brightness)` | Fully custom theme from any `AppDesignTokens` |

All methods accept optional `fontFamily` and `useMaterial3` parameters.

Custom branding:

```dart
final myTokens = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(primary: const Color(0xFF6366F1)),
);

MaterialApp(
  theme: AppTheme.custom(tokens: myTokens, brightness: Brightness.light, fontFamily: 'Inter'),
);
```

## Widgets

| Category | Widgets |
|----------|---------|
| Buttons | `AppButton` — 4 variants (`primary` · `secondary` · `outline` · `ghost`), 3 sizes, loading state |
| Cards | `AppCard` — `surface` · `outlined` · `muted` |
| Display | `AppCarousel` |
| Feedback | `AppAlert` (5 variants) · `AppProgress` (linear + circular) |
| Inputs | `AppTextField` · `AppCombobox` · `AppOtpField` |
| Layouts | `Gap` · `HStack` · `VStack` |
| Navigation | `AppNavigationMenu` · `AppPagination` · `AppTabs` |
| Roadmap | `AppRoadmapItem` |
| Selection | `AppCheckbox` · `AppSwitch` |
| Typography | `AppText` |

## Accessing tokens in widgets

```dart
// Inside any build method when AppTheme is applied:
final colors  = context.appColors;
final spacing = context.appSpacing;
final radius  = context.appRadius;
final sizes   = context.appSizes;
final typo    = context.appTypography;
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- `flutter_ui_tokens: ^0.1.0`
- `flutter_ui_utils: ^0.1.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [flutter_ui_tokens](https://pub.dev/packages/flutter_ui_tokens) — design tokens
- [flutter_ui_utils](https://pub.dev/packages/flutter_ui_utils) — helpers and extensions
- [flutter_ui_cli](https://github.com/abdelrzz9/FluxUI/tree/main/packages/cli) — component copy tool
