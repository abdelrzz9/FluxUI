# FluxUI

FluxUI is a production-grade Flutter UI ecosystem for teams that want both:

- a reusable package-based design system
- a shadcn-style copy-paste workflow for local ownership

It is built as a monorepo with strongly typed tokens, theme extensions,
composable widgets, developer-friendly extensions, a local component generator,
and an example app that acts as a living showcase.

## Philosophy

- Design tokens are the source of truth.
- UI components stay stateless and composable where possible.
- Styling comes from the theme system, not local hardcoded values.
- Package usage and copy-paste ownership both remain first-class workflows.
- The code should stay readable enough to customize inside product apps.

## Monorepo Structure

```text
root/
├── apps/
│   └── example/
├── docs/
├── packages/
│   ├── tokens/
│   ├── ui/
│   └── utils/
├── tools/
│   └── cli/
├── melos.yaml
└── README.md
```

## Packages

### `packages/tokens`

Immutable design tokens for:

- spacing
- radius
- sizes
- motion
- semantic colors
- typography

### `packages/utils`

Shared helpers and extensions for:

- fluent widget composition
- responsive helpers
- context utilities

### `packages/ui`

The main UI system package that includes:

- `ThemeData` factories backed by `ThemeExtension`
- `AppText`
- `AppButton`
- `AppCard`
- `AppTextField`
- `Gap`
- `HStack`
- `VStack`

### `tools/cli`

A developer-first CLI for:

- initializing a local UI workspace in a Flutter app
- copying editable component files into the consuming app
- keeping generated local components compatible with package exports

### `apps/example`

A live showcase app used for:

- visual review
- public API validation
- regression coverage

## Current Capabilities

- typed design token system with light and dark defaults
- token-backed theme layer using `ThemeExtension`
- fluent APIs such as `Text("Hello").padding(16).center()`
- responsive helpers and breakpoint-based value resolution
- component variants and sizing for buttons and text fields
- stateless reusable primitives for layout and content
- local code generation through `flutter_ui init` and `flutter_ui add ...`
- widget tests and golden tests for the UI package

## Quick Start

### Bootstrap the workspace

```bash
dart pub global activate melos
melos bootstrap
```

### Validate the repo

```bash
melos run format:check
melos run analyze
melos run test
melos run test:goldens
```

### Run the example app

```bash
cd apps/example
flutter run
```

## CLI Workflow

Initialize a local workspace inside a Flutter app:

```bash
dart run tools/cli/bin/flutter_ui.dart init
```

List available components:

```bash
dart run tools/cli/bin/flutter_ui.dart list
```

Copy local editable components into the app:

```bash
dart run tools/cli/bin/flutter_ui.dart add button text-field h-stack
```

See the full guide in [docs/cli.md](docs/cli.md).

## Documentation

- [CLI guide](docs/cli.md)
- [Publishing guide](docs/publishing.md)
- [GitHub issues roadmap](docs/github_issues_roadmap.md)
- [Contributing guide](CONTRIBUTING.md)

## Quality and Release

FluxUI includes:

- Melos workspace scripts
- CI workflow for formatting, analysis, and tests
- publish dry-run workflow
- widget test coverage
- golden baselines for the UI package

## Repository

GitHub: `https://github.com/abdelrzz9/FluxUI`

## License

FluxUI is released under the MIT License. See [LICENSE](LICENSE).

