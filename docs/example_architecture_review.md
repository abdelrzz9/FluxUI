# Example App Architecture Review

## Current architecture issues addressed

1. **Feature state was owned by a large page widget.**
   The showcase state now lives behind `ShowcaseController` and an immutable
   `ShowcaseState`, instead of being stored as many unrelated mutable fields on
   the page.

2. **Static showcase data was embedded in UI code.**
   Static content now lives in `ShowcaseCatalog`, behind the
   `ShowcaseRepository` domain contract. Presentation depends on the contract,
   not directly on the concrete data source.

3. **The app lacked composition boundaries.**
   Startup now flows through an app bootstrap, dependency container, and router
   layer, so future APIs, persistence, auth, feature flags, and repositories can
   be registered outside widgets.

4. **Routing was hardcoded through `MaterialApp.home`.**
   The app now uses an `AppRouter` and route constants. The current router is
   intentionally small, but the seam is ready for guarded routes, deep links,
   and nested navigation.

5. **Architecture drift was too easy.**
   CI runs an architecture checker that enforces required app/feature folders,
   expected CI/Melos commands, example tests, and clean showcase data/domain
   dependencies.

## Proposed architecture diagram

```text
lib/main.dart
  -> app/bootstrap.dart                         startup/composition entry
    -> AppDependencies                          dependency container
      -> ThemeController                        app-level state
      -> ShowcaseRepository                     domain contract
        -> ShowcaseCatalog                      static data implementation
    -> ExampleApp                               app shell/theme/router host
      -> AppRouter                              route composition
        -> ShowcasePage                         feature page
          -> ShowcaseController                 presentation actions
          -> ShowcaseState                      immutable presentation state
          -> presentation/widgets               reusable section widgets
          -> presentation/mappers               Flutter/FluxUI mapping only
```

## Folder structure

```text
apps/example/lib/src/
├── app/
│   ├── bootstrap.dart
│   ├── example_app.dart
│   ├── theme_controller.dart
│   ├── di/
│   │   └── app_dependencies.dart
│   └── router/
│       ├── app_router.dart
│       └── app_routes.dart
├── example_app.dart
├── example_home_page.dart
└── features/
    └── showcase/
        ├── data/
        │   └── showcase_catalog.dart
        ├── domain/
        │   ├── models/
        │   │   ├── carousel_slide_content.dart
        │   │   ├── registry_option.dart
        │   │   ├── release_tab_content.dart
        │   │   ├── roadmap_entry.dart
        │   │   ├── showcase_icon.dart
        │   │   └── showcase_navigation_item.dart
        │   └── repositories/
        │       └── showcase_repository.dart
        └── presentation/
            ├── controllers/
            │   └── showcase_controller.dart
            ├── mappers/
            │   └── showcase_icon_mapper.dart
            ├── pages/
            │   └── showcase_page.dart
            ├── state/
            │   └── showcase_state.dart
            └── widgets/
                ├── buttons_section.dart
                ├── carousel_slide.dart
                ├── color_swatch.dart
                ├── display_section.dart
                ├── feedback_section.dart
                ├── hero_banner.dart
                ├── inputs_section.dart
                ├── layouts_section.dart
                ├── navigation_section.dart
                ├── roadmap_list.dart
                ├── selection_section.dart
                ├── showcase_section.dart
                └── typography_section.dart
```

## File-by-file migration decisions

| File | Responsibility | Decision |
| --- | --- | --- |
| `apps/example/lib/main.dart` | Starts the app through bootstrap. | Keep as the only executable entry point. |
| `apps/example/lib/src/app/bootstrap.dart` | Initializes Flutter bindings and injects app dependencies. | New composition-root seam. |
| `apps/example/lib/src/app/di/app_dependencies.dart` | Owns app-scoped dependencies and disposal. | New dependency container. |
| `apps/example/lib/src/app/router/*` | Owns route names and page construction. | New navigation boundary. |
| `apps/example/lib/src/app/example_app.dart` | Hosts `MaterialApp`, theme, and router. | Keep app shell only. |
| `apps/example/lib/src/app/theme_controller.dart` | Owns app-level theme mode state. | Keep app state file. |
| `apps/example/lib/src/example_app.dart` | Compatibility barrel for existing imports. | Keep as export. |
| `apps/example/lib/src/example_home_page.dart` | Compatibility wrapper for old page name. | Keep temporarily, remove in a breaking cleanup. |
| `features/showcase/domain/repositories/showcase_repository.dart` | Defines data access contract for the feature. | New domain boundary. |
| `features/showcase/data/showcase_catalog.dart` | Static repository implementation for showcase content. | Keep until remote/local sources exist. |
| `features/showcase/presentation/state/showcase_state.dart` | Immutable presentation state snapshot. | New state model. |
| `features/showcase/presentation/controllers/showcase_controller.dart` | Mutates `ShowcaseState` and owns text controller lifecycle. | Keep, but split if state grows. |
| `features/showcase/presentation/widgets/*` | Render one section/component each. | Keep focused and UI-only. |

## CI/CD architecture

- CI installs one pinned Flutter SDK, bootstraps Melos, validates architecture,
  checks formatting, analyzes Flutter packages, analyzes the pure Dart CLI,
  tests Flutter packages, tests the CLI package, builds the CLI executable, and
  builds the example web app.
- Melos scripts are split by runtime so Flutter packages never share the CLI's
  Dart-only path accidentally.
- Publish dry-runs validate Flutter packages and the Dart CLI separately.
- `tools/check_architecture.dart` now enforces DI/router/repository/state/test
  seams in addition to forbidden data/domain imports.

## Migration steps

1. Move app startup into `app/bootstrap.dart`.
2. Register app-scoped dependencies in `AppDependencies`.
3. Replace `MaterialApp.home` with `AppRouter` and route constants.
4. Introduce `ShowcaseRepository` in domain and make `ShowcaseCatalog` implement it.
5. Replace many mutable controller fields with immutable `ShowcaseState`.
6. Keep data/domain Flutter-free by storing icon identifiers as `ShowcaseIcon`.
7. Keep presentation mapping inside `presentation/mappers` and widgets.
8. Add controller/catalog/app smoke tests for the example app.

## Future scalability recommendations

- Replace `ShowcaseCatalog` with remote/local data sources and a repository
  implementation when the app gains APIs or persistence.
- Introduce route guards before adding authentication.
- Move to fine-grained state selectors if `ShowcaseController` grows further.
- Consolidate duplicated package surfaces between `packages/ui` and
  `packages/fluxui` before the component set grows.
- Upgrade the architecture checker from string matching to import graph parsing.
