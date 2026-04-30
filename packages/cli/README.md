# flutter_ui_cli

shadcn-style CLI for copying editable FluxUI components into your Flutter project. Part of the [FluxUI](https://github.com/abdelrzz9/FluxUI) monorepo.

> **Note:** `publish_to: none` — run directly from the monorepo with `dart run`.

## How it works

Components are copied as plain `.dart` files into your project under `lib/ui/components/`. You own the code. There is no runtime dependency on this package after the copy.

## Entry points

| Binary | Commands |
|--------|---------|
| `flux` | `add` |
| `flutter_ui` | `init` · `add` · `list` |

## Getting started

```bash
# 1. Initialise the workspace (once per project)
dart run packages/cli/bin/flutter_ui.dart init

# 2. Copy components
dart run packages/cli/bin/flux.dart add button
dart run packages/cli/bin/flux.dart add button card alert
```

Import the local workspace surface in your app:

```dart
import 'package:your_app/ui/index.dart';
```

## Commands

### `flutter_ui init`

Creates the workspace scaffold in your Flutter project.

```bash
dart run packages/cli/bin/flutter_ui.dart init
dart run packages/cli/bin/flutter_ui.dart init --force   # overwrite existing files
```

Generates:
- `flutter_ui.json` — config
- `lib/ui/core/flutter_ui.dart` — bridge (hides package symbols for copied components)
- `lib/ui/components/index.dart` — local components barrel
- `lib/ui/index.dart` — unified export

### `flux add`

```bash
dart run packages/cli/bin/flux.dart add <component> [<component>...] [--overwrite]
```

Features: alias resolution, fuzzy typo correction (Levenshtein ≤ 2), automatic dependency installation.

### `flutter_ui list`

```bash
dart run packages/cli/bin/flutter_ui.dart list
```

## Available components (18)

| ID | Aliases | Dependencies |
|----|---------|-------------|
| `alert` | `app_alert` | `text`, `v-stack` |
| `button` | `app_button` | — |
| `card` | `app_card` | — |
| `carousel` | `app_carousel`, `slider` | `card` |
| `checkbox` | `app_checkbox` | `text`, `v-stack` |
| `combobox` | `app_combobox`, `select`, `dropdown` | `card`, `text`, `text-field`, `v-stack` |
| `gap` | — | — |
| `h-stack` | `hstack` | `gap` |
| `navigation-menu` | `nav-menu`, `app_navigation_menu` | `card`, `text`, `v-stack` |
| `otp-field` | `otp`, `app_otp_field` | — |
| `pagination` | `app_pagination`, `pages` | `text` |
| `progress` | `app_progress`, `progressbar` | `text`, `v-stack` |
| `roadmap-item` | `roadmap`, `app_roadmap_item` | `text` |
| `switch` | `app_switch`, `toggle` | `text`, `v-stack` |
| `tabs` | `app_tabs` | `card`, `text`, `v-stack` |
| `text` | `app_text`, `typography` | — |
| `text-field` | `textfield`, `input`, `app_text_field` | — |
| `v-stack` | `vstack` | `gap` |

## Requirements

- Dart SDK `>=3.4.0 <4.0.0`

## Links

- [Repository](https://github.com/abdelrzz9/FluxUI)
- [CLI guide](../../docs/cli.md)
- [flutter_ui](https://pub.dev/packages/flutter_ui) — UI component library
