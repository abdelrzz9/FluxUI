# Repository Structure

```
flux_ui/
├── .fvm/                              # Flutter version management (FVM)
│   └── flutter_sdk                    # Pinned Flutter SDK version
│
├── .github/                           # GitHub configuration
│   ├── ISSUE_TEMPLATE/                # Issue templates
│   │   ├── 01_bug_report.yml
│   │   ├── 02_feature_request.yml
│   │   ├── 03_component_proposal.yml
│   │   ├── 04_theme_proposal.yml
│   │   ├── 05_performance_issue.yml
│   │   ├── 06_accessibility_issue.yml
│   │   ├── 07_question.yml
│   │   └── config.yml
│   ├── PULL_REQUEST_TEMPLATE.md       # PR template
│   ├── RFC_TEMPLATE.md                # Request for Comments template
│   └── workflows/                     # GitHub Actions
│       ├── ci.yml                     # Main CI
│       ├── publish-dry-run.yml        # Pub.dev dry-run
│       ├── release.yml                # Release workflow
│       ├── golden-tests.yml           # Golden test approvals
│       └── label-sync.yml             # Label management
│
├── assets/                            # Static assets
│   ├── fonts/                         # Bundled fonts
│   ├── images/                        # Demo images for components
│   └── icons/                         # Flux icon SVGs (if custom icons)
│
├── docs/                              # Documentation
│   ├── architecture/                  # Architecture docs
│   │   ├── ARCHITECTURE.md
│   │   ├── ARCHITECTURE_REVIEW.md
│   │   └── CHANGELOG.md
│   ├── components/                    # Per-component docs
│   │   ├── Button.md
│   │   ├── Card.md
│   │   └── ... (one per component)
│   ├── engineering/                   # Engineering standards (this directory)
│   │   ├── REPOSITORY_STRUCTURE.md
│   │   ├── CODING_STANDARDS.md
│   │   ├── CONTRIBUTING.md
│   │   ├── TESTING.md
│   │   ├── RELEASE.md
│   │   ├── VERSIONING.md
│   │   ├── PERFORMANCE.md
│   │   ├── ACCESSIBILITY.md
│   │   ├── DESIGN_SYSTEM_RULES.md
│   │   ├── API_STABILITY.md
│   │   ├── GITHUB_LABELS.md
│   │   └── GITHUB_MILESTONES.md
│   ├── roadmap/                       # Roadmap docs
│   │   ├── IMPLEMENTATION_ROADMAP.md
│   │   └── COMPONENTS.md
│   ├── themes/                        # Theme docs
│   │   └── THEMES.md
│   ├── cli.md                         # CLI reference
│   ├── publishing.md                  # Publishing guide
│   ├── roadmap.md                     # Issues roadmap
│   ├── dev_branch_workflow.md         # Branch strategy
│   └── github_issues.md              # All 88 issues
│
├── examples/                          # Example applications
│   └── catalog/                       # Official component catalog app
│       ├── lib/
│       │   ├── main.dart
│       │   ├── app.dart
│       │   ├── screens/
│       │   ├── widgets/
│       │   └── data/
│       ├── test/
│       ├── pubspec.yaml
│       └── README.md
│
├── packages/                          # Published packages (monorepo)
│   ├── flux_ui/                       # Primary component library
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_tokens/                   # Design tokens (standalone)
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_theme/                    # Theme system (depends on tokens)
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_motion/                   # Animation primitives
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_icons/                    # Icon set package
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_lints/                    # Shared lint rules
│   │   ├── lib/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_cli/                      # Shadcn-style CLI
│   │   ├── lib/
│   │   ├── test/
│   │   ├── bin/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_generator/                # Code generator (Dart macros / build_runner)
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   ├── flux_testing/                  # Shared testing utilities
│   │   ├── lib/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   └── flux_devtools/                 # Flutter DevTools extensions
│       ├── lib/
│       ├── pubspec.yaml
│       └── README.md
│
├── tools/                             # Build and automation scripts
│   ├── check_architecture.dart         # Architecture constraint checker
│   ├── check_dependencies.dart         # Dependency cycle checker
│   ├── generate_issues.dart            # Issue generation from templates
│   └── release_notes.dart              # CHANGELOG generator
│
├── scripts/                           # Shell scripts
│   ├── setup.sh                       # First-time setup
│   ├── bootstrap.sh                   # Melos bootstrap
│   ├── test.sh                        # Run all tests
│   ├── coverage.sh                    # Generate coverage report
│   └── publish.sh                     # Publish all packages
│
├── test/                              # Integration tests
│   ├── integration/                    # Full integration tests
│   ├── goldens/                       # Golden test reference images
│   └── screenshots/                   # Automated screenshots
│
├── benchmarks/                        # Performance benchmarks
│   ├── lib/                           # Benchmark scripts
│   ├── data/                          # Benchmark results
│   └── pubspec.yaml
│
├── playground/                        # Quick prototyping app for contributors
│   ├── lib/
│   ├── pubspec.yaml
│   └── README.md
│
├── website/                           # Documentation website (optional)
│   ├── (Flutter web or static site generator)
│   └── ...
│
├── melos.yaml                         # Melos monorepo configuration
├── pubspec.yaml                       # Root workspace pubspec
├── analysis_options.yaml              # Root analysis options
├── fvm_config.json                    # FVM version config
├── .gitignore
├── .editorconfig
├── LICENSE
├── CONTRIBUTING.md                    # Top-level contribution guide
├── SECURITY.md                        # Security policy
├── CODE_OF_CONDUCT.md                 # Code of conduct
├── README.md                          # Main readme
└── CHANGELOG.md                       # Top-level changelog
```

## Directory Purpose

| Directory | Purpose |
|-----------|---------|
| `.fvm/` | Pin consistent Flutter version across all contributors and CI |
| `.github/` | All GitHub automation: issue templates, PR templates, CI/CD workflows |
| `assets/` | Fonts, images, and icons used by the library and examples |
| `docs/` | All documentation — architecture, components, engineering standards, roadmap |
| `examples/` | Official example apps (catalog, showcase) |
| `packages/` | All publishable Dart/Flutter packages in the monorepo |
| `tools/` | Dart scripts for architecture validation, code generation, release management |
| `scripts/` | Shell scripts for setup, testing, coverage, deployment |
| `test/` | Top-level integration tests and golden reference images |
| `benchmarks/` | Performance benchmarks for all components |
| `playground/` | Quick prototyping app for contributors during development |
| `website/` | Optional documentation website |

## Why This Structure

1. **Monorepo with Melos**: All packages versioned together, cross-package refactoring is safe, CI runs once for all packages.
2. **Separation of tokens from components**: `flux_tokens` has zero Flutter dependency — usable from pure Dart projects.
3. **Theme as its own package**: `flux_theme` can evolve independently, enabling theme-only consumers.
4. **Motion as its own package**: Animation primitives work with any widget library, not just Flux.
5. **Testing utilities**: `flux_testing` provides golden test helpers, widget test pump helpers, accessibility checkers — avoiding test code duplication across packages.
6. **Lint rules**: `flux_lints` enforces consistent code style across all packages and is publishable for consumers.
7. **CLI as standalone**: `flux_cli` depends only on Dart — no Flutter SDK requirement.
8. **Benchmarks isolated**: No benchmark dependency leakage into production code.
9. **Playground for contributors**: Quick iteration without the full example app complexity.
