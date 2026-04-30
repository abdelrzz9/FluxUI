import 'package:flutter/material.dart';
import 'package:flutter_ui_tokens/index.dart';

import '../theme/app_theme_tokens.dart';

extension AppThemeDataExtensions on ThemeData {
  AppThemeTokens get appTokens =>
      extension<AppThemeTokens>() ??
      AppThemeTokens.fromDesignTokens(
        brightness == Brightness.dark
            ? AppDesignTokens.dark
            : AppDesignTokens.light,
      );

  AppColorTokens get appColors => appTokens.colors;

  AppSpacingTokens get appSpacing => appTokens.spacing;

  AppRadiusTokens get appRadius => appTokens.radius;

  AppSizeTokens get appSizes => appTokens.sizes;

  AppMotionTokens get appMotion => appTokens.motion;

  AppTypographyTokens get appTypography => appTokens.typography;
}

extension AppBuildContextThemeExtensions on BuildContext {
  ThemeData get appTheme => Theme.of(this);

  AppThemeTokens get appTokens => appTheme.appTokens;

  AppColorTokens get appColors => appTheme.appColors;

  AppSpacingTokens get appSpacing => appTheme.appSpacing;

  AppRadiusTokens get appRadius => appTheme.appRadius;

  AppSizeTokens get appSizes => appTheme.appSizes;

  AppMotionTokens get appMotion => appTheme.appMotion;

  AppTypographyTokens get appTypography => appTheme.appTypography;
}
