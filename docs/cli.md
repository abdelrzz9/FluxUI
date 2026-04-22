# CLI Guide

The `flutter_ui` CLI creates a local workspace inside a Flutter app and copies
editable component files into that app.

## Commands

### Initialize

```bash
dart run tools/cli/bin/flutter_ui.dart init
```

This writes:

- `flutter_ui.json`
- `lib/ui/core/flutter_ui.dart`
- `lib/ui/components/index.dart`
- `lib/ui/index.dart`

The generated `core/flutter_ui.dart` file bridges back to the package exports.
When you copy a local component, the bridge automatically hides the package
version of that symbol to avoid export conflicts.

### List available components

```bash
dart run tools/cli/bin/flutter_ui.dart list
```

### Copy components into your app

```bash
dart run tools/cli/bin/flutter_ui.dart add button text-field h-stack
```

The CLI will:

- resolve component aliases
- install dependencies such as `gap` for stack layouts
- generate local component files under `lib/ui/components`
- update `lib/ui/components/index.dart`
- update `lib/ui/core/flutter_ui.dart` to hide package duplicates

## Local import pattern

After initialization, import your local workspace instead of the package
directly:

```dart
import 'package:your_app/ui/index.dart';
```

That gives you:

- package theme tokens and extensions
- any copied local components you want to customize

## Current component registry

- `button`
- `card`
- `text`
- `text-field`
- `gap`
- `h-stack`
- `v-stack`
