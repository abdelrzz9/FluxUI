# Example App Architecture Review

## Current architecture issues

1. **Feature state was owned by a large page widget.**
   The former `ExampleHomePage` mixed `TextEditingController` lifecycle, tab/page selections, carousel state, form values, and the full widget tree in one state object. This made unrelated concerns rebuild together and made future state changes risky.

2. **Static showcase data was embedded in the UI file.**
   Registry options, release tabs, navigation menu items, carousel content, and roadmap content lived beside rendering code. That coupled copy/content changes to page layout changes and prevented reuse in tests or future data-backed sources.

3. **Reusable UI fragments were private to a monolithic page.**
   Hero, section shell, color swatch, carousel slide, and roadmap rendering were all private classes in one file. This made the page difficult to scan and prevented feature-level composition.

4. **Theme mode logic lived in the app widget state.**
   The root app owned `setState`-based theme toggling. A dedicated controller better separates app state from app composition and can later be persisted or injected.

5. **Legacy file names described implementation details instead of feature intent.**
   `example_home_page.dart` did not describe the showcase feature boundary. The refactor keeps compatibility through exports while moving implementation to a feature-first `showcase` module.

## Proposed architecture diagram

```text
lib/main.dart
  -> src/example_app.dart                         compatibility barrel
    -> src/app/example_app.dart                   app composition
      -> ThemeController                          app-level state
      -> ShowcasePage                             feature entry point
        -> ShowcaseController                     presentation state + actions
        -> ShowcaseCatalog                        data/content source
          -> domain models                        UI-independent content shapes
        -> presentation/widgets                   reusable section widgets
```

## Folder structure

```text
apps/example/lib/src/
├── app/
│   ├── example_app.dart
│   └── theme_controller.dart
├── example_app.dart
├── example_home_page.dart
└── features/
    └── showcase/
        ├── data/
        │   └── showcase_catalog.dart
        ├── domain/
        │   └── models/
        │       ├── carousel_slide_content.dart
        │       ├── registry_option.dart
        │       ├── release_tab_content.dart
        │       ├── roadmap_entry.dart
        │       └── showcase_navigation_item.dart
        └── presentation/
            ├── controllers/
            │   └── showcase_controller.dart
            ├── pages/
            │   └── showcase_page.dart
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
| `apps/example/lib/main.dart` | Starts the example app through the public app runner. | Stay unchanged. |
| `apps/example/lib/src/example_app.dart` | Compatibility barrel for existing imports. | Keep as an export; implementation moved. |
| `apps/example/lib/src/example_home_page.dart` | Compatibility barrel for existing page imports. | Keep as an export; implementation moved to `ShowcasePage`. |
| `apps/example/lib/src/app/example_app.dart` | Compose `MaterialApp`, theme configuration, and feature entry page. | New app layer file. |
| `apps/example/lib/src/app/theme_controller.dart` | Own app-level theme mode state and actions. | New app state file. |
| `apps/example/lib/src/features/showcase/data/showcase_catalog.dart` | Provide showcase content currently backed by static data. | New data layer boundary. |
| `apps/example/lib/src/features/showcase/domain/models/*` | Define feature content shapes independent from section widgets. | New domain layer models. |
| `apps/example/lib/src/features/showcase/presentation/controllers/showcase_controller.dart` | Own mutable showcase UI state, controller lifecycle, and state transitions. | New presentation state boundary. |
| `apps/example/lib/src/features/showcase/presentation/pages/showcase_page.dart` | Assemble the showcase screen from sections. | New page-level composition file. |
| `apps/example/lib/src/features/showcase/presentation/widgets/*` | Render one reusable section or primitive per file. | New reusable presentation components. |

## Migration steps

1. Move app composition from `src/example_app.dart` to `src/app/example_app.dart`.
2. Extract theme state into `ThemeController`.
3. Replace `ExampleHomePage` implementation with `ShowcasePage` under a feature-first module.
4. Move static content lists into `ShowcaseCatalog` and typed domain models.
5. Move mutable showcase state and text controller lifecycle into `ShowcaseController`.
6. Split each showcase area into a focused widget file.
7. Keep legacy barrels so existing imports continue to compile.

## Future scalability recommendations

- Replace `ShowcaseCatalog` with repository abstractions if showcase data becomes remote or generated.
- Add widget tests around each section now that sections are isolated.
- Introduce a dependency injection boundary before adding persistence, analytics, or multiple app environments.
- Keep feature modules vertical: domain/data/presentation files for one feature should not depend on another feature's presentation code.
- Continue publishing package components from `packages/fluxui` and keep the example app as a consumer, not an owner, of design-system primitives.
