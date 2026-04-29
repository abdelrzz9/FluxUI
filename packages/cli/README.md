# flutter_ui_cli

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-blue)](https://flutter.dev)

shadcn-style CLI for copying editable FluxUI components into your Flutter app. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) ecosystem.

> **Note:** This package is `publish_to: none`. Run it directly from the monorepo with `dart run`.

## How it works

Components are copied as plain `.dart` files into your project — you own the code. There is no runtime dependency on this CLI after the copy step.

Two entry points are provided:

| Binary | Purpose |
|---|---|
| `flux` | Day-to-day `add` command |
| `flutter_ui` | Workspace initialisation (`init`, `add`, `list`) |

## Getting started

**1. Initialise the workspace** (once per project):

```FluxUI/packages/cli/lib/src/flutter_ui_cli.dart#L1-3
dart run packages/cli/bin/flutter_ui.dart init
```

This creates `lib/ui/components/`, `lib/ui/core/`, and `lib/ui/index.dart` in your project, along with a `flutter_ui.json` config file.

**2. Copy components:**

```FluxUI/packages/cli/bin/flux.dart#L1-3
# preferred shorthand
dart run packages/cli/bin/flux.dart add button

# multiple at once
dart run packages/cli/bin/flux.dart add button card text-field
```

Files land in `lib/ui/components/` and are immediately editable.

## Commands

### `flutter_ui init`

Bootstraps the workspace scaffold. Safe to re-run; use `--force` to overwrite existing files.

```FluxUI/packages/cli/lib/src/flutter_ui_cli.dart#L1-3
dart run packages/cli/bin/flutter_ui.dart init
dart run packages/cli/bin/flutter_ui.dart init --force
```

### `flux add <components...>`

Copies one or more components (and their dependencies) into your project.

```FluxUI/packages/cli/bin/flux.dart#L1-3
dart run packages/cli/bin/flux.dart add button card
dart run packages/cli/bin/flux.dart add button --overwrite
```

### `flutter_ui list`

Prints all available components.

```FluxUI/packages/cli/lib/src/flutter_ui_cli.dart#L1-3
dart run packages/cli/bin/flutter_ui.dart list
```

## Available components

| ID | Aliases | Description |
|---|---|---|
| `button` | `app_button` | Primary action button with variants, sizes, and loading state |
| `card` | `app_card` | Surface container with outline and muted variants |
| `gap` | — | Axis-aware spacer primitive |
| `h-stack` | `hstack` | Horizontal stack that inserts gaps between children |
| `text` | `app_text`, `typography` | Token-driven text widget with semantic tone and type scale |
| `text-field` | `textfield`, `input`, `app_text_field` | Form field with outline and filled variants |
| `v-stack` | `vstack` | Vertical stack that inserts gaps between children |

> More components are registered in the registry as the ecosystem grows. Run `flutter_ui list` to see the latest.

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [Issue tracker](https://github.com/abdelrzz9/FluxUI/issues)
- [`flutter_ui` — UI component library](https://pub.dev/packages/flutter_ui)
- [`flutter_ui_tokens` — design tokens](https://pub.dev/packages/flutter_ui_tokens)
