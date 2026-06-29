# FluxDialog

## Overview

Modal dialog for confirmations, alerts, and custom content. Overlays the current screen with a dimmed backdrop.

## Flutter API

```dart
// Show dialog
Future<T?> showFluxDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
});

// Convenience constructors
FluxDialog.alert({
  required String title,
  required String message,
  required String confirmLabel,
  VoidCallback? onConfirm,
});

FluxDialog.confirm({
  required String title,
  required String message,
  required String cancelLabel,
  required String confirmLabel,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
});
```

## Variants

| Variant | Use |
|---------|-----|
| alert | Single action (OK) |
| confirm | Two actions (Cancel/Confirm) |
| custom | Custom content widget |
| fullscreen | Full-screen dialog |

## Animations

- Fade in backdrop
- Scale in dialog content
- Duration: 200ms
