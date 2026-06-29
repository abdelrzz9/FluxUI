# FluxDivider

## Overview

A visual divider for separating content. Supports horizontal, vertical, and labeled variants.

## Flutter API

```dart
// Horizontal
FluxDivider()

// With label
FluxDivider(label: 'OR')

// Vertical
FluxDivider.vertical()

// Custom thickness
FluxDivider(thickness: 2, color: Colors.grey[300])
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| label | String? | null | Optional label text |
| thickness | double | 1 | Line thickness |
| color | Color? | null | Custom color |
| indent | double | 0 | Left margin |
| endIndent | double | 0 | Right margin |
