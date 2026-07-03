# Publishing Guide

Each package is released independently in this order:

1. `flutter_ui_tokens` (v0.1.0)
2. `flutter_ui_utils` (v0.1.0, depends on tokens)
3. `fluxui_kit` (v0.2.0, primary package, depends on tokens + utils)
4. `flutter_ui` (v0.1.0, thin re-export of `fluxui_kit`, optional — may be deprecated)
5. `flutter_ui_cli` (v0.1.0, `publish_to: none`; keep as repo-only tooling)

---

## Release checklist

```bash
# 1. Bootstrap workspace
dart pub get
dart run melos bootstrap

# 2. Run full validation
dart run melos run check:architecture
dart run melos run format:check
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run test:goldens
dart run melos run build

# 3. Dry-run publish checks
dart run melos run publish:dry-run:flutter
dart run melos run publish:dry-run:cli
```

Before running dry-run checks, verify each package has:
- `description` (≤ 180 characters)
- `homepage` and `repository` URLs
- `issue_tracker` URL
- `version` bumped correctly
- `CHANGELOG.md` updated
- `README.md` current

---

## CI

| Workflow | Trigger |
|---------|---------|
| `ci.yml` | Every PR; push to `main`, `master`, `dev` |
| `publish_dry_run.yml` | Manual (`workflow_dispatch`) |

CI jobs (in order): **format → lint → analyze → test → build**. Build requires all prior jobs to pass.

The `analyze` job runs `flutter analyze` (ignoring CLI). The `analyze:cli` job runs `dart analyze` on the CLI package. Both must pass before `build`.
