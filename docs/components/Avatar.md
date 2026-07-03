# FluxAvatar

## Overview

Displays user profile images or initials as a fallback. Supports multiple sizes and shapes.

## Flutter API

```dart
const FluxAvatar({
  super.key,
  this.image,
  this.initials,
  this.size = FluxSize.md,
  this.shape = FluxAvatarShape.circle,
  this.badge,
  this.onPressed,
});

enum FluxAvatarShape { circle, rounded, square }
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| image | ImageProvider? | null | Avatar image |
| initials | String? | null | Fallback initials (1-2 chars) |
| size | FluxSize | md | Avatar size |
| shape | FluxAvatarShape | circle | Shape variant |
| badge | Widget? | null | Badge overlay |
| onPressed | VoidCallback? | null | Tap callback |

## Sizes

| Size | Dimension |
|------|-----------|
| xs | 24px |
| sm | 32px |
| md | 40px |
| lg | 48px |
| xl | 64px |

## Fallback Behavior

1. If `image` is non-null and loads: show image
2. If `image` is null or fails: show initials text on muted background
3. If both null: show default person icon
