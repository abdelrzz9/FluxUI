# FluxSwitch

## Overview

Toggle switch for binary settings. Supports labels and multiple sizes.

## Flutter API

```dart
FluxSwitch(
  value: isEnabled,
  onChanged: (v) => setState(() => isEnabled = v),
  label: 'Enable notifications',
  size: FluxSize.md,
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| value | bool | false | Current state |
| onChanged | ValueChanged<bool>? | null | Change callback |
| label | String? | null | Label text |
| size | FluxSize | md | Switch size |
| disabled | bool | false | Disabled state |

## Sizes

| Size | Track | Thumb |
|------|-------|-------|
| sm | 28×16 | 12px |
| md | 36×20 | 16px |
| lg | 44×24 | 20px |
