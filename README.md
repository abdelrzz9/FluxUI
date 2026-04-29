# FluxUI

A token-driven Flutter UI system delivered as a Melos monorepo.

Two consumption models:
- **Package** — add `flutter_ui` to your `pubspec.yaml` and use widgets directly.
- **Local ownership** — use the `flux` CLI to copy editable component files into your app (shadcn/ui style).

---

## Repository structure

```
FluxUI/
├── apps/
│   └── example/          # showcase app (manual review + golden tests)
├── docs/
│   ├── cli.md            # CLI command reference
│   ├── dev_branch_workflow.md
│   ├── publishing.md
│   └── roadmap.md
├── packages/
│   ├── tokens/           # flutter_ui_tokens — typed design tokens
│   ├── utils/            # flutter_ui_utils  — extensions & helpers
│   ├── ui/               # flutter_ui        — theme + 18 widgets
│   └── cli/              # flutter_ui_cli    — component copy tool
├── tools/
│   └── check_architecture.dart
└── melos.yaml
```

Dependency direction (strict):

```
tokens  ──►  utils  ──►  ui  ◄──  apps/example
                              cli  (standalone, no Flutter dep)
```

---

## Packages

### `packages/tokens` — `flutter_ui_tokens`

Immutable, strongly typed design tokens with `lerp` support.

| Token class | Covers |
|-------------|--------|
| `AppColorTokens` | Primary, secondary, surface, status, border |
| `AppSpacingTokens` | Scale `xxxs` → `x5l` |
| `AppRadiusTokens` | Corner radius scale |
| `AppSizeTokens` | Icon and control heights |
| `AppMotionTokens` | Animation durations |
| `AppTypographyTokens` | Full Material 3 text scale |
| `AppDesignTokens` | Aggregate with `.light` and `.dark` constants |

### `packages/utils` — `flutter_ui_utils`

Shared Flutter helpers: `BuildContext` extensions, widget fluent API, numeric shorthands, `AppBreakpoints`, `AppResponsiveValue<T>`.

### `packages/ui` — `flutter_ui`

Theme integration and 18 production-ready widgets:

| Category | Widgets |
|----------|---------|
| Buttons | `AppButton` (4 variants · 3 sizes · loading) |
| Cards | `AppCard` (surface · outline · muted) |
| Display | `AppCarousel` |
| Feedback | `AppAlert` · `AppProgress` |
| Inputs | `AppTextField` · `AppCombobox` · `AppOtpField` |
| Layouts | `Gap` · `HStack` · `VStack` |
| Navigation | `AppNavigationMenu` · `AppPagination` · `AppTabs` |
| Roadmap | `AppRoadmapItem` |
| Selection | `AppCheckbox` · `AppSwitch` |
| Typography | `AppText` |

Theme API: `AppTheme.light()` / `AppTheme.dark()` / `AppTheme.custom(tokens, brightness)`.

### `packages/cli` — `flutter_ui_cli`

Two entry points:

| Binary | Commands |
|--------|---------|
| `flux` | `add` |
| `flutter_ui` | `init` · `add` · `list` |

`publish_to: none` — run directly from the monorepo. See [docs/cli.md](docs/cli.md).

---

## Requirements

| Requirement | Version |
|-------------|---------|
| Dart SDK | `>=3.4.0 <4.0.0` |
| Flutter | `>=3.24.0` |

CI pins Flutter stable `3.41.5`.

---

## Local setup

```bash
# 1. Install workspace dependencies
dart pub get
dart run melos bootstrap

# 2. Run the example app
cd apps/example && flutter run
```

---

## Validation

Run before opening or merging any PR:

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

## Branch workflow

| Branch | Role |
|--------|------|
| `main` | Stable · tagged releases |
| `dev` | Integration · all PRs merge here |
| `feature/*` | Short-lived · branch from `dev` |

See [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md).

---

## Documentation

| File | Contents |
|------|----------|
| [docs/cli.md](docs/cli.md) | Full CLI command reference |
| [docs/publishing.md](docs/publishing.md) | Release checklist |
| [docs/roadmap.md](docs/roadmap.md) | GitHub issues roadmap |
| [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md) | Branch strategy |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guide |
| [packages/tokens/README.md](packages/tokens/README.md) | Tokens package |
| [packages/utils/README.md](packages/utils/README.md) | Utils package |
| [packages/ui/README.md](packages/ui/README.md) | UI package |
| [packages/cli/README.md](packages/cli/README.md) | CLI package |

---

## License

MIT — see [LICENSE](LICENSE).
