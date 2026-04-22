import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppText', () {
    testWidgets('title constructor resolves typography from the theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppText.title('Dashboard'),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Dashboard'));

      expect(text.style?.fontSize,
          AppDesignTokens.light.typography.titleLarge.fontSize);
      expect(text.style?.fontWeight,
          AppDesignTokens.light.typography.titleLarge.fontWeight);
      expect(text.style?.color, AppDesignTokens.light.colors.onSurface);
    });

    testWidgets('tone overrides semantic foreground color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppText.body(
              'Muted copy',
              tone: AppTextTone.muted,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Muted copy'));

      expect(text.style?.color, AppDesignTokens.light.colors.onSurfaceMuted);
    });
  });
}
