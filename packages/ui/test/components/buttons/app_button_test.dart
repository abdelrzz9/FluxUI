import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppButton', () {
    testWidgets(
        'primary constructor renders token-driven surface and handles taps', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppButton.primary(
              text: 'Login',
              onPressed: () => tapped += 1,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(
        find.descendant(
          of: find.byType(AppButton),
          matching: find.byType(Ink),
        ),
      );
      final decoration = ink.decoration! as BoxDecoration;

      expect(decoration.color, AppDesignTokens.light.colors.primary);

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(tapped, 1);
    });

    testWidgets(
        'outline loading state disables taps and shows a progress indicator', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppButton.outline(
              text: 'Save',
              isLoading: true,
              onPressed: () => tapped += 1,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(
        find.descendant(
          of: find.byType(AppButton),
          matching: find.byType(Ink),
        ),
      );
      final decoration = ink.decoration! as BoxDecoration;

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(decoration.color, AppDesignTokens.light.colors.disabled);
      expect(
          decoration.border?.top.color, AppDesignTokens.light.colors.disabled);

      await tester.tap(find.byType(AppButton));
      await tester.pump();

      expect(tapped, 0);
    });
  });
}
