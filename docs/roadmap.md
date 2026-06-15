# FluxUI Roadmap

## Completed

### Monorepo foundation

- Melos workspace with `packages/tokens`, `packages/utils`, `packages/fluxui`, `packages/ui`, `packages/cli`, `apps/example`, and `tools/`.
- Strict dependency direction: `tokens → utils → fluxui_kit`. CLI is isolated (pure Dart, no Flutter SDK).
- CI workflows (format, analyze, test, build) run on every PR and push to `dev`/`main`.

### Design tokens (`flutter_ui_tokens` v0.1.0)

- Strongly typed, immutable token classes: `AppColorTokens`, `AppSpacingTokens`, `AppRadiusTokens`, `AppSizeTokens`, `AppMotionTokens`, `AppTypographyTokens`.
- Aggregate `AppDesignTokens` with `.light` and `.dark` presets.
- Full `copyWith` and `lerp` support on all classes.

### UI components (`fluxui_kit` v0.2.0)

- 30+ token-driven widgets across buttons, cards, display, feedback, inputs, layouts, navigation, selection, and typography.
- `AppTheme.light()` / `.dark()` / `.custom()` with `seedColor` for Material You and `overrides` for partial token overrides.
- `BuildContext` extensions (`context.appColors`, `context.appSpacing`, etc.) for direct token access.
- Golden tests for visual regression coverage.

### CLI (`flutter_ui_cli` v0.1.0)

- Two entry points: `flux` (component installer) and `flutter_ui` (workspace bootstrap).
- `flux add` with fuzzy typo correction (Levenshtein ≤ 2), automatic dependency resolution, and file generation.
- `flutter_ui init` / `flutter_ui list` / `flutter_ui add` commands.
- 18 registered components in `ComponentRegistry` with templates, aliases, and dependency metadata.

### Example app

- `apps/example` showcases every component with light/dark theme toggle.
- Depends on `fluxui_kit` via local path.

### Documentation

- Per-package README files for all publishable packages.
- Root README with quick start, architecture overview, validation commands, and branch strategy.
- CLI guide, publishing guide, production readiness roadmap, and v1.0.0 production checklist.

## Up next

### Pre-v1.0.0

1. **Publish `flutter_ui_tokens`, `flutter_ui_utils`, `fluxui_kit` to pub.dev** — complete pub.dev production-readiness checklist, verify metadata, run publish dry-runs.
2. **API stability policy** — document SemVer, deprecation, and migration rules.
3. **Accessibility** — add accessibility tests and semantic labels for all interactive components.
4. **Expand golden tests** — cover states, themes, breakpoints, and RTL layouts.
5. **Dartdoc coverage** — document all public APIs.
6. **GitHub templates** — add issue templates, PR template, CODEOWNERS, and Dependabot.
7. **CLI expansion** — add `doctor`, `diff`, and `update` commands.
8. **Documentation site** — build a docs site with live component examples.

### v1.0.0

- Stable API surface.
- All packages published to pub.dev.
- Migration guide available.
- Release automation (tagging, release notes, changelog discipline).
