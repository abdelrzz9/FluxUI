import 'package:flutter/material.dart';
import 'package:flutter_ui_tokens/index.dart';

@immutable
final class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  const AppThemeTokens({
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.sizes,
    required this.motion,
    required this.typography,
  });

  AppThemeTokens.fromDesignTokens(AppDesignTokens tokens)
      : this(
          colors: tokens.colors,
          spacing: tokens.spacing,
          radius: tokens.radius,
          sizes: tokens.sizes,
          motion: tokens.motion,
          typography: tokens.typography,
        );

  final AppColorTokens colors;
  final AppSpacingTokens spacing;
  final AppRadiusTokens radius;
  final AppSizeTokens sizes;
  final AppMotionTokens motion;
  final AppTypographyTokens typography;

  AppDesignTokens get designTokens => AppDesignTokens(
        colors: colors,
        spacing: spacing,
        radius: radius,
        sizes: sizes,
        motion: motion,
        typography: typography,
      );

  @override
  AppThemeTokens copyWith({
    AppColorTokens? colors,
    AppSpacingTokens? spacing,
    AppRadiusTokens? radius,
    AppSizeTokens? sizes,
    AppMotionTokens? motion,
    AppTypographyTokens? typography,
  }) {
    return AppThemeTokens(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      sizes: sizes ?? this.sizes,
      motion: motion ?? this.motion,
      typography: typography ?? this.typography,
    );
  }

  @override
  AppThemeTokens lerp(ThemeExtension<AppThemeTokens>? other, double t) {
    if (other is! AppThemeTokens) {
      return this;
    }

    return AppThemeTokens(
      colors: AppColorTokens.lerp(colors, other.colors, t),
      spacing: AppSpacingTokens.lerp(spacing, other.spacing, t),
      radius: AppRadiusTokens.lerp(radius, other.radius, t),
      sizes: AppSizeTokens.lerp(sizes, other.sizes, t),
      motion: AppMotionTokens.lerp(motion, other.motion, t),
      typography: AppTypographyTokens.lerp(typography, other.typography, t),
    );
  }
}
