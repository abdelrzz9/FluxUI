# FluxAlert

## Overview

Display prominent feedback messages. Supports success, warning, error, and info variants.

## Flutter API

```dart
const FluxAlert({
  super.key,
  this.variant = FluxAlertVariant.info,
  this.title,
  this.description,
  this.action,
  this.dismissible = false,
  this.icon,
});

enum FluxAlertVariant {
  success,  // Green
  warning,  // Orange
  error,    // Red
  info,     // Blue
}
```

## Properties

| Property | Type | Description |
|----------|------|-------------|
| variant | FluxAlertVariant | Alert type |
| title | String? | Bold title text |
| description | String? | Body text |
| action | Widget? | Optional action button |
| dismissible | bool | Show dismiss button |
| icon | Widget? | Custom icon override |

## Theme Tokens

| Variant | Background | Foreground | Icon |
|---------|-----------|------------|------|
| success | `--success` | `--success-foreground` | CheckCircle |
| warning | `--warning` | `--warning-foreground` | AlertTriangle |
| error | `--destructive` | `--destructive-foreground` | XCircle |
| info | `--info` | `--info-foreground` | Info |
