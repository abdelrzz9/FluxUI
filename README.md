<div align="center">

# FluxUI

**A token-driven Flutter UI system — 30+ components, zero hardcoded values.**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.4-0175C2?logo=dart)](https://dart.dev)

</div>

---

> **Status:** Pre-release — packages are not yet published to pub.dev.
> Use a path dependency (local clone) or a git dependency until v1.0.0 is tagged.

---

## What is FluxUI?

FluxUI is a design-token-driven Flutter UI system. Every color, spacing value, typography style, radius, size, and animation duration resolves through strongly typed **design tokens** — there are zero hardcoded values in any component.

It ships with **light and dark** token presets out of the box and is fully customisable via `copyWith`, `overrides`, or `seedColor` for Material You dynamic colour.

---

## Two ways to use it

| Mode | How | Best for |
|------|-----|----------|
| **Package dependency** | Add `fluxui_kit` to your pubspec | Standard Flutter package usage |
| **Local ownership** | `flux add button` copies source into your app | Full customisation (shadcn/ui style) with no package dependency |

---

## Quick start

### Package mode

```yaml
# your_app/pubspec.yaml
dependencies:
  fluxui_kit: ^0.2.0
```

```dart
import 'package:fluxui_kit/fluxui_kit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(
        body: Center(
          child: AppButton(text: 'Get started', onPressed: () {}),
        ),
      ),
    );
  }
}
```

### Local ownership mode

```bash
# 1. Bootstrap once per project
dart run packages/cli/bin/flutter_ui.dart init

# 2. Copy any components you want to own
dart run packages/cli/bin/flux.dart add button card alert
```

Then import your local copy:

```dart
import 'package:your_app/ui/index.dart';
```

---

## Architecture

FluxUI is split into focused, layered packages:

```
┌──────────────────────────────────────┐
│  fluxui_kit                          │
│  Theme API + 30+ components          │
├──────────────────────────────────────┤
│  flutter_ui_utils                    │
│  Widget extensions, responsive       │
├──────────────────────────────────────┤
│  flutter_ui_tokens                   │
│  Immutable, typed design tokens      │
└──────────────────────────────────────┘
```

**Dependency direction** (strict, no cycles):

```
tokens  →  utils  →  fluxui_kit  ←  apps/example
                     cli  (standalone — no Flutter SDK dep)
```

The `flutter_ui` package is a thin re-export of `fluxui_kit` for backward compatibility.

---

## Theme system

### Built-in theme factory

| Method | Description |
|--------|-------------|
| `AppTheme.light()` | Material 3 light theme using `AppDesignTokens.light` |
| `AppTheme.dark()` | Material 3 dark theme using `AppDesignTokens.dark` |
| `AppTheme.custom(tokens, brightness)` | Fully custom theme from any `AppDesignTokens` |

All methods accept optional `fontFamily`, `seedColor`, and `overrides` parameters.

### Custom branding

```dart
final myTheme = AppTheme.custom(
  tokens: AppDesignTokens.light.copyWith(
    colors: AppColorTokens.light.copyWith(primary: const Color(0xFF6366F1)),
  ),
  brightness: Brightness.light,
);
```

### Dynamic colour with `seedColor`

Generate a complete Material You colour scheme from a single seed colour:

```dart
MaterialApp(
  theme: AppTheme.light(seedColor: const Color(0xFF6366F1)),
);
```

When `seedColor` is set, `ColorScheme.fromSeed()` is used instead of the token-based colour mapping.

### Partial overrides with the `overrides` callback

Override specific tokens inline without building a full `AppDesignTokens`:

```dart
MaterialApp(
  theme: AppTheme.light(
    overrides: (tokens) => tokens.copyWith(
      colors: tokens.colors.copyWith(primary: Color(0xFF6366F1)),
      spacing: tokens.spacing.copyWith(md: 20),
    ),
  ),
);
```

### Accessing tokens in widgets

```dart
final colors     = context.appColors;
final spacing    = context.appSpacing;
final radius     = context.appRadius;
final sizes      = context.appSizes;
final motion     = context.appMotion;
final typography = context.appTypography;
```

---

## Components (30+)

| Category | Components |
|----------|------------|
| **Buttons** | `AppButton` — 4 variants (primary · secondary · outline · ghost) · 3 sizes · loading state |
| **Cards** | `AppCard` — surface · outlined · muted |
| **Display** | `AppAvatar` · `AppBadge` · `AppCarousel` |
| **Feedback** | `AppAlert` · `AppBottomSheet` · `AppDialog` · `AppProgress` · `AppSkeleton` · `AppToast` |
| **Inputs** | `AppCombobox` · `AppOtpField` · `AppSearchBar` · `AppSlider` · `AppTextField` |
| **Layouts** | `Gap` · `HStack` · `VStack` |
| **Navigation** | `AppAppBar` · `AppBottomNav` · `AppNavigationMenu` · `AppPagination` · `AppTabs` |
| **Roadmap** | `AppRoadmapItem` |
| **Selection** | `AppCheckbox` · `AppChip` · `AppRadio` · `AppSwitch` |
| **Typography** | `AppText` — 15 type-scale variants · 7 semantic tones |

---

## Packages

### `packages/tokens` — `flutter_ui_tokens` (v0.1.0)

Immutable, strongly typed design tokens with full `lerp` support for smooth theme animations.

| Token class | Covers |
|-------------|--------|
| `AppColorTokens` | Primary, secondary, surface, status, border, overlay, shadow |
| `AppSpacingTokens` | Scale `none` (0) → `x5l` (64 dp) |
| `AppRadiusTokens` | Corner radius scale `none` → `pill` |
| `AppSizeTokens` | Icon sizes (12–32 dp), control heights (32–60 dp), container widths |
| `AppMotionTokens` | Durations: `instant` · `fast` · `moderate` · `slow` · `emphasized` |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles) |
| `AppDesignTokens` | Aggregate — `.light` and `.dark` static constants |

### `packages/utils` — `flutter_ui_utils` (v0.1.0)

`BuildContext` extensions · widget fluent API · numeric helpers · `AppBreakpoints` · `AppResponsiveValue<T>`

### `packages/fluxui` — `fluxui_kit` (v0.2.0)

The primary consumer-facing package. Re-exports tokens and utils, provides the full component set with theme integration (`AppTheme`, 30+ widgets, `BuildContext` token extensions).

### `packages/ui` — `flutter_ui` (v0.1.0)

Thin compatibility re-export of `fluxui_kit` for projects using the legacy `flutter_ui` import. No additional logic.

### `packages/cli` — `flutter_ui_cli` (v0.1.0)

Pure Dart CLI (no Flutter SDK dependency) for copying components into your project. `publish_to: none`.

| Binary | Commands |
|--------|----------|
| `flux` | `add` |
| `flutter_ui` | `init` · `add` · `list` |

See [docs/cli.md](docs/cli.md) for the full command reference.

---

## Monorepo structure

```
FluxUI/
├── apps/
│   └── example/          # showcase app
├── docs/
│   ├── cli.md            # CLI reference
│   ├── publishing.md
│   ├── dev_branch_workflow.md
│   ├── production_readiness_roadmap.md
│   └── issues/           # Issue templates
├── packages/
│   ├── tokens/           # flutter_ui_tokens
│   ├── utils/            # flutter_ui_utils
│   ├── ui/               # flutter_ui (re-exports fluxui_kit)
│   ├── fluxui/           # fluxui_kit (primary package)
│   └── cli/              # flutter_ui_cli
├── tools/
│   └── check_architecture.dart
└── melos.yaml
```

---

## Requirements

| | Version |
|--|---------|
| Dart SDK | `>=3.4.0 <4.0.0` |
| Flutter | `>=3.24.0` |

---

## Local setup

```bash
dart pub get
dart run melos bootstrap

# Run the example app
cd apps/example && flutter run
```

---

## Validation

Run before every PR:

```bash
dart run melos run check:architecture
dart run melos run format:check
dart run melos run analyze          # Flutter analyze (skips CLI)
dart run melos run analyze:cli      # Dart analyze (CLI only)
dart run melos run test
dart run melos run test:goldens
dart run melos run build            # Builds CLI executable
```

---

## Branch strategy

| Branch | Role |
|--------|------|
| `main` | Stable — tagged releases only |
| `dev` | Integration — all PRs target this branch |
| `feature/*` | Short-lived — branch from `dev` |

See [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md).

---

## Documentation

| | |
|-|-|
| [docs/cli.md](docs/cli.md) | Full CLI reference |
| [docs/publishing.md](docs/publishing.md) | Release checklist |
| [docs/production_readiness_roadmap.md](docs/production_readiness_roadmap.md) | Production-readiness roadmap |
| [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md) | Branch strategy |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute |
| [packages/tokens/README.md](packages/tokens/README.md) | Tokens package |
| [packages/utils/README.md](packages/utils/README.md) | Utils package |
| [packages/fluxui/README.md](packages/fluxui/README.md) | FluxUI Kit package |
| [packages/cli/README.md](packages/cli/README.md) | CLI package |

---

## License

MIT — see [LICENSE](LICENSE).
