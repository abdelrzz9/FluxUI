import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_tokens/index.dart';

void main() {
  group('AppDesignTokens defaults', () {
    test('light and dark presets expose distinct semantic surfaces', () {
      expect(AppDesignTokens.light.colors.background,
          isNot(equals(AppDesignTokens.dark.colors.background)));
      expect(AppDesignTokens.light.colors.onSurface,
          isNot(equals(AppDesignTokens.dark.colors.onSurface)));
    });

    test('spacing scale is ordered from tightest to loosest', () {
      const spacing = AppSpacingTokens.regular;

      expect(spacing.none, lessThanOrEqualTo(spacing.xxxs));
      expect(spacing.xxxs, lessThan(spacing.xxs));
      expect(spacing.xxs, lessThan(spacing.xs));
      expect(spacing.xs, lessThan(spacing.sm));
      expect(spacing.sm, lessThan(spacing.md));
      expect(spacing.md, lessThan(spacing.lg));
      expect(spacing.lg, lessThan(spacing.xl));
      expect(spacing.xl, lessThan(spacing.x2l));
      expect(spacing.x2l, lessThan(spacing.x3l));
      expect(spacing.x3l, lessThan(spacing.x4l));
      expect(spacing.x4l, lessThan(spacing.x5l));
    });

    test('component sizes stay aligned with the spacing rhythm', () {
      const sizes = AppSizeTokens.regular;
      const spacing = AppSpacingTokens.regular;

      expect(sizes.controlSm, greaterThan(spacing.md));
      expect(sizes.controlMd, greaterThan(sizes.controlSm));
      expect(sizes.controlLg, greaterThan(sizes.controlMd));
    });
  });
}
