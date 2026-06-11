# FluxUI v1.0.0 Production Checklist

Use this checklist before tagging and publishing a stable v1.0.0 release.

## Package strategy

- [ ] Primary public package is chosen.
- [ ] Secondary package purpose is documented.
- [ ] README install instructions use the primary package.
- [ ] Example app imports match the public package strategy.
- [ ] Package naming is consistent across docs, examples, and pubspec files.

## API stability

- [ ] API stability policy exists.
- [ ] SemVer rules are documented.
- [ ] Deprecation policy is documented.
- [ ] Migration guide rules are documented.
- [ ] Public API export policy is documented.
- [ ] Breaking changes require migration notes.

## Documentation

- [ ] Root README explains what FluxUI is.
- [ ] Root README includes install and quick start instructions.
- [ ] Every publishable package has a README.
- [ ] Every component has a usage example.
- [ ] Theme customization is documented.
- [ ] Design tokens are documented.
- [ ] CLI workflows are documented.
- [ ] Troubleshooting guide exists.
- [ ] Migration docs exist.
- [ ] Public APIs have dartdoc.

## Accessibility

- [ ] Accessibility policy exists.
- [ ] Interactive components expose useful semantics.
- [ ] Keyboard navigation is tested.
- [ ] Focus states are visible.
- [ ] Disabled states are clear.
- [ ] Text scaling is tested.
- [ ] Tap targets meet minimum size expectations.
- [ ] Accessibility notes are included in component docs.

## Testing

- [ ] Unit tests pass.
- [ ] Widget tests pass.
- [ ] CLI tests pass.
- [ ] Golden tests pass.
- [ ] Architecture check passes.
- [ ] Formatting check passes.
- [ ] Static analysis passes.
- [ ] Example app builds.
- [ ] Publish dry-run passes.
- [ ] Coverage target is met or documented.

## Visual quality

- [ ] Components are tested in light theme.
- [ ] Components are tested in dark theme.
- [ ] Components are tested with custom brand tokens.
- [ ] Components are tested at multiple breakpoints.
- [ ] Components are tested with large text scale.
- [ ] Components are tested in RTL where relevant.
- [ ] Loading, disabled, error, hover, and focus states are covered.

## Release process

- [ ] Changelogs are complete.
- [ ] Versions are updated.
- [ ] Inter-package constraints are correct.
- [ ] Git tag name is chosen.
- [ ] GitHub release notes are drafted.
- [ ] Publish dry-run logs are reviewed.
- [ ] Migration guide is linked from release notes.
- [ ] Release owner is assigned.

## GitHub repository polish

- [ ] Issue templates exist.
- [ ] Pull request template exists.
- [ ] CODEOWNERS exists.
- [ ] Dependabot is configured.
- [ ] CI badge is added.
- [ ] Pub.dev badges are added after publishing.
- [ ] License badge is present.
- [ ] Screenshots or GIFs are included in docs.

## CLI readiness

- [ ] `flux add` is documented.
- [ ] `flutter_ui init` is documented.
- [ ] Component registry is complete.
- [ ] CLI generated files are tested.
- [ ] CLI overwrite behavior is tested.
- [ ] CLI error messages are helpful.
- [ ] Future commands are tracked as issues.

## Final release gate

Run these commands before release:

```bash
dart pub get
dart run melos bootstrap
dart run melos run check:architecture
dart run melos run format:check
dart run melos run analyze
dart run melos run test
dart run melos run test:goldens
dart run melos run build
dart run melos run build:example
dart run melos run publish:dry-run
```
