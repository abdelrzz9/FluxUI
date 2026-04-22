import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('App theme context extensions', () {
    testWidgets('reads theme-backed tokens from BuildContext', (tester) async {
      late Color primary;
      late double spacingMd;
      late double radiusLg;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              primary = context.appColors.primary;
              spacingMd = context.appSpacing.md;
              radiusLg = context.appRadius.lg;

              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(primary, AppDesignTokens.light.colors.primary);
      expect(spacingMd, AppDesignTokens.light.spacing.md);
      expect(radiusLg, AppDesignTokens.light.radius.lg);
    });

    testWidgets(
        'falls back to brightness defaults when no AppTheme extension is installed',
        (
      tester,
    ) async {
      late Color primary;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: Builder(
            builder: (context) {
              primary = context.appColors.primary;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(primary, AppDesignTokens.dark.colors.primary);
    });
  });
}
