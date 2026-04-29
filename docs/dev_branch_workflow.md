# Dev Branch Workflow

This repository uses a branch model for safe refactors and release quality.

## Branches

- `main`: stable branch for releasable code
- `dev`: integration branch for ongoing feature and architecture work
- `feature/*`: short-lived feature branches

## Flow

1. Create branch from `dev`:
   - `feature/<topic>`
2. Open PR into `dev`.
3. Ensure CI is green:
   - format, lint, analyze, tests, build, architecture check
4. Merge into `dev`.
5. Periodically promote `dev` to `main` through a stabilization PR.

## Rules

- Large refactors must land in `dev` first.
- Keep PRs focused and documented.
- Update docs when structure or commands change.
- Do not bypass CI for architecture or CLI migrations.
