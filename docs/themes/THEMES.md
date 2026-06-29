# Flux UI — Theme System

## Architecture

Flux UI provides a 5-brand theme system mirroring MColi UI's 5 custom themes. Each theme defines light and dark mode colors, border radii, and semantic color tokens.

## Color Token Categories

### Raw Palette (~100 colors)

Extracted from `commonColors` in MColi UI:

| Family | Shades |
|--------|--------|
| baby-blue | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950, 1000 |
| blue-primary | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 |
| purple-secondary | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 |
| pink | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 |
| cyan | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 |
| gray | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950, 1000 |
| gray-blue | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950, 1000 |
| orange | 50, 100, 200, 300, 400, 500, 600 |
| red | 50, 100, 200 |
| green | 50, 300, 400 |
| yellow | 50, 100, 200 |
| flashy-green | 50, 100, 200, 300 |
| neutral | white, black |
| accent | blue, flash, green, magenta, red (each -50) |
| it-gradient | `linear-gradient(to right, #34D399, #78DEBF)` |

### Semantic Tokens

Each theme defines these CSS variables for light and dark:

| Token | Purpose |
|-------|---------|
| `--background` | Page background |
| `--foreground` | Primary text color |
| `--primary` | Primary brand color |
| `--primary-foreground` | Text on primary |
| `--secondary` | Secondary brand color |
| `--secondary-foreground` | Text on secondary |
| `--accent` | Accent/highlight color |
| `--accent-foreground` | Text on accent |
| `--card` | Card surface color |
| `--card-foreground` | Text on card |
| `--popover` | Popover/dropdown surface |
| `--popover-foreground` | Text on popover |
| `--muted` | Muted/de-emphasized background |
| `--muted-foreground` | Muted text |
| `--destructive` | Error/danger color |
| `--destructive-foreground` | Text on destructive |
| `--border` | Default border color |
| `--input` | Input field background |
| `--ring` | Focus ring color |
| `--surface` | Surface background |
| `--surface-foreground` | Text on surface |
| `--success` | Success state color |
| `--success-foreground` | Text on success |
| `--warning` | Warning state color |
| `--warning-foreground` | Text on warning |
| `--error` | Error state color |
| `--info` | Info state color |
| `--info-foreground` | Text on info |
| `--chart-1` through `--chart-5` | Chart series colors |
| `--sidebar` through `--sidebar-ring` | Sidebar-specific tokens |

## Brand Themes

### 1. Primary (Default)
```dart
FluxTheme.primary()
```
- **Light**: Deep blue palette with baby-blue accents
- **Dark**: Dark gray-blue background with light text
- **Radius**: 0.25rem / 0.375rem / 0.5rem / 0.75rem

### 2. Secondary
```dart
FluxTheme.secondary()
```
- **Light**: Purple-dominant with orange accents
- **Dark**: Navy background, purple primary
- **Radius**: Same as primary

### 3. GameDev
```dart
FluxTheme.gameDev()
```
- **Light**: Warm yellow tones, pink primary, cyan accents
- **Dark**: Dark blue-gray, yellow primary
- **Radius**: Larger (2xl = 1rem)

### 4. Robotics
```dart
FluxTheme.robotics()
```
- **Light**: White/black high-contrast, blue primary, cyan accent
- **Dark**: Black background, white text
- **Radius**: Sharp (all = 0.125-0.25rem)

### 5. IT
```dart
FluxTheme.it()
```
- **Light**: White, green primary, gray-blue text
- **Dark**: Navy background, green primary
- **Radius**: Standard

## Flutter Theme Extension Mapping

The monolithic `FluxThemeData` has been split into focused `ThemeExtension` subclasses for tree-shaking and testability:

| Extension | Tokens | Used By |
|-----------|--------|---------|
| `FluxColorTheme` | All color tokens | All components |
| `FluxTypographyTheme` | Header/paragraph styles | `FluxText`, Button, Card |
| `FluxShapeTheme` | Border radii | Card, Button, Dialog |
| `FluxSpacingTheme` | Spacing scale | All layout widgets |
| `FluxShadowTheme` | Elevation/shadows | Card, Dialog, Popover |
| `FluxAnimationTheme` | Durations & curves | All animated widgets |
| `FluxButtonTheme` | Button-specific | `FluxButton` |
| `FluxCardTheme` | Card-specific | `FluxCard` |
| `FluxInputTheme` | Input-specific | `FluxTextField`, `FluxSelect` |
| `FluxNavigationTheme` | Nav-specific | `FluxTabs`, `FluxNavigationRail` |
| `FluxOverlayTheme` | Overlay-specific | `FluxDialog`, `FluxPopover`, `FluxTooltip` |

Each extension implements `lerp()`, `hashCode`, `==`, `copyWith`, and `merge`.

### Registration

```dart
// Via FluxProvider (recommended)
FluxProvider(
  colorTheme: FluxColorTheme.light(),
  buttonTheme: FluxButtonTheme.primary(),
  child: MaterialApp(...),
)

// Or via standard ThemeData.extensions
Theme(
  data: ThemeData(
    extensions: [
      FluxColorTheme.light(),
      FluxTypographyTheme.light(),
      FluxButtonTheme.primary(),
    ],
  ),
)
```

### Access

```dart
// Via context extensions
final colors = context.fluxColors;     // FluxColorTheme
final spacing = context.fluxSpacing;   // FluxSpacingTheme
final buttonTheme = context.fluxButtonTheme;

// Or via Theme.of
final colors = Theme.of(context).extension<FluxColorTheme>()!;
```

Each component reads ONLY its specific extension — no monolithic lookup.

## `lerp` Support

All theme extensions support smooth interpolation for theme transitions:

```dart
final lightColors = FluxColorTheme.light();
final darkColors = FluxColorTheme.dark();
final t = animation.value; // 0.0 → 1.0
final current = lightColors.lerp(darkColors, t);
```

## ColorScheme Mapping

| Flux Token | `ColorScheme` Property |
|-----------|----------------------|
| `primary` | `primary` |
| `primaryForeground` | `onPrimary` |
| `secondary` | `secondary` |
| `secondaryForeground` | `onSecondary` |
| `background` | `surface` |
| `foreground` | `onSurface` |
| `destructive` | `error` |
| `destructiveForeground` | `onError` |
| `surface` | `surfaceContainerLow` |
| `muted` | `surfaceContainerHigh` |
| `border` | `outlineVariant` |
| `ring` | `outline` |

## Typography Mapping

| Flux Token | `TextTheme` Style |
|-----------|------------------|
| `header-xl` | `displayLarge` |
| `header-lg` | `displayMedium` |
| `header-md` | `displaySmall` |
| `header-sm` | `headlineLarge` |
| `header-xs` | `headlineMedium` |
| `paragraph-xl` | `titleLarge` |
| `paragraph-lg` | `titleMedium` |
| `paragraph-md` | `bodyLarge` |
| `paragraph-sm` | `bodyMedium` |
| `paragraph-xs` | `bodySmall` |

## High Contrast Theme

```dart
FluxTheme.highContrast()
```

All tokens optimized for WCAG AAA (7:1 minimum contrast ratio). Automatically activates when `MediaQuery.highContrast` is enabled. Provides:
- Increased border widths
- Larger focus rings
- High-contrast color overrides
- Distinct surface differentiation

## Dynamic Color / Material You

```dart
FluxTheme.dynamic(
  seedColor: Color(0xFF6366F1),
  brightness: Brightness.light,
)
```

When dynamic color is enabled, brand themes are disabled and all Flux tokens derive from `ColorScheme.fromSeed()`. Supports:
- `FluxDynamicColorConfig(seedColor, contrastLevel, isDark)`
- Automatic mapping from M3 `ColorScheme` to Flux tokens
- `tonalSurface` option for M3 surface tint support

## High Contrast Mode

Provide a `FluxHighContrastTheme` that ensures WCAG AAA compliance. Override colors to meet 7:1 contrast ratio.

## Text Styles (Typography)

### Headers (Plus Jakarta Sans)
| Token | Size | Line Height | Letter Spacing | Weight |
|-------|------|-------------|----------------|--------|
| header-xl | 72px | 90px | -0.02em | Normal |
| header-lg | 60px | 72px | -0.02em | Normal |
| header-md | 36px | 44px | -0.02em | Normal |
| header-sm | 30px | 38px | 0 | Normal |
| header-xs | 24px | 32px | 0 | Normal |

### Paragraphs (DM Sans)
| Token | Size | Line Height |
|-------|------|-------------|
| paragraph-xl | 20px | 30px |
| paragraph-lg | 18px | 28px |
| paragraph-md | 16px | 24px |
| paragraph-sm | 14px | 20px |
| paragraph-xs | 12px | 18px |

## Fonts
- **DM Sans**: Body text (`--font-dm-sans`)
- **Plus Jakarta Sans**: Headings (`--font-plus-jakarta-sans`)

## Shadows

| Token | Value |
|-------|-------|
| shadow-xs | `0 1px 4px 0px hsl(0 0% 0% / 0.04)` |
| shadow-sm | `0 4px 12px -4px hsl(0 0% 0% / 0.08)` |
| shadow-md | `0 4px 6px -1px hsl(0 0% 0% / 0.1)` |
| shadow-lg | `0 10px 15px -3px hsl(0 0% 0% / 0.1)` |
| shadow-xl | `0 16px 20px -5px hsl(0 0% 0% / 0.1)` |
| shadow-2xl | `0 20px 25px -5px hsl(0 0% 0% / 0.1)` |
| shadow-3xl | `0 25px 50px -12px hsl(0 0% 0% / 0.12)` |

## Blur

| Token | Value |
|-------|-------|
| blur-sm | 2px |
| blur-md | 4px |
| blur-lg | 7px |
| blur-xl | 9px |

## Flutter Equivalents

```dart
// Spacing: 4px base unit
FluxSpacingTheme(
  xs: 4, sm: 8, md: 12, lg: 16, xl: 20, 2xl: 24, 3xl: 32, 4xl: 40,
)

// Radius
FluxShapeTheme(
  sm: 4, md: 6, lg: 8, xl: 12, 2xl: 12, // in logical pixels
)

// Shadows -> Flutter BoxShadow
FluxShadowTheme(
  xs: [BoxShadow(blurRadius: 4, offset: Offset(0, 1), color: Color(0x0A000000))],
  sm: [BoxShadow(blurRadius: 12, offset: Offset(0, 4), color: Color(0x14000000))],
  md: [BoxShadow(blurRadius: 6, offset: Offset(0, 4), color: Color(0x1A000000))],
  lg: [BoxShadow(blurRadius: 15, offset: Offset(0, 10), color: Color(0x1A000000))],
  xl: [BoxShadow(blurRadius: 20, offset: Offset(0, 16), color: Color(0x1A000000))],
  '2xl': [BoxShadow(blurRadius: 25, offset: Offset(0, 20), color: Color(0x1A000000))],
  '3xl': [BoxShadow(blurRadius: 50, offset: Offset(0, 25), color: Color(0x1F000000))],
)
```

## Dynamic/Material 3

FluxTheme adapts to `Material 3` dynamic color when `useMaterial3: true` and no brand is specified. All semantic tokens fall back to M3 `ColorScheme` colors.
