# FluxUI

FluxUI is a Flutter UI monorepo for building and distributing a token-driven
design system with two consumption models:

- reusable Dart/Flutter packages
- a local ownership CLI that copies editable components into app codebases

The repository currently contains typed design tokens, shared utilities, a UI
package, a CLI package, an example app, and CI/release workflows for a
production-oriented `dev` branch workflow.

## Current Repository Structure

```text
.
├── apps/
│   └── example/
├── docs/
│   ├── cli.md
│   ├── dev_branch_workflow.md
│   ├── github_issues_roadmap.md
│   └── publishing.md
├── packages/
│   ├── cli/
│   ├── tokens/
│   ├── ui/
│   │   └── content/docs/
│   └── utils/
├── tools/
│   └── check_architecture.dart
├── melos.yaml
└── README.md
```

## Packages

### `packages/tokens`

`flutter_ui_tokens` contains the typed token layer:

- color tokens
- spacing tokens
- radius tokens
- size tokens
- motion tokens
- typography tokens
- aggregated design tokens

### `packages/utils`

`flutter_ui_utils` contains shared Flutter helpers:

- widget extensions
- numeric spacing helpers
- context extensions
- responsive breakpoints and responsive values

### `packages/ui`

`flutter_ui` is the main UI package. It exports:

- theme APIs: `AppTheme`, `AppThemeTokens`
- core widgets: `AppText`
- extensions from `flutter_ui_utils`
- tokens from `flutter_ui_tokens`
- UI components across:
  - buttons
  - cards
  - display
  - feedback
  - inputs
  - layouts
  - navigation
  - roadmap
  - selection

Concrete widgets in the package currently include:

- `AppButton`
- `AppCard`
- `AppCarousel`
- `AppAlert`
- `AppProgress`
- `AppTextField`
- `AppCombobox`
- `AppOtpField`
- `Gap`
- `HStack`
- `VStack`
- `AppNavigationMenu`
- `AppPagination`
- `AppTabs`
- `AppRoadmapItem`
- `AppCheckbox`
- `AppSwitch`

### `packages/cli`

`flutter_ui_cli` provides two executable entry points:

- `flux`: preferred component install flow
- `flutter_ui`: workspace initialization, compatibility commands, and listing

The CLI package is present in the repo and built in CI, but `packages/cli`
currently has `publish_to: none`, so treat it as repository-managed tooling
until that changes.

### `apps/example`

`flutter_ui_example` is the local showcase app for package validation and manual
UI review.

## CLI Status

FluxUI currently supports two real workflows.

### Preferred add flow

Use `flux add` to copy editable components into a Flutter app:

```bash
dart run packages/cli/bin/flux.dart add button
dart run packages/cli/bin/flux.dart add button card
```

Current registry entries are:

- `button`
- `card`
- `text`
- `text-field`
- `gap`
- `h-stack`
- `v-stack`

`flux add` resolves aliases, installs dependencies such as `gap` for stack
layouts, writes component files into the target app, and refreshes generated
bridge/index files.

### Workspace bootstrap flow

Use `flutter_ui` when you want the local workspace scaffold:

```bash
dart run packages/cli/bin/flutter_ui.dart init
dart run packages/cli/bin/flutter_ui.dart list
dart run packages/cli/bin/flutter_ui.dart add button text-field h-stack
```

`flutter_ui init` creates:

- `flutter_ui.json`
- `lib/ui/core/flutter_ui.dart`
- `lib/ui/components/index.dart`
- `lib/ui/index.dart`

After initialization, app code should import its local workspace export:

```dart
import 'package:your_app/ui/index.dart';
```

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`
- Flutter `>=3.24.0`

CI is currently pinned to Flutter stable `3.41.5` in
[`./.github/workflows/ci.yml`](.github/workflows/ci.yml).

## Local Setup

Install workspace dependencies:

```bash
dart pub get
dart run melos bootstrap
```

Run the example app:

```bash
cd apps/example
flutter run
```

## Validation Commands

Run the full workspace checks before opening or merging a PR:

```bash
dart run melos run check:architecture
dart run melos run format:check
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run test:goldens
dart run melos run build
```

Notes:

- `check:architecture` verifies required monorepo paths exist.
- `test:goldens` only targets the `flutter_ui` package.
- `build` currently builds the `flux` CLI executable from `packages/cli/tool/build.dart`.

## CI and Release Gates

The repository includes:

- [CI workflow](.github/workflows/ci.yml)
- [Publish dry-run workflow](.github/workflows/publish_dry_run.yml)

Current CI behavior:

- runs on every pull request
- runs on pushes to `main` and `master`
- splits checks into `format`, `lint`, `analyze`, `test`, and `build`

Dry-run publishing is manual through `workflow_dispatch` and runs:

```bash
dart run melos run publish:dry-run:flutter
dart run melos run publish:dry-run:cli
```

## `dev` Branch Workflow

This repo is set up to use `dev` as the integration branch for production-ready
work.

- `main`: stable branch for releasable code
- `dev`: active integration branch
- `feature/*`: short-lived branches created from `dev`

Recommended flow:

1. Branch from `dev`.
2. Make focused changes.
3. Run the validation commands locally.
4. Open a PR into `dev`.
5. Merge to `dev` only after the PR checks pass.
6. Promote `dev` to `main` through a stabilization PR when the branch is ready
   to release.

Important nuance: the current GitHub Actions workflow validates all pull
requests, but direct push CI is configured for `main` and `master`, not `dev`.
For real production discipline on `dev`, use PR-based validation and avoid
direct pushes.

## Documentation

- [CLI guide](packages/ui/content/docs/cli.md)
- [Publishing guide](packages/ui/content/docs/publishing.md)
- [Introduction](packages/ui/content/docs/introduction.mdx)
- [Architecture migration notes](packages/ui/content/docs/architecture_migration.md)
- [GitHub issues roadmap](packages/ui/content/docs/github_issues_roadmap.md)
- [Dev branch workflow](docs/dev_branch_workflow.md)
- [Contributing guide](CONTRIBUTING.md)

## Repository

- GitHub: `https://github.com/abdelrzz9/FluxUI`

## License

MIT. See [LICENSE](LICENSE).
