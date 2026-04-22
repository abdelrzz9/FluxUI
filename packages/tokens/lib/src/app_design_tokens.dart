import 'package:flutter/foundation.dart';

import 'app_color_tokens.dart';
import 'app_motion_tokens.dart';
import 'app_radius_tokens.dart';
import 'app_size_tokens.dart';
import 'app_spacing_tokens.dart';
import 'app_typography_tokens.dart';

@immutable
final class AppDesignTokens {
  const AppDesignTokens({
    required this.colors,
    this.spacing = AppSpacingTokens.regular,
    this.radius = AppRadiusTokens.regular,
    this.sizes = AppSizeTokens.regular,
    this.motion = AppMotionTokens.regular,
    this.typography = AppTypographyTokens.regular,
  });

  static const AppDesignTokens light = AppDesignTokens(
    colors: AppColorTokens.light,
  );

  static const AppDesignTokens dark = AppDesignTokens(
    colors: AppColorTokens.dark,
  );

  final AppColorTokens colors;
  final AppSpacingTokens spacing;
  final AppRadiusTokens radius;
  final AppSizeTokens sizes;
  final AppMotionTokens motion;
  final AppTypographyTokens typography;

  AppDesignTokens copyWith({
    AppColorTokens? colors,
    AppSpacingTokens? spacing,
    AppRadiusTokens? radius,
    AppSizeTokens? sizes,
    AppMotionTokens? motion,
    AppTypographyTokens? typography,
  }) {
    return AppDesignTokens(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      sizes: sizes ?? this.sizes,
      motion: motion ?? this.motion,
      typography: typography ?? this.typography,
    );
  }

  static AppDesignTokens lerp(AppDesignTokens a, AppDesignTokens b, double t) {
    return AppDesignTokens(
      colors: AppColorTokens.lerp(a.colors, b.colors, t),
      spacing: AppSpacingTokens.lerp(a.spacing, b.spacing, t),
      radius: AppRadiusTokens.lerp(a.radius, b.radius, t),
      sizes: AppSizeTokens.lerp(a.sizes, b.sizes, t),
      motion: AppMotionTokens.lerp(a.motion, b.motion, t),
      typography: AppTypographyTokens.lerp(a.typography, b.typography, t),
    );
  }
}
