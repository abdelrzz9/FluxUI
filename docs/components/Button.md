# FluxButton

## Overview

A versatile button component supporting multiple variants, sizes, icon positions, loading state, and destructive mode. Ported from `McButton` (MColi UI) and `Button` (base shadcn variant).

## React Source

- `registry/ui/mc-button.tsx` — McButton (primary/secondary/tertiary/link)
- `components/ui/button.tsx` — Base Button (default/outline/secondary/ghost/destructive/link)

## Design Inspiration

MColi UI's button system uses `class-variance-authority` for variant management and `@base-ui/react` for accessibility primitives. The button supports leading/trailing/dot/only icon modes and a loading spinner.

## Flutter API

### Constructor

```dart
const FluxButton({
  super.key,
  this.variant = FluxButtonVariant.primary,
  this.size = FluxSize.md,
  this.leading,
  this.trailing,
  this.icon,
  this.loading = false,
  this.destructive = false,
  this.onPressed,
  this.style,
  this.semanticLabel,
  required this.child,
});
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| variant | FluxButtonVariant | primary | Visual style variant |
| size | FluxSize | md | Button size |
| leading | Widget? | null | Leading icon |
| trailing | Widget? | null | Trailing icon |
| icon | FluxButtonIcon? | null | Icon mode (leading/trailing/dot/only) |
| loading | bool | false | Show loading spinner |
| destructive | bool | false | Destructive color override |
| onPressed | VoidCallback? | null | Tap callback |
| style | FluxButtonStyle? | null | Custom style override |
| semanticLabel | String? | null | Accessibility label |
| child | Widget | - | Button label content |

### Variants

```dart
enum FluxButtonVariant {
  primary,    // Filled brand color
  secondary,  // Soft brand background
  tertiary,   // Subtle brand tint
  link,       // Text-only, underline
  outline,    // Bordered (from base Button)
  ghost,      // Transparent, hover only (from base Button)
  destructive,// Error/danger (from base Button)
}
```

### Sizes

```dart
enum FluxSize {
  xs,  // 24px height
  sm,  // 28px height
  md,  // 32px height
  lg,  // 36px height
  xl,  // 40px height
}
```

### States

| State | Visual |
|-------|--------|
| Default | Normal colors, no effects |
| Hover | Slightly darker/lighter background |
| Pressed/Active | Ring indicator + background shift |
| Focused | Focus ring (--ring color) |
| Loading | Spinner replaces content |
| Disabled | 50% opacity, no pointer events |

### Icon Modes

```dart
enum FluxButtonIcon {
  leading,  // Icon before text
  trailing, // Icon after text
  dot,      // Small dot indicator
  only,     // Icon-only (square button)
}
```

### Animations

- Transition: `all 150ms` ease
- Press: Subtle Y-translate (`translate-y-px`)
- Ring: 4px ring on active
- Spinner: Continuous rotation (used for loading)

### Accessibility

- Built on `Button` from `@base-ui/react` (ARIA button role)
- Keyboard: Enter/Space to activate
- Focus-visible ring
- Disabled state prevents interaction
- `semanticLabel` for icon-only buttons

## Examples

```dart
// Primary with leading icon
FluxButton(
  variant: FluxButtonVariant.primary,
  leading: Icon(Icons.add),
  onPressed: () {},
  child: Text('Create'),
)

// Loading state
FluxButton(
  loading: true,
  onPressed: () {},
  child: Text('Saving...'),
)

// Icon only
FluxButton(
  icon: FluxButtonIcon.only,
  leading: Icon(Icons.plus),
  onPressed: () {},
)

// Destructive variant
FluxButton(
  destructive: true,
  variant: FluxButtonVariant.primary,
  onPressed: () {},
  child: Text('Delete'),
)

// Link variant with trailing icon
FluxButton(
  variant: FluxButtonVariant.link,
  trailing: Icon(Icons.arrow_forward),
  onPressed: () {},
  child: Text('Learn more'),
)
```

## Best Practices

**Do:**
- Use `primary` for main CTAs, `secondary` for alternative actions
- Add `semanticLabel` to icon-only buttons
- Show `loading` during async operations

**Don't:**
- Stack multiple `primary` buttons
- Use `link` variant in dense layouts (too subtle)
- Omit text for icon-only buttons without a tooltip

## Performance

- `const` constructor for static buttons
- Builder pattern available for dynamic content
- Minimal widget rebuilds via separation of style vs content

## Implementation Notes

- Flutter's `TextButton`, `ElevatedButton`, `OutlinedButton` provide similar primitives; FluxButton wraps them with consistent styling
- Use `InkWell` or `GestureDetector` with `Material` for ripple
- Variants map to M3 Button styles but override colors

## Future Improvements

- Add `FluxButtonGroup` for segmented button groups
- Add dropdown/toggle button variants
- Support custom loading widget
