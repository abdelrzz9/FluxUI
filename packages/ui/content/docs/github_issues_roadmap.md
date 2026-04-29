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

## Issue 3: Build the UI package

**Goal**

Deliver a complete set of token-driven Flutter widgets that cover the most common app UI needs.

**Implementation details**

- Implement `AppTheme` (light/dark/custom) and `AppThemeTokens` as a `ThemeExtension`.
- Build 19 widgets: `AppButton`, `AppCard`, `AppCarousel`, `AppAlert`, `AppProgress`, `AppTextField`, `AppCombobox`, `AppOtpField`, `Gap`, `HStack`, `VStack`, `AppNavigationMenu`, `AppPagination`, `AppTabs`, `AppRoadmapItem`, `AppCheckbox`, `AppSwitch`, `AppText`.
- All widgets pull styling exclusively from `AppThemeTokens` via `BuildContext` extensions.
- Expose a single barrel file `lib/index.dart`.

## Issue 4: Build the CLI package

**Goal**

Provide a shadcn-style copy-paste workflow so developers can own editable component files locally.

**Implementation details**

- Implement `flux add <component>` using `AddCommand` with fuzzy typo correction (Levenshtein ≤ 2).
- Implement `flutter_ui init` / `flutter_ui list` / `flutter_ui add` via `FlutterUiCli`.
- Build `ComponentRegistry` with all 18 registered components, each with inline template, aliases, dependencies, and public symbols.
- Generate `flutter_ui.json`, bridge file with `hide` list, `components/index.dart`, and `lib/ui/index.dart`.
- Write integration tests in `test/flutter_ui_cli_test.dart` and `test/cli_entrypoints_test.dart`.

## Issue 5: Add example app

**Goal**

Provide a working showcase app that validates all components visually and serves as a usage reference.

**Implementation details**

- Create `apps/example` depending on `packages/ui`.
- Implement `ExampleHomePage` exercising every public widget.
- Support light/dark theme toggle.

## Issue 6: Complete CLI component registry

**Goal**

Ensure all 18 UI package widgets are installable via `flux add`.

**Implementation details**

- Add registry entries for the 11 components missing from the initial CLI release: `alert`, `carousel`, `checkbox`, `combobox`, `navigation-menu`, `otp-field`, `pagination`, `progress`, `roadmap-item`, `switch`, `tabs`.
- Each entry includes correct aliases, dependency list, public symbols, and a copy-paste-ready template.
- Templates use `../../core/flutter_ui.dart` for token access and relative imports for inter-component dependencies.

## Issue 7: Write per-package README files

**Goal**

Each publishable package must have a `README.md` for pub.dev discoverability and first-use documentation.

**Implementation details**

- Add `README.md` to `packages/tokens`, `packages/utils`, `packages/ui`, `packages/cli`.
- Cover: description, installation, basic usage example, and links to the monorepo.

## Issue 8: Publishing preparation

**Goal**

Prepare all packages for a first pub.dev release.

**Implementation details**

- Verify and update package versions and inter-package constraints.
- Add changelogs (`CHANGELOG.md`) per package.
- Run dry-run publishing checks: `dart run melos run publish:dry-run:flutter`.
- Decide whether `flutter_ui_cli` should be published or kept as repository-only tooling.
- Ensure all packages pass the full validation suite before tagging.
