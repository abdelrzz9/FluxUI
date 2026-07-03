# Flux UI — Performance Standards

## Performance Philosophy

1. **Const-first**: Every widget must be `const`-constructible. The compiler optimizes const widgets aggressively.
2. **Composition over RenderObject**: Compose existing widgets unless profiling proves composition is the bottleneck.
3. **No unnecessary rebuilds**: Every `setState` or rebuild must be justified. Use `ValueNotifier` + `ValueListenableBuilder` for localized state.
4. **Measure before optimizing**: Profile with Flutter DevTools before applying optimizations. Never optimize what isn't measured.

## Measurable Targets

### Widget Build Performance

| Metric | Target | Measurement |
|--------|--------|-------------|
| First build time | < 5ms (debug), < 1ms (release) | `FlutterPerformance` timeline |
| Rebuild time | < 1ms (no child rebuilds) | `RepaintBoundary` + timeline |
| Build count | No excess builds beyond state changes | `Builder` count via DevTools |
| Widget tree depth | < 20 nodes per component | `toStringDeep` depth |
| Element count | < 50 elements per component | `Element` tree inspection |

### Memory

| Metric | Target | Measurement |
|--------|--------|-------------|
| Allocation per build | < 50 KB | `dart:developer` memory allocation |
| Persistent memory | < 200 KB per component instance | DevTools memory tab |
| OverlayEntry reuse | Reuse entries, not recreate | Code inspection |
| AnimationController count | 0-1 per StatefulWidget | DevTools timeline |
| StreamSubscription count | Must dispose in dispose() | Lint rule `close_sinks` |

### Frame Budget

| Metric | Target |
|--------|--------|
| Frame build time | < 8ms (120fps target: < 4ms) |
| Frame raster time | < 8ms |
| Total frame time | < 16ms (60fps), < 8ms (120fps) |
| Layer count | < 20 layers per scene |
| Repaint count | Minimize — use `RepaintBoundary` |

### Animation Budget

| Metric | Target |
|--------|--------|
| Concurrent animations | ≤ 3 per visible screen |
| Animation frame drop | < 1% of frames |
| Animation controller duration | ≥ 100ms (avoid instantaneous animations) |
| Tween complexity | < 10 properties per tween |

## Rules

### Const Rules

```dart
// GOOD: const constructor
const FluxButton({super.key, ...});

// GOOD: const child in build
build() {
  return const FluxButton(child: Text('Hi'));
}

// BAD: non-const when it could be const
FluxButton(child: Text('Hi'));  // missing const
```

### Widget Splitting

```dart
// GOOD: Extract sub-widgets to limit rebuild scope
class FluxCard extends StatelessWidget {
  const FluxCard({super.key, ...});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CardHeader(),  // const — never rebuilds
        _CardBody(content),    // rebuilds when content changes
        const _CardFooter(),  // const — never rebuilds
      ],
    );
  }
}
```

### Tear-offs Over Closures

```dart
// GOOD: tear-off, creates no closure object
onPressed: _handleTap,

// BAD: closure, creates new object per build
onPressed: () => _handleTap(),
```

### Avoid Repeated Allocations

```dart
// GOOD: cached style
static final _buttonStyle = ButtonStyle(...);

// GOOD: const list (class-level)
static const _sizes = [FluxButtonSize.sm, FluxButtonSize.md, FluxButtonSize.lg];

// BAD: allocation in build
build() {
  final style = ButtonStyle(...); // created every frame
}
```

### Use RepaintBoundary

```dart
// GOOD: isolate complex paint operations
RepaintBoundary(
  child: ShimmerWidget(...),
)
```

### Use AnimatedBuilder Over setState

```dart
// GOOD: localized animation rebuilds
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) => Transform.scale(
    scale: _controller.value,
    child: child,
  ),
  child: const Text('Scale me'),
)

// BAD: rebuilds entire widget tree
setState(() => _scale = _controller.value);
```

### WidgetStateProperty Caching

```dart
// GOOD: cached WidgetStateProperty
static final _defaultBackground = WidgetStateProperty.resolveWith((states) {
  if (states.contains(WidgetState.disabled)) return Colors.grey;
  return Colors.blue;
});

// BAD: created per build
final background = WidgetStateProperty.resolveWith((states) => ...);
```

## RenderObject Usage Criteria

Use `RenderObject` ONLY when:

1. Custom layout algorithm is needed (proof via measurement)
2. Custom hit testing behavior is required
3. `RenderBox` paint is measurably faster than widget composition (>20% improvement)
4. Access to `Canvas` for complex drawing is significantly more efficient

**Default**: Always start with composition. Measure. Only rewrite as `RenderObject` if composition fails targets.

## CustomPainter Usage Criteria

Use `CustomPainter` ONLY when:

1. Drawing gradients, patterns, or complex shapes that would require many stacked widgets
2. Shimmer/glass/skeleton effects
3. Focus rings (to avoid layout side effects)
4. Chart-like visualizations

**Rules**:
- Implement `shouldRepaint` to return false when repaint isn't needed
- Implement `shouldRebuildSemantics` when semantics change
- Avoid `CustomPainter` for simple rectangles or borders — use `Container` or `DecoratedBox`

## Avoiding StatefulWidget

Use `StatelessWidget` when:

1. All state is managed externally (via `ValueNotifier`, `InheritedWidget`, or lifting)
2. The widget only needs a `TickerProvider` — extract to a dedicated `AnimatedWidget`
3. Animation can be handled by `ImplicitlyAnimatedWidget` (e.g., `AnimatedContainer`, `TweenAnimationBuilder`)

Consider `AnimatedWidget` or `ImplicitlyAnimatedWidget` before `StatefulWidget` + `AnimationController`.

## Benchmark Requirements

Every component must have a benchmark file that measures:

1. **Build time**: Time to create the widget tree
2. **Layout time**: Time to lay out the widget tree
3. **Paint time**: Time to paint the widget tree
4. **State change rebuild**: Time to rebuild on state change (e.g., button press)
5. **Memory allocation**: Heap allocations during build

Benchmarks run in:
- Debug mode (development baseline)
- Release mode (production baseline)
- Profile mode (real-world performance)

```dart
// benchmarks/lib/flux_button_benchmark.dart
import 'package:flutter_benchmark/flutter_benchmark.dart';

void main() {
  benchmark('FluxButton build', () {
    pumpWidget(MaterialApp(
      home: FluxButton(child: const Text('Benchmark')),
    ));
  });
}
```

## Performance Regression Detection

- Benchmarks fail if performance degrades by >10% from baseline
- Golden tests fail if visual output changes
- CI runs benchmarks on release branches only
- Historical data stored in `benchmarks/data/`
