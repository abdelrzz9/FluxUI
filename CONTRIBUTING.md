# Contributing

## Local Workflow

1. Bootstrap the workspace:

```bash
dart pub get
dart run melos bootstrap
```

2. Run the full validation set:

```bash
dart run melos run format:check
dart run melos run analyze
dart run melos run typecheck
dart run melos run test
dart run melos run build
```

3. Update goldens when a visual change is intentional:

```bash
dart run melos run test:update-goldens
```

## Package Boundaries

- `flutter_ui_tokens` contains immutable design tokens only.
- `flutter_ui_utils` contains generic extensions and responsive helpers.
- `flutter_ui` contains theme integration and UI components.
- `flutter_ui_cli` contains the copy-paste workflow, templates, and local
  generation logic.

Keep business logic out of all of these packages.

## CLI Status

The current CLI surface is hybrid:

- `flux add ...` is the preferred component installation command
- `flutter_ui init` and `flutter_ui list` still own workspace bootstrapping
- `flutter_ui add ...` remains available for compatibility

Document the command surface accurately when you change it.

## Component Contribution Rules

- Prefer readable, copy-paste-friendly code over deep abstraction.
- Keep components stateless unless Flutter itself requires state.
- Pull all styling from theme tokens and theme extensions.
- Add widget tests for behavior and golden tests for stable visual surfaces when
  a component materially affects rendering.
- If a component is meant for CLI generation, keep the generated file readable
  without depending on package-private helpers.

## Pull Request Checklist

- Formatting passes
- Flutter linting passes
- Dart analysis passes
- Tests pass
- Build passes
- Goldens updated if visuals changed
- Public exports remain intentional
- Docs updated if the package surface changed
