# flutter_ui_utils

[![pub.dev](https://img.shields.io/pub/v/flutter_ui_utils.svg)](https://pub.dev/packages/flutter_ui_utils)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-blue)](https://flutter.dev)

Shared helpers and fluent extensions for Flutter. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) ecosystem.

## Features

- **`BuildContext` extensions** — screen size, orientation, responsive breakpoints, and token accessors in one call
- **Widget extensions** — fluent `.padding()`, `.margin()`, `.rounded()`, `.background()`, `.shadow()`, `.expanded()`, and more
- **Numeric helpers** — `16.dp`, `8.inset`, `4.ms`, `12.radius`, `8.hGap`, `8.vGap` shorthand extensions on `num`
- **Responsive breakpoints** — `AppBreakpoints` with configurable `compact / medium / expanded / large` widths
- **Responsive values** — `AppResponsiveValue<T>` resolves the right value for the current window size

## Installation

```yaml
dependencies:
  flutter_ui_utils: ^0.1.0
```

## Usage

### Context extensions

```FluxUI/packages/utils/lib/src/extensions/context_extensions.dart#L1-3
// Inside a build method:
final width = context.screenWidth;
final isPhone = context.isCompact;
final windowSize = context.windowSize; // AppWindowSize enum

// Responsive helper — falls back to the nearest smaller value
final padding = context.responsive<double>(
  compact: 16,
  medium: 24,
  expanded: 32,
);
```

### Widget extensions

```FluxUI/packages/utils/lib/src/extensions/widget_extensions.dart#L1-3
Text('Hello')
  .padding(16)
  .rounded(8)
  .background(Colors.white)
  .shadow()
  .center()
```

### Numeric helpers

```FluxUI/packages/utils/lib/src/extensions/num_extensions.dart#L1-3
SizedBox(height: 24.dp)
EdgeInsets.all(12.dp)
BorderRadius.circular(8.dp)
Duration(milliseconds: 300) // same as 300.ms
```

### Responsive breakpoints

```FluxUI/packages/utils/lib/src/responsive/app_breakpoints.dart#L1-3
// Default breakpoints (pixels):
// compact  < 600
// medium   600–1023
// expanded 1024–1439
// large    ≥ 1440
const breakpoints = AppBreakpoints.regular;
final size = breakpoints.resolve(MediaQuery.sizeOf(context).width);
```

### AppResponsiveValue

```FluxUI/packages/utils/lib/src/responsive/app_responsive_value.dart#L1-3
const value = AppResponsiveValue<int>(
  compact: 1,
  medium: 2,
  expanded: 3,
);
final columns = value.resolve(context); // picks the right value automatically
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`
- [`flutter_ui_tokens`](https://pub.dev/packages/flutter_ui_tokens) `^0.1.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [Issue tracker](https://github.com/abdelrzz9/FluxUI/issues)
- [`flutter_ui` — UI component library](https://pub.dev/packages/flutter_ui)
- [`flutter_ui_tokens` — design tokens](https://pub.dev/packages/flutter_ui_tokens)
