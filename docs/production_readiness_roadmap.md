# FluxUI Production Readiness Roadmap

This roadmap turns the current FluxUI monorepo into a production-ready Flutter
package ecosystem that feels trustworthy, stable, and polished like large Flutter
packages such as `bloc`, `go_router`, `riverpod`, and established UI libraries.

FluxUI already has a strong foundation: a Melos monorepo, multiple packages, a
showcase app, CI workflows, dry-run publishing workflow, package READMEs, tests,
golden tests, typed design tokens, and a component-copying CLI. The next phase is
about production trust: API stability, documentation, accessibility, release
process, package clarity, and long-term maintenance.

## Current strengths

- **Monorepo foundation:** packages are split into focused areas: tokens, utils,
  UI, the primary kit, CLI tooling, and an example app.
- **Validation scripts:** Melos scripts already cover architecture checks,
  formatting, analysis, testing, golden tests, builds, and publish dry-runs.
- **CI coverage:** GitHub Actions already runs architecture checks, formatting,
  analysis, tests, CLI build, and example web build.
- **Typed design system:** colors, spacing, radius, size, typography, and motion
  are represented by typed design tokens.
- **Two adoption modes:** users can either install the package or copy components
  locally with the CLI.
- **Example app:** a showcase app exists and can become the public documentation
  and QA surface.

## Production goals

By v1.0.0, FluxUI should be:

1. **Clear to adopt** — users know which package to install and why.
2. **Safe to upgrade** — SemVer, deprecation, and migration rules are documented.
3. **Accessible by default** — every component has accessibility behavior and
   tests.
4. **Visually stable** — key component states are covered by golden tests.
5. **Well documented** — every public API and component has examples.
6. **Release-ready** — dry-run publishing, changelogs, tags, and release notes are
   part of the standard workflow.
7. **Easy to contribute to** — GitHub templates, PR requirements, and ownership
   rules are clear.
8. **Useful at scale** — performance, responsive behavior, platform support, and
   CLI workflows are tested.

## Milestones

### Milestone 1: Production foundation

**Goal:** make FluxUI safe to publish and easy to understand.

Recommended issues:

1. Decide the public package strategy: `fluxui_kit` vs `flutter_ui`.
2. Complete the pub.dev production-readiness checklist.
3. Define SemVer, deprecation, and migration policy.
4. Strengthen CI quality gates.
5. Add GitHub issue templates, PR template, CODEOWNERS, and Dependabot.
6. Add release automation and changelog discipline.

### Milestone 2: Trust and quality

**Goal:** make users trust the package in real apps.

Recommended issues:

1. Add accessibility requirements and tests for all UI components.
2. Expand golden tests across states, variants, themes, breakpoints, and RTL.
3. Validate responsive, desktop, mobile, web, and keyboard behavior.
4. Add dartdoc coverage for all public APIs.
5. Turn the example app into a full component showcase and QA surface.
6. Add performance tests and budgets for core components.

### Milestone 3: Developer experience

**Goal:** make FluxUI easy and enjoyable to adopt.

Recommended issues:

1. Create a documentation site with live examples.
2. Expand the `flux` CLI with `doctor`, `diff`, `update`, and token commands.
3. Add design token import/export workflows.
4. Add migration guides for every breaking release.
5. Improve copy-paste component ownership workflows.
6. Add troubleshooting guides and common recipes.

### Milestone 4: v1.0.0 release

**Goal:** publish a stable, documented, tested, production-ready release.

Release checklist:

- Public package strategy finalized.
- API stability policy published.
- All public APIs documented.
- All packages pass publish dry-run checks.
- CI is green.
- Golden tests are stable.
- Accessibility checklist is complete.
- Example app showcases every component and state.
- Migration guide is written.
- Changelog entries are complete.
- GitHub release notes are drafted.
- pub.dev package release is completed.

## Top 10 issues to create first

1. Decide public package strategy: `fluxui_kit` vs `flutter_ui`.
2. Prepare `fluxui_kit` for first pub.dev release.
3. Define SemVer, deprecation, and migration policy.
4. Add issue templates, PR template, CODEOWNERS, and Dependabot.
5. Add dartdoc coverage for all public APIs.
6. Add accessibility audit and tests for every component.
7. Expand golden tests across states, themes, breakpoints, and RTL.
8. Turn the example app into a complete component showcase.
9. Create a documentation site with live examples.
10. Expand the CLI with `doctor`, `diff`, and `update` commands.

## Suggested success metrics

Track these metrics before v1.0.0:

- Pub.dev score for each published package.
- Test coverage per package.
- Number of components with accessibility tests.
- Number of components with golden coverage.
- Number of public APIs with dartdoc.
- Example app build status.
- Docs pages completed.
- CLI commands covered by tests.
- Open issues by priority.
- Release checklist completion.
