# CLI Guide

FluxUI currently ships two CLI entry points:

- `flux` for the new developer-facing add flow
- `flutter_ui` for workspace bootstrap, compatibility, and the older command set

The command surface is intentionally documented as it exists today, not as the
future end state.

## Current Commands

### Preferred add flow

```bash
dart run tools/cli/bin/flux.dart add button
```

You can add more than one component in a single call:

```bash
dart run tools/cli/bin/flux.dart add button card
```

`flux add` will:

- resolve component aliases
- resolve registered dependencies such as `gap` for stack layouts
- create folders when needed
- copy component template files into the target app
- update generated bridge and index files
- prompt before overwriting an existing file

### Workspace initialization

```bash
dart run tools/cli/bin/flutter_ui.dart init
```

This writes:

- `flutter_ui.json`
- `lib/ui/core/flutter_ui.dart`
- `lib/ui/components/index.dart`
- `lib/ui/index.dart`

The generated `core/flutter_ui.dart` file bridges back to the package exports
and hides package symbols when a local copied component exists.

### List available components

```bash
dart run tools/cli/bin/flutter_ui.dart list
```

### Compatibility add flow

```bash
dart run tools/cli/bin/flutter_ui.dart add button text-field h-stack
```

Use this if you need the existing initialized workspace flow. The long-term
direction is `flux add`, but both surfaces currently exist.

## Local Import Pattern

After initialization, import your local workspace instead of the package
directly:

```dart
import 'package:your_app/ui/index.dart';
```

That gives you:

- package theme tokens and extensions
- generated local components under `lib/ui/components`
- a single local export surface for future customization

## Current Component Registry

- `button`
- `card`
- `text`
- `text-field`
- `gap`
- `h-stack`
- `v-stack`

## Notes

- The first file-backed CLI template is `button`.
- `flux` currently focuses on `add`; `init` and `list` still live under the
  `flutter_ui` executable.
