# FluxChip

## Overview

Compact element representing an input, attribute, or action. Supports label, icon, dismiss, and selected states.

## Flutter API

```dart
FluxChip(
  label: 'React',
  avatar: Icon(Icons.code),
  onDeleted: () => removeTag('React'),
  onSelected: (v) => setState(() => selected = v),
  variant: FluxChipVariant.outlined,
)
```

## Variants

| Variant | Visual |
|---------|--------|
| filled | Solid background |
| outlined | Border only |
| tonal | Muted background |

## Properties

| Property | Type | Description |
|----------|------|-------------|
| label | String | Chip text |
| avatar | Widget? | Leading icon/avatar |
| onDeleted | VoidCallback? | Show dismiss button |
| selected | bool? | Selected state |
| onSelected | ValueChanged<bool>? | Selection callback |
| variant | FluxChipVariant | Visual variant |
