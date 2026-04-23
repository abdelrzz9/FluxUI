# FluxUI

FluxUI is a Flutter UI monorepo built around two workflows:

- reusable packages for tokens, theme, and components
- a shadcn-style copy-paste CLI for local ownership inside app codebases

The repository contains typed design tokens, a theme layer built on
`ThemeExtension`, composable widgets, fluent extensions, a CLI, and an example
app.

## Philosophy

- Design tokens are the source of truth.
- Components stay stateless and composable where possible.
- Styling comes from theme tokens, not local hardcoded values.
- Package consumption and copy-paste ownership are both first-class.
- Generated code stays readable enough to customize in product apps.

## Monorepo Structure

```text
root/
├── apps/
│   └── example/
├── packages/
│   ├── cli/
│   ├── tokens/
│   ├── ui/
│   │   └── content/docs/
│   └── utils/
├── docs/ (compatibility pointers)
├── melos.yaml
└── README.md
```

## Packages

### `packages/tokens`

Typed immutable design tokens for spacing, radius, sizes, motion, semantic
colors, and typography.

### `packages/utils`

Shared utilities for fluent widget composition, context helpers, and responsive
value resolution.

### `packages/ui`

The main UI package that ships:

- `AppTheme`
- `AppText`
- `AppButton`
- `AppCard`
- `AppTextField`
- `Gap`
- `HStack`
- `VStack`

### `packages/cli`

The CLI layer for copy-paste ownership.

Current state:

- `flux add ...` is the preferred component install command
- `flutter_ui init`, `flutter_ui list`, and `flutter_ui add ...` still exist for
  local workspace bootstrapping and compatibility

### `apps/example`

A live showcase app used for visual review, API validation, and regression
coverage.

## Current Capabilities

- strongly typed token system with light and dark defaults
- token-backed theme layer using `ThemeData` and `ThemeExtension`
- fluent APIs such as `Text("Hello").padding(16).center()`
- responsive helpers and breakpoint-aware value selection
- reusable stateless primitives for text, buttons, cards, inputs, and layout
- file-backed CLI templates, starting with the button component
- widget tests and golden tests for the UI package
- split CI jobs for format, lint, Dart analysis, tests, and build

## Workspace Setup

```bash
dart pub get
dart run melos bootstrap
```

## Validate the Repo

```bash
dart run melos run format:check
dart run melos run check:architecture
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run test:goldens
dart run melos run build
```

`build` currently compiles the `flux` CLI executable.

## Run the Example App

```bash
cd apps/example
flutter run
```

## CLI Workflow

Initialize a local UI workspace inside a Flutter app:

```bash
dart run packages/cli/bin/flutter_ui.dart init
```

List available registered components:

```bash
dart run packages/cli/bin/flutter_ui.dart list
```

Add components with the newer Flux-style command:

```bash
dart run packages/cli/bin/flux.dart add button
```

The legacy add command is still available:

```bash
dart run packages/cli/bin/flutter_ui.dart add button text-field h-stack
```

See [docs/cli.md](docs/cli.md) for the full CLI guide.

## Documentation

- [CLI guide](packages/ui/content/docs/cli.md)
- [Publishing guide](packages/ui/content/docs/publishing.md)
- [GitHub issues roadmap](packages/ui/content/docs/github_issues_roadmap.md)
- [Dev branch workflow](docs/dev_branch_workflow.md)
- [Contributing guide](CONTRIBUTING.md)

## Quality and Release

FluxUI includes:

- Melos workspace scripts
- split GitHub Actions CI jobs for `format`, `lint`, `analyze`, `test`, and
  `build`
- a publish dry-run workflow
- widget and golden test coverage in the UI package

## Repository

GitHub: `https://github.com/abdelrzz9/FluxUI`

## License

FluxUI is released under the MIT License. See [LICENSE](LICENSE).
