# FluxSkeleton

## Overview

Loading placeholder component that shows a pulsing shimmer animation. Ideal for content that hasn't loaded yet.

## Flutter API

```dart
const FluxSkeleton({
  super.key,
  this.variant = FluxSkeletonVariant.text,
  this.width,
  this.height,
  this.borderRadius,
  this.lines = 1,
});

enum FluxSkeletonVariant {
  text,      // Single line / multi-line
  circle,    // Circular placeholder
  rectangle, // Rectangular placeholder
  card,      // Card-shaped placeholder
}
```

## Variants

| Variant | Default Shape |
|---------|---------------|
| text | Full-width, 16px height, 4px radius |
| circle | 40×40 circle |
| rectangle | 100% × 200 rectangle, 8px radius |
| card | Card dimensions, card radius |

## Animation

- Shimmer gradient sweep animation
- Duration: ~1.5s infinite loop
- Direction: left-to-right
- Uses `ShaderMask` or `AnimatedBuilder` with gradient
