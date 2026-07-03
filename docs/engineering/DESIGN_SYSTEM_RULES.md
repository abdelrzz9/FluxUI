# Flux UI — Design System Rules

## Immutable Design Tokens

These tokens are **immutable** — they never change between components, brands, or themes. A spacing of `4` is always `4` logical pixels. A radius of `8` is always `8`.

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| `0` | 0px | No spacing |
| `0.5` | 2px | Dense layout, icons |
| `1` | 4px | **Base unit** — tight spacing |
| `1.5` | 6px | Tight insets |
| `2` | 8px | Default spacing between related elements |
| `2.5` | 10px | Comfortable spacing |
| `3` | 12px | Section padding |
| `3.5` | 14px | Slightly larger padding |
| `4` | 16px | Card padding, form field spacing |
| `5` | 20px | Section gaps |
| `6` | 24px | Page margins |
| `7` | 28px | Large gaps |
| `8` | 32px | Section separators |
| `9` | 36px | Extra large |
| `10` | 40px | Page section padding |
| `12` | 48px | Large page margins |
| `14` | 56px | App bar padding |
| `16` | 64px | Maximum spacing |

**Rule**: Never use values outside this scale. No exceptions.

### Radius Scale

| Token | Value | Usage |
|-------|-------|-------|
| `none` | 0px | Sharp corners |
| `xs` | 2px | Tag, badge |
| `sm` | 4px | Button, input |
| `md` | 6px | Card, dialog |
| `lg` | 8px | Popover, drawer |
| `xl` | 12px | Bottom sheet |
| `2xl` | 16px | Dialog (large) |
| `pill` | 999px | Pill/tag, chip |

**Rule**: Never use custom radii outside this scale. Use `pill` for fully rounded elements.

### Typography Scale

| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| `display-2xl` | 72px | 400 | 90px | -2% | Hero headings |
| `display-xl` | 60px | 400 | 72px | -2% | Page headers |
| `display-lg` | 48px | 400 | 60px | -2% | Section headers |
| `display-md` | 36px | 400 | 44px | -1% | Major headers |
| `display-sm` | 30px | 400 | 38px | 0% | Sub-section headers |
| `display-xs` | 24px | 400 | 32px | 0% | Card headers |
| `text-xl` | 20px | 400 | 30px | 0% | Large body |
| `text-lg` | 18px | 400 | 28px | 0% | Body large |
| `text-md` | 16px | 400 | 24px | 0% | **Default body** |
| `text-sm` | 14px | 400 | 20px | 0% | Small text, captions |
| `text-xs` | 12px | 400 | 18px | 0% | Tiny text, metadata |

**Semantic weights**: `regular` (400) for body, `medium` (500) for emphasis, `semibold` (600) for subheads, `bold` (700) for headers.

**Rule**: Never use font sizes, weights, or line heights outside this scale.

### Elevation (Shadows)

| Token | Offset X | Offset Y | Blur | Spread | Alpha | Usage |
|-------|----------|----------|------|--------|-------|-------|
| `none` | 0 | 0 | 0 | 0 | 0% | Flat elements |
| `xs` | 0 | 1 | 4 | 0 | 4% | Subtle depth |
| `sm` | 0 | 4 | 12 | -4 | 8% | Cards, popovers |
| `md` | 0 | 4 | 6 | -1 | 10% | Dialogs |
| `lg` | 0 | 10 | 15 | -3 | 10% | Dropdowns, drawers |
| `xl` | 0 | 16 | 20 | -5 | 10% | Modals |
| `2xl` | 0 | 20 | 25 | -5 | 10% | Bottom sheets |
| `3xl` | 0 | 25 | 50 | -12 | 12% | Focus state |

**Rule**: Use only these elevation levels. Never create custom shadow values in components.

### Motion (Durations)

| Token | Value | Usage |
|-------|-------|-------|
| `instant` | 0ms | Instant transitions (reduced motion) |
| `fastest` | 100ms | Micro-interactions, tooltips |
| `fast` | 150ms | Small state changes (hover, focus) |
| `normal` | 200ms | **Default** — standard transitions |
| `slow` | 300ms | Larger transitions (dialogs, drawers) |
| `slower` | 500ms | Page transitions, hero animations |

### Motion (Curves)

| Token | Curve | Usage |
|-------|-------|-------|
| `default` | `easeInOut` | Standard transitions |
| `emphasized` | `easeInOutCubic` | Content emphasis |
| `emphasizedDecel` | `decelerate` | Content entering |
| `emphasizedAccel` | `accelerate` | Content leaving |
| `spring` | `easeOutBack` | Overshoot effect |

**Rule**: Use only these curves. `spring` is reserved for playful brand moments.

### Icon Sizing

| Token | Value | Usage |
|-------|-------|-------|
| `xs` | 12px | Inline with small text |
| `sm` | 16px | Inline with body text |
| `md` | 20px | Default icon size |
| `lg` | 24px | Standalone icons |
| `xl` | 32px | Hero/feature icons |
| `2xl` | 40px | Section icons |
| `3xl` | 48px | Empty state icons |

**Rule**: Never use custom icon sizes.

### Color Usage

| Token | Role | Example |
|-------|------|---------|
| `primary` | Brand color, primary actions | Button fill |
| `onPrimary` | Content on primary surfaces | Button text |
| `secondary` | Secondary brand color | Tabs, secondary buttons |
| `onSecondary` | Content on secondary | Tabs text |
| `surface` | Card/dialog background | Card, Dialog |
| `onSurface` | Content on surface | Body text |
| `background` | Page background | Scaffold |
| `onBackground` | Content on background | Page text |
| `error` | Error state | Validation error |
| `onError` | Content on error | Error button text |
| `outline` | Borders | Input border |
| `outlineVariant` | Subtle borders | Divider |
| `shadow` | Shadow color | Drop shadow |
| `scrim` | Background dimming | Modal scrim |

**Rule**: Never use raw colors in components — always resolve through semantic color tokens. A component must never say `Colors.blue` — it must say `context.fluxColors.primary`.

### State Layers

| State | Opacity Overlay | Effect |
|-------|----------------|--------|
| Hover | 8% of `onSurface` | Subtle darkening |
| Focus | 12% of `onSurface` | Focus ring + overlay |
| Press | 16% of `onSurface` | Strong feedback |
| Drag | 20% of `onSurface` | Drag feedback |
| Disabled | 38% opacity of element | Content fade |

**Rule**: Use these standard state layer opacities. Use `WidgetStateProperty` to resolve state-dependant values.

### Opacity

| Token | Value | Usage |
|-------|-------|-------|
| `disabled` | 0.38 | Disabled content |
| `hint` | 0.60 | Hint text, placeholder |
| `medium` | 0.74 | Secondary content |
| `high` | 0.87 | Primary content (default) |

**Rule**: Never use arbitrary opacity values.

### Animation Timing (Component-Specific)

| Component | Duration | Curve |
|-----------|----------|-------|
| Button hover | 150ms | `easeInOut` |
| Button press | 100ms | `easeInOut` |
| Checkbox toggle | 200ms | `easeInOut` |
| Switch toggle | 200ms | `spring` |
| Dialog enter | 200ms | `emphasizedDecel` |
| Dialog exit | 150ms | `emphasizedAccel` |
| Tooltip show | 200ms | `easeInOut` |
| Tooltip hide | 100ms | `easeInOut` |
| Tab indicator | 200ms | `easeInOut` |
| Accordion expand | 200ms | `easeInOut` |
| Drawer open | 300ms | `emphasizedDecel` |
| Drawer close | 200ms | `emphasizedAccel` |
| Toast enter | 200ms | `emphasizedDecel` |
| Toast exit | 150ms | `emphasizedAccel` |

**Rule**: These are per-component defaults. Users may override via component theme extensions.

## Anti-Duplication Rule

**No component-specific token duplication.**

If two components need the same `md` spacing value, they both read from `FluxSpacingTheme.md`. They do NOT each define their own `md` property.

If `FluxButton` and `FluxCard` both need `md` border radius, they both read `FluxShapeTheme.md`. They do NOT each define `md` in their own theme extension.

Component-specific theme extensions may store component-specific values (e.g., `FluxButtonTheme.horizontalPadding`), but they must reference global tokens for base values (spacing, radius, color).
