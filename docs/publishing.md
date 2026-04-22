# Publishing Guide

This repository is structured so each publishable package can be released
independently:

- `packages/tokens`
- `packages/utils`
- `packages/ui`
- `tools/cli`

## Release checklist

1. Update package versions and inter-package constraints.
2. Update changelogs and package READMEs.
3. Run:

```bash
dart pub get
dart run melos bootstrap
dart run melos run format:check
dart run melos run analyze
dart run melos run test
dart run melos run test:goldens
```

4. Run dry-run publish checks:

```bash
dart run melos run publish:dry-run:flutter
dart run melos run publish:dry-run:cli
```

5. Verify package metadata:

- `description`
- `homepage`
- `repository`
- `issue_tracker`
- `license`
- example coverage for public-facing packages

## Suggested release order

1. `flutter_ui_tokens`
2. `flutter_ui_utils`
3. `flutter_ui`
4. `flutter_ui_cli`

The UI package depends on tokens and utils, so publish those first when version
constraints move.

## CI expectations

The repository includes:

- `.github/workflows/ci.yml`
- `.github/workflows/publish_dry_run.yml`

The CI workflow checks formatting, analysis, and tests. The publish dry-run
workflow is intended as a final gate before tagging a release.
