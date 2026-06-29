# Flux UI — API Stability & Maturity Levels

## API Maturity Levels

### 🧪 Experimental

**Meaning**: API is under active development. May change without notice.

**Requirements for promotion**:
- Design document reviewed by architecture team
- At least 1 positive review
- Unit tests written
- CI passes

**Deprecation on removal**: None — consumers are warned not to use in production.

**Badge**: `@Experimental()` annotation

```dart
@Experimental()
class FluxExperimentalWidget extends StatelessWidget {
  const FluxExperimentalWidget({super.key});
}
```

---

### 🔄 Preview

**Meaning**: API is stable but may receive minor changes before stabilization.

**Requirements for promotion to Preview**:
- 2 weeks of field testing (internal or with early adopters)
- Unit tests + widget tests
- Documentation written
- Component documentation in `docs/components/`
- All CODING_STANDARDS rules followed
- 2 positive reviews

**Requirements for promotion to Stable**:
- 1 minor version at Preview level
- Golden tests passing
- Accessibility tests passing
- `debugFillProperties` implemented
- RTL support verified
- Theme extension integration verified
- 3 positive reviews including 1 from architecture lead

**Deprecation on removal**: 1 minor version notice

**Badge**: `@Preview()` annotation

```dart
@Preview()
class FluxPreviewWidget extends StatelessWidget {
  const FluxPreviewWidget({super.key});
}
```

---

### ✅ Stable

**Meaning**: API is committed. Will not break within the same major version.

**Requirements for promotion**:
- Passed all Preview requirements
- At least 1 minor version as Preview
- Golden tests for all visual variants
- Widget tests for all variants, states, sizes
- Accessibility tests passing
- Performance benchmarks passing
- Integration tests passing
- Migration guide written (if replacing an existing API)
- 3 positive reviews including 1 from architecture lead

**Deprecation on removal**: 3 minor versions OR 6 months

**Badge**: None (default level for production APIs)

---

### ⚠️ Deprecated

**Meaning**: API is scheduled for removal. Consumers should migrate.

**Requirements for deprecation**:
- Replacement API exists at Stable level
- Migration guide published
- `@Deprecated('Use X since vY.Z.W')` annotation added
- CHANGELOG entry with deprecation notice
- Mentioned in release notes

**Removal**: Next major version

```dart
@Deprecated(
  'Use [FluxColorTheme] instead. '
  'This class will be removed in v2.0.0.',
)
class FluxThemeData { ... }
```

---

### 🔒 Internal

**Meaning**: Not part of public API. May change without notice.

**Notable patterns that are always Internal**:
- Private types (prefixed with `_`)
- Files in `src/_internal/` or `src/internal/`
- Functions/types marked `@internal`
- Widget state classes (`_FluxButtonState`)
- Internal helper mixins

**No deprecation**: May be removed or changed at any time.

**Documentation**: None required (but `///` comments for maintainers are encouraged).

```dart
@internal
class FluxInternalHelper {
  // No public documentation required
}
```

## Maturity Level Summary

| Level | Stability | Guarantee | Deprecation | Badge |
|-------|-----------|-----------|-------------|-------|
| Experimental | None | Breaks without notice | None | 🧪 |
| Preview | Low | Minor changes only | 1 minor | 🔄 |
| Stable | High | No breaking within major | 3 minors / 6mo | ✅ |
| Deprecated | Removed | Migration provided | Next major | ⚠️ |
| Internal | None | Breaks without notice | None | 🔒 |

## API Promotion Flow

```
Internal ──→ Experimental ──→ Preview ──→ Stable ──→ Deprecated ──→ Removed
    ↑            ↑               ↑              ↑              ↑
  None        1 review      2 weeks        1 minor         next major
              + design      + tests        + goldens       + migration
              + CI          + docs         + a11y tests    + changelog
                             2 reviews      3 reviews
```

## Example Lifecycle

```
v0.5.0: FluxSlider is Internal (in design doc)
v0.6.0: FluxSlider is Experimental (implemented, basic tests)
v0.7.0: FluxSlider is Preview (tested, documented, RTL supported)
v0.8.0: FluxSlider stays Preview (field testing)
v1.0.0: FluxSlider is Stable (promoted at major release)
v1.1.0: FluxSliderRange replaces FluxSlider for range mode
        FluxSlider is Deprecated
v2.0.0: FluxSlider removed, FluxSliderRange is Stable
```

## Tracking

API maturity levels are tracked in:
1. **Source code annotations**: `@Experimental()`, `@Preview()`, `@Deprecated()`
2. **Component documentation**: "Status" section in every `docs/components/*.md`
3. **COMPONENTS.md**: Maturity column in the component tracking table
4. **CHANGELOG.md**: Promotions noted in "Changed" section
