# Publishing Guide

Each package is released independently in this order:

1. `flutter_ui_tokens`
2. `flutter_ui_utils`
3. `flutter_ui` (depends on tokens + utils)
4. `flutter_ui_cli` — currently `publish_to: none`; decide per release

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

CI jobs: **format → lint → analyze → test → build**. Build requires all other jobs to pass.
