import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppTheme', () {
    test('light theme maps default tokens into ThemeData', () {
      final theme = AppTheme.light();
      final extension = theme.extension<AppThemeTokens>();

      expect(extension, isNotNull);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppDesignTokens.light.colors.primary);
      expect(theme.scaffoldBackgroundColor,
          AppDesignTokens.light.colors.background);
      expect(extension!.spacing.md, AppDesignTokens.light.spacing.md);
      expect(theme.textTheme.titleLarge?.fontSize,
          AppDesignTokens.light.typography.titleLarge.fontSize);
      expect(theme.textTheme.titleLarge?.color,
          AppDesignTokens.light.colors.onSurface);
    });

    test('dark theme exposes dark semantic surfaces', () {
      final theme = AppTheme.dark();
      final extension = theme.extension<AppThemeTokens>();

      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.surface, AppDesignTokens.dark.colors.surface);
      expect(
          theme.colorScheme.onSurface, AppDesignTokens.dark.colors.onSurface);
      expect(extension!.colors.primary, AppDesignTokens.dark.colors.primary);
    });

    test('custom theme keeps overrides in both ThemeData and ThemeExtension',
        () {
      final tokens = AppDesignTokens.light.copyWith(
        colors: AppDesignTokens.light.colors.copyWith(
          primary: const Color(0xFF7C3AED),
          background: const Color(0xFFFDF4FF),
        ),
        spacing: AppDesignTokens.light.spacing.copyWith(md: 18),
      );

      final theme = AppTheme.custom(
        tokens: tokens,
        brightness: Brightness.light,
        fontFamily: 'Sora',
      );
      final extension = theme.extension<AppThemeTokens>();

      expect(theme.colorScheme.primary, const Color(0xFF7C3AED));
      expect(theme.scaffoldBackgroundColor, const Color(0xFFFDF4FF));
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Sora');
      expect(extension!.spacing.md, 18);
      expect(extension.colors.primary, const Color(0xFF7C3AED));
    });
  });
}
