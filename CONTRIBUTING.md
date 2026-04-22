# Contributing

## Local workflow

1. Bootstrap the workspace:

```bash
dart pub global activate melos
melos bootstrap
```

2. Validate formatting, analysis, and tests:

```bash
melos run format:check
melos run analyze
melos run test
```

3. Update goldens when a visual change is intentional:

```bash
melos run test:update-goldens
```

## Package boundaries

- `flutter_ui_tokens` contains immutable design tokens only.
- `flutter_ui_utils` contains generic extensions and responsive helpers.
- `flutter_ui` contains theme integration and UI components.
- `flutter_ui_cli` contains the copy-paste workflow and local generation logic.

Keep business logic out of all of these packages.

## Component contribution rules

- Prefer readable, copy-paste-friendly code over deep abstraction.
- Keep components stateless unless Flutter itself requires state.
- Pull all styling from theme tokens and theme extensions.
- Add widget tests for behavior and golden tests for stable visual surfaces when a component materially affects rendering.

## Pull request checklist

- Formatting passes
- Analysis passes
- Tests pass
- Goldens updated if visuals changed
- Public exports remain intentional
- Docs updated if the package surface changed

