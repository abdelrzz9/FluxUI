# Flux UI — Versioning & API Stability

## Semantic Versioning

Flux UI follows [Semantic Versioning 2.0.0](https://semver.org/):

**MAJOR.MINOR.PATCH** (e.g., `1.4.2`)

| Version | Change | Example |
|---------|--------|---------|
| MAJOR | Breaking API change | v1.0.0 → v2.0.0 |
| MINOR | New feature (backwards-compatible) | v1.0.0 → v1.1.0 |
| PATCH | Bug fix (backwards-compatible) | v1.0.0 → v1.0.1 |

### What Constitutes a Breaking Change

- Renaming or removing a public class, method, or parameter
- Changing a parameter type or nullability
- Changing the default value of a parameter
- Changing the behavior of a public API in a way that breaks existing usage
- Removing a `ThemeExtension` or its properties
- Changing the type of a theme extension property
- Changing the return type of a public method
- Adding a `required` parameter (if it breaks existing code)
- Changing `const` constructors to non-`const`

### What Does NOT Constitute a Breaking Change

- Adding a new public class, method, or parameter (with default)
- Adding a new `ThemeExtension` (consumers don't register it by default)
- Deprecating an API (with migration warning)
- Changing internal/private implementation
- Bug fixes that change behavior to match documented expectations
- Performance improvements with no API change

## API Stability Levels

| Level | Badge | Description | Deprecation | Examples |
|-------|-------|-------------|-------------|----------|
| **Experimental** | 🧪 | API may change without notice. Not for production use. | None | New component in early design phase |
| **Preview** | 🔄 | API is stable but may receive minor changes before stabilization. | 1 minor version notice | Components in Phase 2-6 |
| **Stable** | ✅ | API is committed. Will not break within the same major version. | 3 minor versions or 6 months | v1.0.0 components |
| **Deprecated** | ⚠️ | API is scheduled for removal. Migration guide provided. | N/A (removed next major) | Old API replaced by new |
| **Internal** | 🔒 | Not part of public API. May change without notice. | None | Private helpers, internal state classes |

### Promotion Rules

| From | To | Requirements |
|------|----|-------------|
| Internal | Experimental | Design document, 1 positive review |
| Experimental | Preview | 2 weeks of field testing, unit+widget tests, documentation |
| Preview | Stable | 1 minor version as preview, golden tests, a11y tests, 3 positive reviews |
| Stable | Deprecated | Replacement API exists at Stable level, migration guide published |
| Deprecated | Removed | Next major version |

## Deprecation Timeline

```
v1.0.0: FluxButton is Stable
v1.1.0: FluxButtonVariant.newVariant added (Preview)
         FluxButton.oldMethod marked @Deprecated('Use newMethod since v1.1.0')
v1.2.0: FluxButtonVariant.newVariant promoted to Stable
         FluxButton.oldMethod still deprecated, not removed
v2.0.0: FluxButton.oldMethod removed
         FluxButtonVariant.newVariant remains Stable
```

**Minimum timeline**: 3 minor versions OR 6 months from deprecation to removal.

## Release Cadence

| Release | Frequency | Contents |
|---------|-----------|----------|
| Patch | As needed (typically weekly) | Bug fixes, documentation improvements |
| Minor | Monthly | New components, features, preview promotions |
| Major | Quarterly or yearly | Breaking changes, API stabilization |

### Release Cycle

```
Week 1: Release v1.1.0-beta.1 (preview)
Week 2: Bug fixes, community testing
Week 3: Release v1.1.0-rc.1 (candidate)
Week 4: Release v1.1.0 (stable)
```

## LTS (Long-Term Support)

- Every MAJOR version receives bug fixes for 12 months after the next MAJOR release
- Security patches for 18 months
- Only the latest MAJOR version receives new features

| Version | Released | Bug Fixes Until | Security Until |
|---------|----------|----------------|----------------|
| v1.x | Jan 2026 | Jan 2027 | Jul 2027 |
| v2.x | Jan 2027 | Jan 2028 | Jul 2028 |

## Migration Policy

### Per-Major Migration

Every MAJOR release must include:

1. **Migration Guide**: `docs/migration/v1_to_v2.md`
2. **Codemod**: Dart script to automate migration (where feasible)
3. **Changelog**: Detailed breaking change list
4. **Deprecation Warnings**: All removed APIs were deprecated for ≥3 minor versions
5. **Upgrade Testing**: Test suite verifies old patterns still compile with deprecation warnings

### Migration Example

```dart
// v1.x — works but shows deprecation warning
FluxThemeData(primary: ...) // @Deprecated('Use FluxColorTheme instead')

// v2.0 — compile error
FluxThemeData(primary: ...) // undefined

// v2.0 — correct
FluxColorTheme(primary: ...)
```

## Version Files

Version is managed in these locations:

- `packages/flux_ui/pubspec.yaml` — `version:` field
- `packages/flux_tokens/pubspec.yaml`
- `packages/flux_theme/pubspec.yaml`
- ... (all packages)
- `melos.yaml` — `version:` for coordinated releases

All packages in the monorepo share the same version number for coordinated releases. Individual packages may deviate if they have independent release cycles.

## Pre-release Identifiers

| Suffix | Meaning | Example |
|--------|---------|---------|
| `-alpha.1` | Experimental, unstable | `1.1.0-alpha.1` |
| `-beta.1` | Feature-complete, testing | `1.1.0-beta.1` |
| `-rc.1` | Release candidate, final testing | `1.1.0-rc.1` |
| (none) | Stable release | `1.1.0` |

## Changelog Format

Follows [Keep a Changelog](https://keepachangelog.com/) with these sections:

```
# Changelog

## [1.1.0] - 2026-06-15

### Added
- FluxSlider component with range support (#42)
- FluxColorTheme.lerp() for smooth theme transitions (#38)

### Changed
- FluxButton loading parameter type from bool to Widget? (#45)
- Minimum Flutter version from 3.22 to 3.24

### Deprecated
- FluxThemeData — use FluxColorTheme, FluxButtonTheme, etc. (#30)

### Removed
- FluxButton.copyWith — use styleFrom() instead (#29)

### Fixed
- FluxCheckbox indeterminate state visual (#33)
- RTL layout in FluxAccordion (#37)

### Security
- None

## [1.0.0] - 2026-05-01
```
