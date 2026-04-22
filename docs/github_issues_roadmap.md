# GitHub Issues Roadmap

## Issue 1: Bootstrap the monorepo

**Goal**

Establish a maintainable workspace with Melos, package boundaries, conventions,
and shared tooling.

**Implementation details**

- Create `packages/ui`, `packages/tokens`, `packages/utils`, `apps/example`,
  and `tools/cli`.
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

## Issue 3: Implement the theme engine

**Goal**

Build a scalable theme layer that maps tokens into `ThemeData` and
`ThemeExtension`.

**Implementation details**

- Add light, dark, and custom theme factories.
- Create dedicated theme extensions for colors, spacing, radius, and
  typography.
- Ensure Material widgets and package widgets derive from the same source of
  truth.
- Add tests that validate theme consistency and override behavior.

## Issue 4: Build fluent extension APIs

**Goal**

Improve developer ergonomics without introducing hidden behavior.

**Implementation details**

- Add widget extensions for spacing, alignment, decoration, and layout helpers.
- Add context extensions for reading theme tokens and responsive information.
- Keep extension names short, predictable, and chainable.
- Avoid extensions that hide expensive work or introduce state.

## Issue 5: Ship the first component set

**Goal**

Deliver a production-grade base component set that proves the architecture.

**Implementation details**

- Implement `AppText`, `AppButton`, `AppCard`, `AppTextField`, `HStack`,
  `VStack`, and `Gap`.
- Support variants, sizes, loading, and disabled states where relevant.
- Keep components stateless where possible and make state visible in APIs when
  needed.
- Add widget and golden tests for each public component.

## Issue 6: Add feedback and overlay primitives

**Goal**

Expand the system beyond basic form controls into reusable feedback patterns.

**Implementation details**

- Build badge, alert, toast, progress, and skeleton primitives.
- Define semantic variants such as success, warning, destructive, and neutral.
- Ensure feedback components remain theme-driven and accessible.
- Add example screens that demonstrate composition with existing components.

## Issue 7: Build responsive layout utilities

**Goal**

Support adaptive layouts without pushing app-specific layout decisions into the
package.

**Implementation details**

- Add breakpoint definitions and responsive value helpers.
- Implement container and stack helpers for common page layouts.
- Keep APIs declarative and composable.
- Add tests around breakpoint selection and layout behavior.

## Issue 8: Implement the CLI foundation

**Goal**

Create the shadcn-style DX layer for adding components directly into user
projects.

**Implementation details**

- Design a CLI command structure centered on `flux add button`.
- Keep `flutter_ui init` and `flutter_ui list` available during the transition
  period while the newer Flux-facing command surface grows.
- Define a component manifest format and file templates.
- Detect package imports and insertion points in host projects.
- Keep generated code readable and easy to own by the consuming team.

## Issue 9: Add CLI generators and customization

**Goal**

Make the CLI useful in real projects with override points and template
versioning.

**Implementation details**

- Allow component variants or style presets during generation.
- Support local template overrides and custom registries.
- Add versioned templates to keep generated code compatible with package
  releases.
- Add tests for file generation, import resolution, and failure modes.

## Issue 10: Build the documentation system

**Goal**

Turn the package set into an open-source system people can actually adopt.

**Implementation details**

- Write installation, theming, component, CLI, and migration guides.
- Add architecture diagrams and public API references.
- Use the example app as the documentation source of truth where possible.
- Document copy-paste philosophy and package versus CLI tradeoffs clearly.

## Issue 11: Add CI and release automation

**Goal**

Make quality gates and publishing predictable.

**Implementation details**

- Add CI jobs for format, Flutter linting, Dart analysis, tests, and build.
- Keep build focused on a real repo artifact, currently the `flux` CLI
  executable.
- Add semantic versioning and changelog generation.
- Automate publishing for independently versioned packages.
- Guard breaking changes with API review and release notes.

## Issue 12: Prepare for public release

**Goal**

Ship the ecosystem in a state that feels trustworthy to outside adopters.

**Implementation details**

- Review naming, API consistency, package metadata, and examples.
- Audit documentation coverage and first-run DX.
- Verify pub.dev scores, screenshots, and licensing.
- Tag a stable `0.x` release and collect user feedback before `1.0.0`.
