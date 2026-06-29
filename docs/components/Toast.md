# FluxToast

## Overview

Brief, auto-dismissing notification messages that appear at the top or bottom of the screen.

## Flutter API

```dart
// Show toast
FluxToast.show(
  context: context,
  message: 'Item saved',
  variant: FluxToastVariant.success,
  action: FluxToastAction(label: 'Undo', onPressed: () {}),
  duration: Duration(seconds: 4),
);

enum FluxToastVariant { success, error, warning, info }
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| message | String | - | Toast text |
| variant | FluxToastVariant | info | Visual style |
| action | FluxToastAction? | null | Action button |
| duration | Duration | 4s | Display duration |
| position | ToastPosition | top | Top or bottom |

## Animations

- Slide in from top/bottom
- Auto-dismiss with fade out
- Stack multiple toasts with vertical offset
