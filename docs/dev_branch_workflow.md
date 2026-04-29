# Branch Workflow

FluxUI uses a three-tier branch strategy.

## Branches

| Branch | Purpose |
|--------|---------|
| `main` | Stable, releasable. Tagged releases come from here. |
| `dev` | Integration branch. All feature work merges here first. |
| `feature/*` | Short-lived. Branch from `dev`, merge back to `dev`. |

## Day-to-day flow

```bash
git checkout dev
git pull origin dev
git checkout -b feature/my-topic

# ... make changes ...

dart run melos run format:check
dart run melos run analyze
dart run melos run test

git push origin feature/my-topic
# Open PR into dev
```

## Rules

- Never push directly to `main`.
- Keep PRs small and focused — one concern per PR.
- Run the full validation suite locally before requesting review.
- Update docs when public API or CLI commands change.
- Promote `dev` → `main` through a stabilization PR when a release is ready.

## CI gates

Every PR and every push to `main`, `master`, and `dev` runs:
- format check
- Flutter analyze
- Dart analyze
- tests
- build (CLI executable)
