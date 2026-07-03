# FluxCard

## Overview

A versatile surface container with elevation, outline, and tonal variants. Provides consistent card styling across themes.

## React Source

MColi UI does not have a dedicated card component file, but the design tokens define card colors (`--card`, `--card-foreground`). This component is adapted from shadcn/ui conventions used by MColi.

## Flutter API

```dart
const FluxCard({
  super.key,
  this.variant = FluxCardVariant.elevated,
  this.padding = const EdgeInsets.all(16),
  this.onPressed,
  this.style,
  required this.child,
});

enum FluxCardVariant {
  elevated,  // Shadow with background
  outlined,  // Border with transparent background
  tonal,     // Muted background, no shadow
}
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| variant | FluxCardVariant | elevated | Card visual style |
| padding | EdgeInsets | 16px all | Inner padding |
| onPressed | VoidCallback? | null | Makes card tappable |
| style | FluxCardStyle? | null | Custom styling |
| child | Widget | - | Card content |

## States

- Default
- Hover (if tappable)
- Pressed (if tappable)

## Theme Integration

Uses `--card` / `--card-foreground` tokens from the current theme.
