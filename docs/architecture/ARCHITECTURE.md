# Flux UI Architecture

## Overview

Flux UI is a Flutter component library ported from MColi UI (React). It follows clean architecture principles with a modular monorepo structure under `packages/`.

**Monorepo structure** (see `README.md#Monorepo-structure`):
- `packages/tokens/` — `flutter_ui_tokens`: immutable, typed design tokens with `lerp`
- `packages/utils/` — `flutter_ui_utils`: `BuildContext` extensions, widget API, responsive helpers
- `packages/ui/` — `flutter_ui`: mirrored component library with `AppTheme`, widgets, context extensions
- `packages/fluxui/` — `fluxui_kit`: primary consumer package re-exporting tokens + utils + components
- `packages/cli/` — `flutter_ui_cli`: shadcn-style CLI (`flux add`, `flutter_ui init`)

## Directory Structure (Primary Package)

```
packages/fluxui/  (or packages/ui/)
├── lib/
│   ├── flux_ui.dart                  # Barrel export — everything
│   ├── flux_theme.dart               # Barrel export — theme only
│   ├── flux_components.dart          # Barrel export — components only
│   ├── flux_primitives.dart          # Barrel export — primitives only
│   ├── flux_utilities.dart           # Barrel export — utilities only
│   └── src/
│       ├── core/
│       │   ├── tokens/               # Design tokens
│       │   │   ├── colors.dart
│       │   │   ├── typography.dart
│       │   │   ├── spacing.dart
│       │   │   ├── radius.dart
│       │   │   ├── elevation.dart
│       │   │   ├── opacity.dart
│       │   │   ├── animation.dart
│       │   │   ├── breakpoints.dart
│       │   │   └── z_index.dart
│       │   ├── theme/               # Focused ThemeExtensions (split)
│       │   │   ├── flux_theme.dart
│       │   │   ├── flux_color_theme.dart
│       │   │   ├── flux_typography_theme.dart
│       │   │   ├── flux_shape_theme.dart
│       │   │   ├── flux_spacing_theme.dart
│       │   │   ├── flux_shadow_theme.dart
│       │   │   ├── flux_animation_theme.dart
│       │   │   ├── flux_button_theme.dart
│       │   │   ├── flux_card_theme.dart
│       │   │   ├── flux_input_theme.dart
│       │   │   ├── flux_navigation_theme.dart
│       │   │   ├── flux_overlay_theme.dart
│       │   │   ├── light_theme.dart
│       │   │   ├── dark_theme.dart
│       │   │   ├── high_contrast_theme.dart
│       │   │   ├── brand_themes/
│       │   │   │   ├── primary_theme.dart
│       │   │   │   ├── secondary_theme.dart
│       │   │   │   ├── game_dev_theme.dart
│       │   │   │   ├── robotics_theme.dart
│       │   │   │   └── it_theme.dart
│       │   │   └── extensions/
│       │   │       ├── flux_color_scheme_mapping.dart
│       │   │       ├── flux_text_theme_mapping.dart
│       │   │       └── flux_dynamic_color.dart
│       │   ├── extensions/
│       │   │   ├── build_context_ext.dart
│       │   │   ├── widget_ext.dart
│       │   │   ├── color_ext.dart
│       │   │   ├── text_style_ext.dart
│       │   │   └── string_ext.dart
│       │   ├── animations/
│       │   │   ├── fade_transition.dart
│       │   │   ├── slide_transition.dart
│       │   │   ├── scale_transition.dart
│       │   │   ├── spring_animation.dart
│       │   │   ├── shared_axis_transition.dart
│       │   │   └── shimmer_effect.dart
│       │   └── primitives/
│       │       ├── flux_pressable.dart
│       │       ├── flux_focus_ring.dart
│       │       ├── flux_animated_visibility.dart
│       │       ├── flux_provider.dart
│       │       ├── flux_portal.dart
│       │       ├── flux_icon.dart
│       │       └── flux_text.dart
│       ├── components/
│       │   ├── inputs/
│       │   │   ├── flux_text_field.dart
│       │   │   ├── flux_search_field.dart
│       │   │   ├── flux_select.dart
│       │   │   ├── flux_slider.dart
│       │   │   ├── flux_switch.dart
│       │   │   ├── flux_checkbox.dart
│       │   │   ├── flux_radio.dart
│       │   │   └── flux_input_otp.dart
│       │   ├── buttons/
│       │   │   ├── flux_button.dart
│       │   │   ├── flux_icon_button.dart
│       │   │   └── flux_button_group.dart
│       │   ├── navigation/
│       │   │   ├── flux_tabs.dart
│       │   │   ├── flux_accordion.dart
│       │   │   ├── flux_breadcrumb.dart
│       │   │   ├── flux_pagination.dart
│       │   │   ├── flux_navigation_rail.dart
│       │   │   ├── flux_drawer.dart
│       │   │   ├── flux_stepper.dart
│       │   │   ├── flux_sidebar.dart
│       │   │   └── flux_dropdown_menu.dart
│       │   ├── surfaces/
│       │   │   ├── flux_card.dart
│       │   │   └── flux_accordion.dart
│       │   ├── feedback/
│       │   │   ├── flux_alert.dart
│       │   │   ├── flux_toast.dart
│       │   │   ├── flux_snackbar.dart
│       │   │   ├── flux_progress.dart
│       │   │   ├── flux_skeleton.dart
│       │   │   ├── flux_shimmer.dart
│       │   │   ├── flux_spinner.dart
│       │   │   └── flux_loading.dart
│       │   ├── overlay/
│       │   │   ├── flux_dialog.dart
│       │   │   ├── flux_bottom_sheet.dart
│       │   │   ├── flux_popover.dart
│       │   │   ├── flux_tooltip.dart
│       │   │   ├── flux_drawer.dart
│       │   │   └── flux_overlay.dart
│       │   ├── data_display/
│       │   │   ├── flux_table.dart
│       │   │   ├── flux_timeline.dart
│       │   │   ├── flux_avatar.dart
│       │   │   ├── flux_badge.dart
│       │   │   ├── flux_chip.dart
│       │   │   ├── flux_tag.dart
│       │   │   ├── flux_divider.dart
│       │   │   ├── flux_image.dart
│       │   │   ├── flux_carousel.dart
│       │   │   └── flux_masonry.dart
│       │   └── layout/
│       │       ├── flux_grid.dart
│       │       ├── flux_stack.dart
│       │       ├── flux_hero.dart
│       │       ├── flux_banner.dart
│       │       ├── flux_empty_state.dart
│       │       ├── flux_error_state.dart
│       │       ├── flux_responsive_layout.dart
│       │       ├── flux_adaptive_layout.dart
│       │       ├── flux_gap.dart
│       │       ├── flux_safe_area.dart
│       │       └── flux_constrained_box.dart
│       ├── utils/
│       │   ├── flux_cn.dart
│       │   ├── flux_variant.dart
│       │   ├── flux_size.dart
│       │   ├── flux_breakpoint.dart
│       │   ├── flux_animation_helpers.dart
│       │   └── responsive.dart
│       ├── painting/
│       │   ├── flux_gradients.dart
│       │   └── flux_shadows.dart
│       └── effects/
│           ├── ripple_effect.dart
│           └── glass_effect.dart
├── pubspec.yaml
├── README.md
└── CHANGELOG.md
```

## Architecture Layers

### 1. Core Layer
- **Tokens**: Raw, immutable design values with `lerp` support
- **Theme**: Focused `ThemeExtension` subclasses (one per domain), `lerp`, `==`, `hashCode`, `copyWith`, `merge`
- **Extensions**: `BuildContext`, widget, color, text-style, and string utilities
- **Animations**: Reusable `FadeTransition`, `SlideTransition`, `ScaleTransition`, `SharedAxisTransition` wrappers
- **Primitives**: Base building blocks (`FluxPressable`, `FluxFocusRing`, `FluxAnimatedVisibility`, etc.)

### 2. Components Layer
Sub-categorized by function:
- `inputs/` — Form-like interactive widgets
- `buttons/` — Action triggers
- `navigation/` — Navigation and menu widgets
- `surfaces/` — Container surfaces
- `feedback/` — User feedback indicators
- `overlay/` — Modal and floating elements
- `data_display/` — Complex data presentations
- `layout/` — Layout primitives and responsive containers

Each widget:
- Reads only its specific `ThemeExtension` (not monolithic)
- Uses `const` constructors
- Overrides `debugFillProperties`
- Includes `Semantics` for accessibility
- Uses `EdgeInsetsDirectional` for RTL support
- Supports `FocusNode`/`onFocusChange` for keyboard navigation
- Follows controlled + uncontrolled patterns where applicable

### 3. Layouts Layer
Responsive and adaptive layout widgets using `FluxBreakpoint` system.

### 4. Utils Layer
Shared utilities: variant/size resolution, color manipulation, animation helpers, responsive values.

## React → Flutter Pattern Replacements

| React Pattern | Flutter Replacement |
|---------------|--------------------|
| `cva()` | `ThemeExtension` + `WidgetStateProperty` |
| `cn()` | `BoxDecoration.merge()` / `ButtonStyle.merge()` |
| `createPortal()` | `FluxPortal` + `OverlayEntry` |
| `@base-ui/react/button` | `FluxPressable` + `Semantics` + `Focus` |
| CSS `transition-all` | `AnimatedContainer`, `TweenAnimationBuilder` |
| `use client` | `StatefulWidget` |

## Component API Pattern

Follow Flutter idioms — no `copyWith` on widgets (widgets are immutable descriptions):

```dart
class FluxButton extends StatelessWidget {
  const FluxButton({
    super.key,
    this.variant = FluxButtonVariant.primary,
    this.size = FluxButtonSize.md,
    this.icon,          // icon-only mode — child optional when set
    this.trailing,
    this.loading,       // Widget? — pass custom loader
    this.onPressed,
    this.focusNode,
    this.onFocusChange,
    this.semanticLabel,
    this.style,         // WidgetStateProperty<ButtonStyle>?
    this.child,         // optional when icon is used
  });

  // Helper factory for common presets
  static ButtonStyle styleFrom({...}) => ...;
}
```

## Theme Integration

All Flux widgets consume focused `ThemeExtension` subclasses. Each component reads only its own extension:

```dart
// Good — reads only what it needs
final colors = Theme.of(context).extension<FluxColorTheme>()!;
final buttonTheme = Theme.of(context).extension<FluxButtonTheme>()!;

// Register via FluxProvider:
FluxProvider(
  colorTheme: FluxColorTheme(...),
  buttonTheme: FluxButtonTheme(...),
  cardTheme: FluxCardTheme(...),
  child: MaterialApp(...),
)
```

Or via standard `ThemeData.extensions`:

```dart
Theme(
  data: ThemeData(
    extensions: [
      FluxColorTheme.light(),
      FluxTypographyTheme.light(),
      FluxShapeTheme.light(),
      FluxButtonTheme.primary(),
      FluxCardTheme.elevated(),
    ],
  ),
  child: ...
)
```

## Responsive System

```dart
// Breakpoint-aware context extensions
final bp = context.breakpoint;     // FluxBreakpoint enum
final isMobile = context.isMobile; // bool
final isDesktop = context.isDesktop;

// Responsive layout
FluxResponsiveLayout(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
)

// Responsive value
final padding = context.respondsTo<double>(
  mobile: 8, tablet: 12, desktop: 16,
);
```
