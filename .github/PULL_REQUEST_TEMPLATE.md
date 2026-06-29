## Description

<!-- Provide a summary of the changes. -->
<!-- Include the issue number this PR addresses. -->

Fixes #(issue)

## Type of Change

- [ ] Bug fix (non-breaking change fixing an issue)
- [ ] New component (non-breaking change adding functionality)
- [ ] Enhancement (non-breaking change improving an existing component)
- [ ] Breaking change (fix or feature that breaks existing API)
- [ ] Documentation update
- [ ] Test addition or improvement
- [ ] Performance improvement
- [ ] Accessibility improvement
- [ ] CI/CD or infrastructure change

## Component Checklist

<!-- For component PRs, verify each item -->

- [ ] `const` constructor is provided
- [ ] `debugFillProperties` is implemented
- [ ] `Semantics` is implemented with correct role
- [ ] Keyboard navigation is supported (Focus, onKey, Actions)
- [ ] RTL layout is verified (EdgeInsetsDirectional, TextAlign.start)
- [ ] Theme extension is created and registered
- [ ] `WidgetStateProperty` support is provided for interactive states
- [ ] `FluxPressable` is used for hover/press/focus/disabled states
- [ ] `copyWith` is NOT used on widget (only on data classes)

## Testing Checklist

- [ ] Unit tests added for new utilities
- [ ] Widget tests added for all variants and states
- [ ] Golden tests added for visual variants
- [ ] Accessibility tests added (Semantics verification)
- [ ] RTL tests added
- [ ] Tests pass locally (`melos run test`)

## Documentation Checklist

- [ ] Component documentation in `docs/components/<Name>.md`
- [ ] All public API has `///` doc comments
- [ ] CHANGELOG.md updated
- [ ] Migration notes included (if breaking change)

## Review Checklist

- [ ] Code follows CODING_STANDARDS.md
- [ ] `melos run analyze` passes with no warnings
- [ ] `melos run format` produces no changes
- [ ] No hardcoded values (all through tokens/theme)
- [ ] No dependencies introduced without justification
- [ ] Performance considerations addressed

## Screenshots

<!-- If applicable, add screenshots to help explain your changes. -->
