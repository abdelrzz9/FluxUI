# FluxCheckbox

## Overview

A checkbox component with label and optional support text. Supports checked, unchecked, and disabled states. Ported from `McCheckbox` (MColi UI).

## React Source

`registry/ui/mc-checkbox.tsx` — McCheckbox

## Design Inspiration

Uses `@base-ui/react/checkbox` for accessible checkbox behavior. The design includes a custom border, hover ring, check indicator animation, and two sizes with label + description text layout.

## Flutter API

### Constructor

```dart
const FluxCheckbox({
  super.key,
  this.size = FluxSize.sm,
  this.value = false,
  this.tristate = false,
  this.onChanged,
  this.text,
  this.supportText,
  this.style,
});
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| size | FluxSize | sm | Checkbox size (sm=16, md=20) |
| value | bool? | false | Checked state |
| tristate | bool | false | Enable indeterminate state |
| onChanged | ValueChanged<bool?>? | null | Change callback |
| text | String? | null | Label text |
| supportText | String? | null | Description text |
| style | FluxCheckboxStyle? | null | Custom style |

### Variants

- Single checkbox with label
- With support/description text
- Tristate (indeterminate) mode

### Sizes

| Size | Checkbox | Text |
|------|----------|------|
| sm | 16px | 14px (text-sm) |
| md | 20px | 16px (text-base) |

### States

| State | Visual |
|-------|--------|
| Unchecked | Border, transparent fill |
| Checked | Brand fill, white checkmark |
| Hover | Border changes to primary color |
| Focused | 4px ring in ring color |
| Disabled unchecked | 50% opacity, muted border |
| Disabled checked | 50% opacity, muted fill |
| Indeterminate | Different icon (minus) |

### Animations

- Border color: `transition-colors`
- Ring on focus: ring-4 animation
- Check icon: Appears/disappears

### Accessibility

- `@base-ui/react` Checkbox with ARIA role
- `aria-labelledby` for text label
- `aria-describedby` for support text
- Keyboard toggle via Space key
- Proper `disabled` attribute
- `autoFocus` support

## Examples

```dart
// Simple checkbox
FluxCheckbox(
  value: acceptTerms,
  onChanged: (v) => setState(() => acceptTerms = v),
)

// With label
FluxCheckbox(
  text: 'Remember me',
  value: remember,
  onChanged: (v) => setState(() => remember = v ?? false),
)

// With support text
FluxCheckbox(
  text: 'Remember me',
  supportText: 'Save my login details for next time.',
  value: remember,
  onChanged: (v) => setState(() => remember = v ?? false),
)

// Disabled
FluxCheckbox(
  text: 'Read-only option',
  value: true,
  onChanged: null, // disabled
)

// Tristate
FluxCheckbox(
  tristate: true,
  value: null, // indeterminate
  onChanged: (v) => setState(() => selection = v),
)
```

## Best Practices

**Do:**
- Keep labels concise
- Use supportText for additional context
- Group related checkboxes in a column

**Don't:**
- Use checkbox for mutually exclusive options (use Radio instead)
- Omit label text — checkbox alone is ambiguous
- Use overly long support text

## Implementation Notes

- On Flutter, uses `Checkbox` widget with custom `CheckboxThemeData` or custom painted checkbox
- The text + supportText layout maps to a `Column` with two `Text` widgets
- Use `MergeSemantics` when both text and checkbox are tappable (so screen readers see one element)

## Future Improvements

- Animated check indicator
- Group validation
- Custom icon slot
