# CLI Guide

FluxUI ships two CLI entry points.

| Binary | Purpose |
|--------|---------|
| `flux` | Day-to-day component installer |
| `flutter_ui` | Workspace bootstrap and compatibility |

---

## flux add

Copy one or more components into a Flutter project.

```bash
dart run packages/cli/bin/flux.dart add button
dart run packages/cli/bin/flux.dart add button card alert
dart run packages/cli/bin/flux.dart add button --overwrite
```

`flux add` will:
- resolve aliases (`buttom` → `button` via fuzzy match, Levenshtein ≤ 2)
- auto-install declared dependencies (e.g. `h-stack` pulls in `gap`)
- create target directories if needed
- write component `.dart` files into `lib/ui/components/`
- regenerate `lib/ui/core/flutter_ui.dart` (bridge with `hide` list)
- regenerate `lib/ui/components/index.dart`
- regenerate `lib/ui/index.dart`
- prompt before overwriting if `--overwrite` is not set

After copying, import the local surface instead of the package:
```dart
import 'package:your_app/ui/index.dart';
```

---

## flutter_ui init

Bootstrap the workspace scaffold in a Flutter project (run once).

```bash
dart run packages/cli/bin/flutter_ui.dart init
dart run packages/cli/bin/flutter_ui.dart init --force   # overwrite existing files
```

Creates:
- `flutter_ui.json` — workspace config
- `lib/ui/core/flutter_ui.dart` — package bridge
- `lib/ui/components/index.dart` — local components barrel
- `lib/ui/index.dart` — unified export

After init, import the local surface instead of the package directly:

```dart
import 'package:your_app/ui/index.dart';
```

---

## flutter_ui list

Print all registered components.

```bash
dart run packages/cli/bin/flutter_ui.dart list
```

---

## flutter_ui add (compatibility)

Same as `flux add` but requires `flutter_ui init` first.

```bash
dart run packages/cli/bin/flutter_ui.dart add button card
```

---

## Available components

| ID | Aliases | Dependencies | Description |
|----|---------|-------------|-------------|
| `alert` | `app_alert` | `text`, `v-stack` | Info / success / warning / danger / neutral alert |
| `button` | `app_button` | — | Primary action with 4 variants, 3 sizes, loading state |
| `card` | `app_card` | — | Surface container with outline and muted variants |
| `carousel` | `app_carousel`, `slider` | `card` | Paginated carousel with controls and indicators |
| `checkbox` | `app_checkbox` | `text`, `v-stack` | Labeled checkbox with tristate support |
| `combobox` | `app_combobox`, `select`, `dropdown` | `card`, `text`, `text-field`, `v-stack` | Searchable bottom-sheet picker |
| `gap` | — | — | Axis-aware spacer primitive |
| `h-stack` | `hstack` | `gap` | Horizontal stack with automatic gaps |
| `navigation-menu` | `nav-menu`, `app_navigation_menu` | `card`, `text`, `v-stack` | Tabbed navigation with panel content |
| `otp-field` | `otp`, `app_otp_field` | — | OTP / PIN input with paste and backspace support |
| `pagination` | `app_pagination`, `pages` | `text` | Page range with ellipsis and prev/next controls |
| `progress` | `app_progress`, `progressbar` | `text`, `v-stack` | Linear and circular progress indicators |
| `roadmap-item` | `roadmap`, `app_roadmap_item` | `text` | Roadmap list row with state icon and metadata |
| `switch` | `app_switch`, `toggle` | `text`, `v-stack` | Labeled toggle switch |
| `tabs` | `app_tabs` | `card`, `text`, `v-stack` | Tab bar with optional panel content |
| `text` | `app_text`, `typography` | — | Token-driven text widget with tone and type scale |
| `text-field` | `textfield`, `input`, `app_text_field` | — | Form field with outline and filled variants |
| `v-stack` | `vstack` | `gap` | Vertical stack with automatic gaps |
