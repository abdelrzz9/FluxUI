# flutter_ui_utils

Shared helpers and fluent extensions for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

## Features

| Feature | What it provides |
|---------|-----------------|
| `BuildContext` extensions | `context.screenWidth`, `context.isCompact`, `context.responsive<T>(...)` |
| Widget extensions | `.padding()`, `.margin()`, `.rounded()`, `.background()`, `.expanded()`, `.center()` |
| Numeric helpers | `16.dp`, `8.inset`, `300.ms`, `12.radius`, `8.hGap`, `8.vGap` |
| `AppBreakpoints` | Configurable compact / medium / expanded / large width thresholds |
| `AppResponsiveValue<T>` | Resolves the right value for the current window size |

## Installation

```yaml
dependencies:
  flutter_ui_utils: ^0.1.0
```

## Usage

```dart
import 'package:flutter_ui_utils/index.dart';

// --- BuildContext extensions ---
final width   = context.screenWidth;
final isPhone = context.isCompact;
final padding = context.responsive<double>(compact: 16, medium: 24, expanded: 32);

// --- Widget extensions ---
Text('Hello')
  .padding(16)
  .rounded(8)
  .background(Colors.white)
  .shadow()
  .center();

// --- Numeric helpers ---
SizedBox(height: 24.dp)
EdgeInsets.all(12.dp)
Duration(milliseconds: 300.ms.inMilliseconds)

// --- Responsive value ---
const columns = AppResponsiveValue<int>(compact: 1, medium: 2, expanded: 3);
final count = columns.resolve(context);
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- `flutter_ui_tokens: ^0.1.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [flutter_ui](https://pub.dev/packages/flutter_ui) — UI component library
- [flutter_ui_tokens](https://pub.dev/packages/flutter_ui_tokens) — design tokens
