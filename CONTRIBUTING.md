# Contributing to FluxUI

---

## Setup

```bash
dart pub get
dart run melos bootstrap
```

---

## Validation

Run the full suite before pushing:

```bash
dart run melos run check:architecture
dart run melos run format:check
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run build
```

Update golden snapshots when a visual change is intentional:

```bash
dart run melos run test:update-goldens
```

---

## Branch strategy

- Branch from `dev`: `git checkout -b feature/my-topic`
- Open a PR into `dev`
- Merge only after CI is green

See [docs/dev_branch_workflow.md](docs/dev_branch_workflow.md).

---

## Package boundaries

| Package | Contains |
|---------|---------|
| `flutter_ui_tokens` | Immutable design tokens only. No widgets. |
| `flutter_ui_utils` | Generic Flutter extensions and responsive helpers. No business logic. |
| `flutter_ui` | Theme integration and UI components. No business logic. |
| `flutter_ui_cli` | Copy-paste workflow, component registry, file generation. No Flutter SDK dependency. |

The dependency direction is strict: `tokens → utils → ui`. The CLI is isolated.

---

## Component rules

- Keep components **stateless** unless Flutter itself requires state.
- All styling comes from **`AppThemeTokens`** via `BuildContext` extensions — no hardcoded colors or sizes.
- Prefer **readable code** over deep abstraction — components are meant to be copy-paste-friendly.
- Add a **widget test** for every behavioral path.
- Add a **golden test** when a component materially affects rendering.
- If a component is added to `packages/ui`, add a matching **CLI registry entry** in `packages/cli/lib/src/component_registry.dart`.

---

## CLI registry entries

Every component entry in `ComponentRegistry` requires:
- `id` — kebab-case unique identifier
- `aliases` — alternative names for fuzzy matching
- `outputPath` — relative path inside `lib/ui/components/`
- `publicSymbols` — all public class/enum names (used to build the `hide` list)
- `dependencies` — other component IDs this component needs
- `description` — one-sentence summary
- `template` — complete, self-contained Dart source using `../../core/flutter_ui.dart` for token access

---

## Pull request checklist

- [ ] Formatting passes (`format:check`)
- [ ] Flutter analyze passes
- [ ] Dart analyze passes
- [ ] All tests pass
- [ ] Build passes
- [ ] Goldens updated if visuals changed
- [ ] Public exports are intentional
- [ ] Docs updated if the package surface or CLI commands changed
- [ ] CLI registry updated if a new component was added
