# GitHub Issues Roadmap

## Issue 1: Bootstrap the monorepo

**Goal**

Establish a maintainable workspace with Melos, package boundaries, conventions,
and shared tooling.

**Implementation details**

- Create `packages/ui`, `packages/tokens`, `packages/utils`, `apps/example`,
  and a package-level CLI entrypoint under `packages/cli`.
- Add `melos.yaml` with bootstrap, format, lint, analyze, typecheck, test, and
  build workflows.
- Define package naming strategy and dependency direction:
  `tokens -> utils -> ui`, while `example` depends on `ui` and `cli` stays
  isolated.
- Add repository standards: branching strategy, CI, linting, and contribution
  guidelines.

## Issue 2: Build the tokens package

**Goal**

Create a strongly typed token system that is portable across apps and safe to
evolve.

**Implementation details**

- Implement token primitives for spacing, radius, color roles, typography
  scale, and motion durations.
- Keep tokens immutable and documented.
- Separate raw palette tokens from semantic roles where appropriate.
- Expose stable public APIs from a single barrel file.
