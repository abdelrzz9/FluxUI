# Contributing to Flux UI

## Repository Setup

### Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Flutter | >=3.24.0 (pinned in `.fvm/`) | Framework |
| Dart | >=3.4.0 (<4.0.0) | Language |
| Melos | latest | Monorepo management |
| FVM | latest (optional) | Flutter version management |

### First-Time Setup

```bash
# 1. Clone the repository
git clone https://github.com/your-org/flux_ui.git
cd flux_ui

# 2. Install Flutter (via FVM, recommended)
fvm install
fvm use

# 3. Bootstrap Melos workspace
dart pub global activate melos
melos bootstrap

# 4. Run validation
melos run analyze
melos run test
```

### Without FVM

```bash
flutter --version  # must be >=3.24.0
dart pub get
melos bootstrap
```

## Flutter Version Policy

- The repository pins a specific Flutter version in `.fvm/flutter_sdk`
- CI uses the same pinned version
- Version is updated within 2 weeks of stable Flutter releases
- Breaking Flutter upgrades (e.g., 3.x → 4.x) are treated as project milestones

## Melos Workflow

| Command | Purpose |
|---------|---------|
| `melos bootstrap` | Install dependencies, link packages |
| `melos analyze` | Run `dart analyze` on all packages |
| `melos format` | Run `dart format` on all packages |
| `melos test` | Run `flutter test` on all packages |
| `melos run golden:update` | Update golden reference images |
| `melos run check:architecture` | Validate architecture constraints |
| `melos run check:dependencies` | Validate dependency direction |
| `melos run publish:dry-run` | Dry-run pub.dev publishing |

## How to Run Tests

```bash
# All tests across all packages
melos run test

# Specific package
cd packages/flux_ui && flutter test

# Specific test file
flutter test test/flux_button_test.dart

# With coverage
melos run test -- --coverage
genhtml coverage/lcov.info -o coverage/html

# Golden tests
flutter test --update-goldens  # update references
```

## How to Run Examples

```bash
# Component catalog app
cd examples/catalog && flutter run

# Playground (for quick prototyping)
cd playground && flutter run
```

## How to Add a New Component

1. **Create GitHub Issue**: Use the Component Proposal template
2. **Design Review**: Architecture team reviews the API design
3. **Create Files**:
   - `packages/flux_ui/lib/src/components/<category>/flux_<name>.dart`
   - `packages/flux_ui/lib/src/components/<category>/flux_<name>_theme.dart`
   - `packages/flux_ui/test/src/components/<category>/flux_<name>_test.dart`
   - `packages/flux_ui/test/src/components/<category>/flux_<name>_golden_test.dart`
   - `docs/components/<Name>.md`
4. **Implement**: Follow CODING_STANDARDS.md
5. **Tests**: Widget tests, golden tests, accessibility tests
6. **Documentation**: Component markdown with all required sections
7. **PR**: Create pull request with checklist

## How to Write Documentation

- Every component gets a markdown file in `docs/components/`
- Use the template from DOCUMENTATION_STANDARDS.md
- Include code snippets that are tested (copy-paste safe)
- Include screenshots for visual components

## How to Write Golden Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_ui/flux_ui.dart';

void main() {
  testWidgets('FluxButton golden — primary variant', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Scaffold(
          body: FluxButton(
            variant: FluxButtonVariant.primary,
            child: const Text('Click me'),
          ),
        ),
      ),
    );
    await expectLater(
      find.byType(FluxButton),
      matchesGoldenFile('goldens/flux_button_primary.png'),
    );
  });
}
```

## PR Checklist

Before submitting a PR, verify:

- [ ] Code follows CODING_STANDARDS.md
- [ ] `melos run analyze` passes with no warnings
- [ ] `melos run format` produces no changes
- [ ] `melos run test` passes
- [ ] Golden tests are included and pass
- [ ] Documentation is written or updated
- [ ] CHANGELOG.md is updated
- [ ] All new public APIs have doc comments
- [ ] Accessibility (Semantics) is implemented
- [ ] Keyboard navigation is supported
- [ ] RTL layout is verified
- [ ] Theme integration is correct (uses specific `ThemeExtension`)
- [ ] `debugFillProperties` is implemented for DevTools
- [ ] `const` constructor is provided
- [ ] No `copyWith` on widgets (only on data classes)

## Review Checklist

- [ ] API follows established patterns (naming, parameter ordering, callbacks)
- [ ] No unnecessary breaking changes
- [ ] Test coverage is adequate
- [ ] Golden tests look correct
- [ ] Documentation is clear and complete
- [ ] Performance concerns are addressed
- [ ] Accessibility requirements are met
- [ ] No duplicated code
- [ ] No hardcoded values (all through theme/tokens)

## Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
[optional footer]
```

### Types

| Type | Usage |
|------|-------|
| `feat` | New component or feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, lint fixes |
| `refactor` | Code change with no behavior change |
| `test` | Adding or fixing tests |
| `perf` | Performance improvement |
| `a11y` | Accessibility improvement |
| `theme` | Theme system change |
| `chore` | Build, CI, dependencies |
| `breaking` | Breaking API change |

### Scope

| Scope | Package |
|-------|---------|
| `ui` | `flux_ui` package |
| `tokens` | `flux_tokens` package |
| `theme` | `flux_theme` package |
| `motion` | `flux_motion` package |
| `cli` | `flux_cli` package |
| `lint` | `flux_lints` package |
| `icons` | `flux_icons` package |
| `docs` | Documentation |
| `ci` | CI/CD |
| `example` | Example apps |

### Examples

```
feat(ui): add FluxSlider component with range support
fix(ui): correct FluxButton hover state color
docs(components): add FluxAccordion documentation
a11y(ui): add Semantics to FluxCheckbox
breaking(theme): rename FluxThemeData to FluxColorTheme
chore(ci): add golden test workflow
```

## Branch Naming

| Branch | Pattern | Source |
|--------|---------|--------|
| Feature | `feat/<component-name>` | `dev` |
| Fix | `fix/<issue-description>` | `dev` |
| Docs | `docs/<topic>` | `dev` |
| Refactor | `refactor/<description>` | `dev` |
| Release | `release/v<major>.<minor>.<patch>` | `dev` |
| Hotfix | `hotfix/<description>` | `main` |

## Release Process

1. Create `release/vX.Y.Z` branch from `dev`
2. Update versions in all packages (melos version)
3. Update CHANGELOG.md files
4. Run full validation suite
5. Create PR to `main` with release checklist
6. Merge to `main`
7. Tag with `vX.Y.Z`
8. Publish to pub.dev via CI
9. Merge back to `dev`

See [RELEASE.md](RELEASE.md) for full release process.
