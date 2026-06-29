# FluxProgress

## Overview

Progress indicators for loading states. Supports determinate and indeterminate modes, linear and circular shapes.

## Flutter API

```dart
// Linear determinate
FluxProgress.linear(
  value: 0.6,                // 0.0 - 1.0
  variant: FluxProgressVariant.primary,
)

// Linear indeterminate
FluxProgress.linear()

// Circular determinate
FluxProgress.circular(
  value: 0.6,
  size: 40,
)

// Circular indeterminate
FluxProgress.circular()
```

## Variants

| Variant | Color |
|---------|-------|
| primary | Primary brand color |
| secondary | Secondary brand color |
| success | Green |
| warning | Orange |
| error | Red |
