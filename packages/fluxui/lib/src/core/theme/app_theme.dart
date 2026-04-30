import 'package:flutter/material.dart';
import 'package:flutter_ui_tokens/index.dart';

import 'app_theme_tokens.dart';

abstract final class AppTheme {
  static ThemeData light({
    AppDesignTokens tokens = AppDesignTokens.light,
    String? fontFamily,
    bool useMaterial3 = true,
  }) {
    return custom(
      tokens: tokens,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      useMaterial3: useMaterial3,
    );
  }

  static ThemeData dark({
    AppDesignTokens tokens = AppDesignTokens.dark,
    String? fontFamily,
    bool useMaterial3 = true,
  }) {
    return custom(
      tokens: tokens,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      useMaterial3: useMaterial3,
    );
  }

  static ThemeData custom({
    required AppDesignTokens tokens,
    required Brightness brightness,
    String? fontFamily,
    bool useMaterial3 = true,
  }) {
    final colors = tokens.colors;
    final textTheme = _buildTextTheme(
      typography: tokens.typography,
      foreground: colors.onSurface,
      fontFamily: fontFamily,
    );
    final primaryTextTheme = _buildTextTheme(
      typography: tokens.typography,
      foreground: colors.onPrimary,
      fontFamily: fontFamily,
    );
    final colorScheme = _buildColorScheme(
      brightness: brightness,
      colors: colors,
      inverseForeground: colors.background,
      statusForeground:
          brightness == Brightness.dark ? colors.background : colors.surface,
    );

    return ThemeData(
      useMaterial3: useMaterial3,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      cardColor: colors.surface,
      dividerColor: colors.border,
      disabledColor: colors.disabled,
      splashFactory: InkRipple.splashFactory,
      textTheme: textTheme,
      primaryTextTheme: primaryTextTheme,
      iconTheme: IconThemeData(
        color: colors.onSurface,
        size: tokens.sizes.iconMd,
      ),
      primaryIconTheme: IconThemeData(
        color: colors.onPrimary,
        size: tokens.sizes.iconMd,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.onBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: colors.background,
        iconTheme: IconThemeData(
          color: colors.onBackground,
          size: tokens.sizes.iconMd,
        ),
        titleTextStyle: textTheme.titleLarge,
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: tokens.spacing.lg,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppThemeTokens.fromDesignTokens(tokens),
      ],
    );
  }

  static ColorScheme _buildColorScheme({
    required Brightness brightness,
    required AppColorTokens colors,
    required Color inverseForeground,
    required Color statusForeground,
  }) {
    return ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      secondaryContainer: colors.secondaryContainer,
      onSecondaryContainer: colors.onSecondaryContainer,
      tertiary: colors.secondaryContainer,
      onTertiary: colors.onSecondaryContainer,
      error: colors.error,
      onError: statusForeground,
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerHighest: colors.surfaceMuted,
      onSurfaceVariant: colors.onSurfaceMuted,
      outline: colors.border,
      outlineVariant: colors.borderStrong,
      shadow: colors.shadow,
      scrim: colors.overlay,
      inverseSurface: colors.surfaceInverse,
      onInverseSurface: inverseForeground,
      inversePrimary: colors.primaryContainer,
      surfaceTint: colors.primary,
    );
  }

  static TextTheme _buildTextTheme({
    required AppTypographyTokens typography,
    required Color foreground,
    String? fontFamily,
  }) {
    var textTheme = TextTheme(
      displayLarge: typography.displayLarge,
      displayMedium: typography.displayMedium,
      displaySmall: typography.displaySmall,
      headlineLarge: typography.headlineLarge,
      headlineMedium: typography.headlineMedium,
      headlineSmall: typography.headlineSmall,
      titleLarge: typography.titleLarge,
      titleMedium: typography.titleMedium,
      titleSmall: typography.titleSmall,
      bodyLarge: typography.bodyLarge,
      bodyMedium: typography.bodyMedium,
      bodySmall: typography.bodySmall,
      labelLarge: typography.labelLarge,
      labelMedium: typography.labelMedium,
      labelSmall: typography.labelSmall,
    ).apply(
      bodyColor: foreground,
      displayColor: foreground,
      fontFamily: fontFamily,
    );

    if (fontFamily != null) {
      textTheme = textTheme.apply(fontFamily: fontFamily);
    }

    return textTheme;
  }
}
