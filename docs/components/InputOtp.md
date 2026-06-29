# FluxInputOtp

## Overview

One-time password / PIN input component with individual digit slots, caret animation, and optional separator. Ported from `McInputOtp` (MColi UI).

## React Source

`registry/ui/mc-input-otp.tsx` — McInputOtp

## Design Inspiration

Uses the `input-otp` library which provides a complete OTP input primitive with slot management, fake caret animation, and clipboard paste support. Each slot shows the entered character with a blinking caret (fake CSS caret).

## Flutter API

### Constructor

```dart
const FluxInputOtp({
  super.key,
  this.length = 6,
  this.onChanged,
  this.onCompleted,
  this.separator,
  this.separatorIndex,
  this.style,
  this.autofocus = false,
  this.disabled = false,
});
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| length | int | 6 | Number of OTP slots |
| onChanged | ValueChanged<String>? | null | Called when value changes |
| onCompleted | ValueChanged<String>? | null | Called when all digits entered |
| separator | Widget? | null | Custom separator widget |
| separatorIndex | int? | null | Index after which to show separator (e.g., 3 for XXX-XXX) |
| style | FluxInputOtpStyle? | null | Custom style |
| autofocus | bool | false | Auto focus the first slot |
| disabled | bool | false | Disable all input |

### Sub-widgets

```dart
// Slot group container
class FluxInputOtpGroup extends StatelessWidget { ... }

// Individual slot
class FluxInputOtpSlot extends StatelessWidget {
  final int index;
  final String? character;
  final bool isActive;
  final bool hasFakeCaret;
  ...
}

// Separator between slots
class FluxInputOtpSeparator extends StatelessWidget { ... }
```

### Variants

- Standard (default): All slots adjacent
- With separator: Grouped slots (e.g., XXX-XXX)
- Custom styling per slot

### Sizes

Slots are fixed at 40×40px (matching React). Customizable via style.

### States

| State | Visual |
|-------|--------|
| Empty | Border, no character |
| Filled | Character displayed |
| Focused | Active slot with ring highlight |
| Disabled | 50% opacity, no interaction |
| Completed | All slots filled |
| Error | Invalid state (ring in destructive color) |

### Animations

- Fake caret blink: 1s CSS animation (`animate-caret-blink`)
- Active slot ring: ring-2 transition
- Disabled: opacity transition

### Accessibility

- Each slot is a focusable element
- Programmatic focus management (auto-advance)
- Keyboard numeric input
- Paste support for full code
- Screen reader: reads each digit individually

## Examples

```dart
// Simple 6-digit OTP
FluxInputOtp(
  length: 6,
  onCompleted: (code) => verifyCode(code),
)

// 4-digit with autofocus
FluxInputOtp(
  length: 4,
  autofocus: true,
  onChanged: (value) => print(value),
)

// With separator (XXX-XXX)
FluxInputOtp(
  length: 6,
  separatorIndex: 3,
  separator: FluxInputOtpSeparator(),
  onCompleted: (code) => verifyCode(code),
)

// Custom styled
FluxInputOtp(
  length: 6,
  style: FluxInputOtpStyle(
    slotSize: 48,
    slotRadius: 8,
    activeRingColor: context.fluxColors.primary,
    textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  onCompleted: (code) => verifyCode(code),
)
```

## Usage Patterns

```dart
// Form integration
FormField<String>(
  builder: (state) {
    return Column(
      children: [
        FluxInputOtp(
          length: 6,
          onCompleted: (v) => state.didChange(v),
        ),
        if (state.hasError)
          Text(state.errorText!, style: TextStyle(color: Colors.red)),
      ],
    );
  },
)
```

## Best Practices

**Do:**
- Focus first slot on appearance for quick entry
- Show error state with destructive ring color
- Support paste from clipboard

**Don't:**
- Use for passwords (OTP is visible by design)
- Make the field too wide (40×40 per slot is standard)
- Require a submit button — `onCompleted` should be enough

## Implementation Notes

- Flutter implementation uses a row of `TextFormField` widgets with automatic focus forwarding
- Each field accepts one character and forwards focus to the next
- Backspace on empty field returns focus to previous field
- Use `FilteringTextInputFormatter.digitsOnly` for numeric-only input
- `Clipboard` service for paste handling

## Future Improvements

- Shield/hidden mode for sensitive OTPs
- Biometric autofill integration
- Countdown timer resend integration
