<div align="center">

# FluxUI

**A token-driven Flutter UI system — 30 components, zero hardcoded values.**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.4-0175C2?logo=dart)](https://dart.dev)

</div>

---

> **Status:** Pre-release — packages are not yet published to pub.dev.
> Use a path dependency (local clone) or a git dependency until v1.0.0 is tagged.

---

## Two ways to use it

| Mode | How | Best for |
|------|-----|----------|
| **Path / Git dependency** | Point pubspec at this repo | Standard Flutter package usage |
| **Local ownership** | `flux add button` copies source into your app | Full customisation (shadcn/ui style) |

---

## Quick start

### Path dependency (local clone)

```bash
git clone https://github.com/abdelrzz9/FluxUI.git
```

```yaml
# your_app/pubspec.yaml
dependencies:
  flutter_ui:
    path: ../FluxUI/packages/ui
```

### Git dependency (no local clone needed)

```yaml
# your_app/pubspec.yaml
dependencies:
  flutter_ui:
    git:
      url: https://github.com/abdelrzz9/FluxUI.git
      path: packages/ui
      ref: main   # or pin to a specific commit SHA
```

```dart
import 'package:flutter_ui/index.dart';

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

> Once the packages are published to pub.dev, the dependency will simply be:
> ```yaml
> dependencies:
>   flutter_ui: ^0.1.0
> ```

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

## Components (30)

| Category | Components |
|----------|-----------|
| **Buttons** | `AppButton` — 4 variants · 3 sizes · loading state |
| **Cards** | `AppCard` — surface · outline · muted |
| **Display** | `AppCarousel` · `AppAvatar` · `AppBadge` |
| **Feedback** | `AppAlert` · `AppProgress` · `AppDialog` · `AppBottomSheet` · `AppToast` · `AppSkeleton` |
| **Inputs** | `AppTextField` · `AppCombobox` · `AppOtpField` · `AppSearchBar` · `AppSlider` |
| **Layouts** | `Gap` · `HStack` · `VStack` |
| **Navigation** | `AppNavigationMenu` · `AppPagination` · `AppTabs` · `AppBottomNav` · `AppAppBar` |
| **Roadmap** | `AppRoadmapItem` |
| **Selection** | `AppCheckbox` · `AppSwitch` · `AppChip` · `AppRadio` |
| **Typography** | `AppText` |

---

## Packages

### `packages/tokens` — `flutter_ui_tokens`

Immutable, strongly typed design tokens with full `lerp` support.

| Token class | Covers |
|-------------|--------|
| `AppColorTokens` | Primary, secondary, surface, status, border roles |
| `AppSpacingTokens` | Scale `none` (0) → `x5l` (64 dp) |
| `AppRadiusTokens` | Corner radius scale |
| `AppSizeTokens` | Icon sizes (`12–32`) and control heights (`32–60`) |
| `AppMotionTokens` | Animation durations |
| `AppTypographyTokens` | Full Material 3 text scale (15 styles) |
| `AppDesignTokens` | Aggregate — `.light` and `.dark` static constants |

### `packages/utils` — `flutter_ui_utils`

`BuildContext` extensions · widget fluent API · numeric helpers · `AppBreakpoints` · `AppResponsiveValue<T>`

### `packages/ui` — `flutter_ui`

Theme API: `AppTheme.light()` / `AppTheme.dark()` / `AppTheme.custom(tokens, brightness)`

Custom branding:

```dart
final myTokens = AppDesignTokens.light.copyWith(
  colors: AppColorTokens.light.copyWith(primary: const Color(0xFF6366F1)),
);

MaterialApp(
  theme: AppTheme.custom(tokens: myTokens, brightness: Brightness.light),
);
```

### `packages/cli` — `flutter_ui_cli`

| Binary | Commands |
|--------|----------|
| `flux` | `add` |
| `flutter_ui` | `init` · `add` · `list` |

`publish_to: none` — see [docs/cli.md](docs/cli.md) for the full command reference.

---

## Monorepo structure

```
FluxUI/
├── apps/
│   └── example/          # showcase app — manual review + golden tests
├── docs/
│   ├── cli.md            # CLI reference
│   ├── dev_branch_workflow.md
│   ├── publishing.md
│   └── roadmap.md
├── packages/
│   ├── tokens/           # flutter_ui_tokens
│   ├── utils/            # flutter_ui_utils
│   ├── ui/               # flutter_ui
│   └── cli/              # flutter_ui_cli
├── tools/
│   └── check_architecture.dart
└── melos.yaml
```

Dependency direction (strict, no cycles):

```
tokens  ──►  utils  ──►  ui  ◄──  apps/example
                         cli  (standalone — no Flutter SDK dep)
```

---

## Requirements

| | Version |
|--|---------|
| Dart SDK | `>=3.4.0 <4.0.0` |
| Flutter | `>=3.24.0` |

CI pins Flutter stable `3.41.5`.

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
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run test:goldens
dart run melos run build
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
| [docs/cli.md](docs/cli.md) | Full CLI reference (18 installable components) |
| [docs/publishing.md](docs/publishing.md) | Release checklist |
| [docs/roadmap.md](docs/roadmap.md) | Issues roadmap |
| [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md) | Branch strategy |
| [CONTRIBUTING.md](CONTRIBUTING.md) | How to contribute |
| [packages/tokens/README.md](packages/tokens/README.md) | Tokens package |
| [packages/utils/README.md](packages/utils/README.md) | Utils package |
| [packages/ui/README.md](packages/ui/README.md) | UI package |
| [packages/cli/README.md](packages/cli/README.md) | CLI package |

---

## License

MIT — see [LICENSE](LICENSE).
