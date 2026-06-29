# Flux UI — Accessibility Standards

## Philosophy

Every Flux widget must be usable by everyone, regardless of ability. Accessibility is not optional — it is a core requirement at parity with functionality.

## Mandatory Requirements

### 1. Semantics

Every interactive widget MUST include a `Semantics` widget with:

```dart
Semantics(
  label: semanticLabel,           // human-readable label
  hint: semanticHint,             // usage hint
  value: semanticValue,           // current value
  increasedValue: increasedValue, // value when incremented
  decreasedValue: decreasedValue, // value when decremented
  button: true,                   // correct role
  enabled: !isDisabled,            // interactive state
  checked: isChecked,             // for checkbox/radio
  selected: isSelected,           // for tabs/chips
  toggled: isToggled,            // for switches
  slider: isSlider,              // for sliders
  header: isHeader,              // for section headers
  link: isLink,                  // for links
  hidden: isHidden,              // for decorative only
  onTap: onTapHandler,           // actions
  onLongPress: onLongPressHandler,
  child: ...
)
```

**Rules**:
- `label` is required for ALL interactive elements
- Use `hint` sparingly — only when the action is not obvious from `label`
- Set `excludeSemantics: true` on decorative elements (icons without meaning, dividers, spacers)
- Never nest `Semantics` widgets that conflict (e.g., two `button: true` in a row)

### 2. Keyboard Navigation

Every interactive widget MUST support keyboard interaction:

```dart
class FluxButton extends StatelessWidget {
  const FluxButton({
    super.key,
    this.focusNode,
    this.onFocusChange,
    this.onPressed,
    ...
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onKey: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
          onPressed?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Semantics(...),
    );
  }
}
```

**Rules**:
- All clickable widgets must activate on `Enter` and `Space`
- Tab widgets must navigate with `ArrowLeft`/`ArrowRight` (horizontal) or `ArrowUp`/`ArrowDown` (vertical)
- Slider must adjust with `ArrowLeft`/`ArrowRight` and `ArrowUp`/`ArrowDown`
- Dialog must trap focus — Tab cycles within dialog, Escape closes
- Dropdown must open on `Enter`/`Space`/`ArrowDown`, navigate with arrows, select with `Enter`, close with `Escape`
- Custom keyboard shortcuts must use `Shortcuts` + `Actions` widgets
- Provide `Keys` for integration test targeting

### 3. Focus Traversal

```dart
FocusTraversalGroup(
  policy: const ReadingOrderTraversalPolicy(),
  child: Column(
    children: [
      FluxButton(child: Text('First')),
      FluxButton(child: Text('Second')),
      FluxButton(child: Text('Third')),
    ],
  ),
)
```

**Rules**:
- Use `ReadingOrderTraversalPolicy` by default
- Use `OrderedTraversalPolicy` for custom focus order (e.g., form fields in a specific sequence)
- Use `ExcludeFocus` on decorative/non-interactive elements
- Override `TraversalEdgeBehavior` for looping (Tab cycles through form fields)
- Modal widgets (Dialog, BottomSheet, Popover) must focus-trap

### 4. Touch Targets

```dart
// Minimum touch target: 48x48 dp (Material Design guideline)
SizedBox(
  width: 48,
  height: 48,
  child: FluxIconButton(...),
)
```

**Rules**:
- All interactive elements must have minimum 48×48 dp touch targets
- Use `InkWell` or `GestureDetector` with `behavior: HitTestBehavior.opaque` and sufficient padding
- Small elements (icon buttons, tag dismiss) must include padded hit regions
- Test with `FlutterDriver` for tap targets on real devices

### 5. Color Contrast

```dart
// Programmatic contrast check
final contrast = Color.contrast(foreground, background);
assert(contrast >= 7.0, 'Text must meet WCAG AAA (7:1)');
assert(contrast >= 4.5, 'Large text (>24px) must meet WCAG AA (4.5:1)');
```

**Rules**:
- Normal text (< 18pt): WCAG AA 4.5:1, WCAG AAA 7:1
- Large text (≥ 18pt bold or ≥ 24pt): WCAG AA 3:1, WCAG AAA 4.5:1
- UI components (icons, focus indicators): WCAG AA 3:1
- High contrast mode: WCAG AAA 7:1 for all text
- Test with `HighContrastTheme` enabled

### 6. Large Text Support

```dart
// Respect textScaleFactor
final scale = MediaQuery.textScaleFactorOf(context);
final fontSize = baseSize * scale;

// Test at 200% scale
await tester.pumpWidget(
  MediaQuery(
    data: MediaQueryData(textScaleFactor: 2.0),
    child: FluxButton(...),
  ),
);
```

**Rules**:
- All text must render without overflow at 200% text scale
- Min/max font size constraints are allowed (via `MediaQuery.textScaleFactor` capping)
- Fixed-height containers must have `overflow` handling
- Test with `textScaleFactor: 2.0` in widget tests

### 7. Reduced Motion

```dart
build() {
  final reduceMotion = MediaQuery.reducedMotionOf(context);
  return reduceMotion
      ? const _StaticContent()     // no animation
      : _AnimatedContent();         // with animation
}
```

**Rules**:
- When `MediaQuery.reducedMotion` is true, disable non-essential animations
- Essential animations (progress indicators, transitions between screens) may remain but must be slowed/diminished
- `AnimationController.duration` can be set to 0 when reduced motion is active
- Use `FluxAnimatedVisibility` with `animateFirst: false` to skip animation on first mount

### 8. RTL Support

```dart
// Use EdgeInsetsDirectional instead of EdgeInsets.only(left/right)
padding: EdgeInsetsDirectional.only(
  start: 16,
  end: 8,
),

// Use TextAlign.start instead of TextAlign.left
textAlign: TextAlign.start,

// Use AlignmentDirectional instead of Alignment.centerLeft
alignment: AlignmentDirectional.centerStart,
```

**Rules**:
- Never use `EdgeInsets.only(left: ...)` or `EdgeInsets.only(right: ...)`
- Never use `TextAlign.left` or `TextAlign.right` — use `TextAlign.start` or `TextAlign.end`
- Never use `Alignment.centerLeft` or `Alignment.centerRight` — use `AlignmentDirectional.centerStart` or `AlignmentDirectional.centerEnd`
- Test every component with `Directionality(TextDirection.rtl)`
- Golden tests must include RTL variants
- Icons that imply direction (arrow, chevron) must rotate/flip in RTL

### 9. Screen Reader Labels

```dart
// GOOD: descriptive label
Semantics(
  label: 'Close dialog',
  button: true,
  child: FluxIconButton(icon: Icons.close),
)

// BAD: missing label
Semantics(
  button: true,
  child: FluxIconButton(icon: Icons.close),
)
```

**Rules**:
- Every icon-only button must have a `semanticLabel`
- Images must have `semanticLabel` or be marked `excludeSemantics: true`
- Form fields must have associated labels
- Grouped elements (radio group, tab list) must be wrapped in `Semantics` with appropriate container role
- Dynamic content must announce changes (use `liveRegion` in `Semantics`)

### 10. Desktop Accessibility

```dart
// Keyboard shortcut support
Actions(
  dispatcher: ActionDispatcher(),
  actions: <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (intent) => onPressed?.call(),
    ),
  },
  child: Focus(
    child: FluxButton(...),
  ),
)
```

**Rules**:
- Support `Tab` for focus, `Enter`/`Space` for activation
- Support common shortcuts where appropriate (`Escape` to close, `Ctrl+Z` to undo)
- `MouseRegion` for hover state
- `SystemMouseCursors.click` on actionable elements, `.forbidden` on disabled
- Focus ring visible on keyboard focus (not on click)

### 11. Testing Accessibility

```dart
// Widget test semantics check
testWidgets('FluxButton has Semantics', (tester) async {
  await tester.pumpWidget(FluxButton(
    child: const Text('Submit'),
    semanticLabel: 'Submit form',
  ));
  expect(
    tester.getSemantics(find.byType(FluxButton)),
    matchesSemantics(
      label: 'Submit form',
      isButton: true,
      isEnabled: true,
      hasTapAction: true,
    ),
  );
});

// Reduced motion test
testWidgets('FluxDialog disables animation with reduced motion', (tester) async {
  await tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: FluxDialog(...),
    ),
  );
  // Verify animation is skipped / instant
});

// High contrast test
testWidgets('FluxButton renders in high contrast', (tester) async {
  await tester.pumpWithHighContrast(
    FluxButton(child: Text('OK')),
  );
  // Verify contrast ratio
});
```

## Accessibility Audit Checklist

For every component PR:

- [ ] `Semantics` exists with correct role
- [ ] `label` is provided (or `excludeSemantics` is intentional)
- [ ] Keyboard navigation works (Tab, Enter, Escape, Arrows)
- [ ] Focus ring is visible when keyboard-focused
- [ ] Touch target ≥ 48×48 dp
- [ ] Color contrast ≥ 4.5:1 (AA) for text, ≥ 3:1 for UI
- [ ] Works at 200% text scale
- [ ] Reduced motion respected
- [ ] RTL layout renders correctly
- [ ] Screen reader announces correctly
- [ ] Desktop: mouse cursor changes appropriately
- [ ] Desktop: `SystemMouseCursors` correct for state (click, forbidden, etc.)

## Tools

| Tool | Purpose |
|------|---------|
| `flutter test --reporter expanded` | Semantics test output |
| `SemanticsTester` | Programmatic semantics verification |
| `AccessibilityWidgetTester` | Pumps with accessibility features |
| Flutter DevTools | Focus/highlight visible Semantics nodes |
| `FlutterDriver` | End-to-end a11y testing on devices |
| `axe-core` (web) | Web accessibility audit |
| `VoiceOver` (iOS) | Screen reader testing |
| `TalkBack` (Android) | Screen reader testing |
| `NVDA` (Desktop) | Screen reader testing |
