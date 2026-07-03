# flutter_ui_utils

Shared helpers and fluent extensions for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

---

## Features

| Feature | What it provides |
|---------|-----------------|
| **Context extensions** | `context.screenWidth`, `context.screenHeight`, `context.isCompact`, `context.isMedium`, `context.isExpanded`, `context.isLarge`, `context.responsive<T>(...)` |
| **Widget spacing** | `.padding()`, `.paddingSymmetric()`, `.paddingOnly()`, `.paddingInsets()`, `.margin()`, `.marginSymmetric()`, `.marginOnly()` |
| **Widget layout** | `.center()`, `.align()`, `.expanded()`, `.flexible()`, `.sized()`, `.constrained()` |
| **Widget decoration** | `.rounded()`, `.background()`, `.border()`, `.shadow()`, `.decorated()` |
| **Numeric helpers** | `16.dp`, `8.inset`, `300.ms`, `12.radius`, `8.hGap`, `8.vGap` |
| **Breakpoints** | `AppBreakpoints` — configurable compact / medium (600) / expanded (1024) / large (1440) thresholds |
| **Responsive values** | `AppResponsiveValue<T>` — resolves the right value for the current window size |

---

## Installation

```yaml
dependencies:
  flutter_ui_utils: ^0.1.0
```

> **Note:** `flutter_ui_utils` is bundled with `fluxui_kit` — you only need this package directly if you want the helpers without the full UI component set.

---

## Usage

```dart
import 'package:flutter_ui_utils/index.dart';

// --- BuildContext extensions ---
final width   = context.screenWidth;
final isPhone = context.isCompact;
final padding = context.responsive<double>(
  compact: 16,
  medium: 24,
  expanded: 32,
);

// --- Widget fluent API ---
Text('Hello')
  .padding(16)
  .rounded(8)
  .background(Colors.white)
  .shadow()
  .center();

// --- Numeric helpers ---
SizedBox(height: 24.dp);
EdgeInsets.all(12.dp);
final gap = 8.vGap;             // SizedBox(height: 8)
final corners = 12.radius;      // BorderRadius.circular(12)

// --- Responsive value ---
final columns = AppResponsiveValue<int>(
  compact: 1,
  medium: 2,
  expanded: 3,
);
final count = columns.resolve(context);
```

---

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- `flutter_ui_tokens: ^0.1.0`

---

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [fluxui_kit](../fluxui/README.md) — primary UI component package
- [flutter_ui_tokens](../tokens/README.md) — design tokens
