import 'package:flutter/material.dart';
import 'package:flutter_ui_tokens/index.dart';

/// Optional [ThemeExtension] that allows overriding FluxUI design tokens
/// through the app's [MaterialApp] theme.
///
/// All fields are optional. When provided, they override the corresponding
/// tokens from [AppThemeTokens]. When `null`, the existing FluxUI tokens
/// (or defaults) are used as fallback.
///
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light().copyWith(
///     extensions: <ThemeExtension<dynamic>>[
///       ...AppTheme.light().extensions.values,
///       FluxThemeData(
///         colors: AppColorTokens.light.copyWith(
///           primary: Color(0xFF6366F1),
///         ),
///       ),
///     ],
///   ),
/// );
/// ```
@immutable
final class FluxThemeData extends ThemeExtension<FluxThemeData> {
  const FluxThemeData({
    this.colors,
    this.spacing,
    this.radius,
    this.sizes,
    this.motion,
    this.typography,
  });

  /// Creates a [FluxThemeData] from a complete [AppDesignTokens] set.
  FluxThemeData.fromDesignTokens(AppDesignTokens tokens)
      : colors = tokens.colors,
        spacing = tokens.spacing,
        radius = tokens.radius,
        sizes = tokens.sizes,
        motion = tokens.motion,
        typography = tokens.typography;

  /// Color overrides. Falls back to existing tokens when `null`.
  final AppColorTokens? colors;

  /// Spacing overrides. Falls back to existing tokens when `null`.
  final AppSpacingTokens? spacing;

  /// Radius overrides. Falls back to existing tokens when `null`.
  final AppRadiusTokens? radius;

  /// Size overrides. Falls back to existing tokens when `null`.
  final AppSizeTokens? sizes;

  /// Motion/animation overrides. Falls back to existing tokens when `null`.
  final AppMotionTokens? motion;

  /// Typography overrides. Falls back to existing tokens when `null`.
  final AppTypographyTokens? typography;

  /// Resolves this [FluxThemeData] against a [fallback], producing a
  /// complete [AppDesignTokens] set.
  ///
  /// Non-null fields in this instance take precedence over the fallback.
  AppDesignTokens resolve(AppDesignTokens fallback) {
    return AppDesignTokens(
      colors: colors ?? fallback.colors,
      spacing: spacing ?? fallback.spacing,
      radius: radius ?? fallback.radius,
      sizes: sizes ?? fallback.sizes,
      motion: motion ?? fallback.motion,
      typography: typography ?? fallback.typography,
    );
  }

  @override
  FluxThemeData copyWith({
    AppColorTokens? colors,
    AppSpacingTokens? spacing,
    AppRadiusTokens? radius,
    AppSizeTokens? sizes,
    AppMotionTokens? motion,
    AppTypographyTokens? typography,
  }) {
    return FluxThemeData(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      sizes: sizes ?? this.sizes,
      motion: motion ?? this.motion,
      typography: typography ?? this.typography,
    );
  }

  @override
  FluxThemeData lerp(ThemeExtension<FluxThemeData>? other, double t) {
    if (other is! FluxThemeData) return this;

    return FluxThemeData(
      colors: colors != null && other.colors != null
          ? AppColorTokens.lerp(colors!, other.colors!, t)
          : other.colors ?? colors,
      spacing: spacing != null && other.spacing != null
          ? AppSpacingTokens.lerp(spacing!, other.spacing!, t)
          : other.spacing ?? spacing,
      radius: radius != null && other.radius != null
          ? AppRadiusTokens.lerp(radius!, other.radius!, t)
          : other.radius ?? radius,
      sizes: sizes != null && other.sizes != null
          ? AppSizeTokens.lerp(sizes!, other.sizes!, t)
          : other.sizes ?? sizes,
      motion: motion != null && other.motion != null
          ? AppMotionTokens.lerp(motion!, other.motion!, t)
          : other.motion ?? motion,
      typography: typography != null && other.typography != null
          ? AppTypographyTokens.lerp(typography!, other.typography!, t)
          : other.typography ?? typography,
    );
  }
}
