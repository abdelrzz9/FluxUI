# FluxBadge

## Overview

A small badge indicator displaying a count, dot, or custom content. Typically overlaid on other components.

## Flutter API

```dart
const FluxBadge({
  super.key,
  this.variant = FluxBadgeVariant.standard,
  this.position = FluxBadgePosition.topEnd,
  this.count,
  this.dot = false,
  this.maxCount = 99,
  this.color,
  this.child,
});
```

## Variants

| Variant | Use |
|---------|-----|
| standard | Default colored badge |
| dot | Small dot indicator |
| success | Green badge |
| warning | Orange badge |
| error | Red badge |
| info | Blue badge |
