import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppCard', () {
    testWidgets(
        'default constructor applies token-based padding and surface color', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppCard(
              child: Text('Card body'),
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(
        find.descendant(
          of: find.byType(AppCard),
          matching: find.byType(Ink),
        ),
      );
      final padding = tester.widget<Padding>(
        find
            .ancestor(
              of: find.text('Card body'),
              matching: find.byType(Padding),
            )
            .first,
      );
      final decoration = ink.decoration! as BoxDecoration;

      expect((padding.padding as EdgeInsets).left,
          AppDesignTokens.light.spacing.lg);
      expect(decoration.color, AppDesignTokens.light.colors.surface);
      expect(decoration.border?.top.color, AppDesignTokens.light.colors.border);
    });

    testWidgets('outlined constructor keeps interactivity opt-in',
        (tester) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppCard.outlined(
              onTap: () => tapped += 1,
              child: const Text('Settings'),
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(
        find.descendant(
          of: find.byType(AppCard),
          matching: find.byType(Ink),
        ),
      );
      final decoration = ink.decoration! as BoxDecoration;

      expect(decoration.border?.top.color,
          AppDesignTokens.light.colors.borderStrong);

      await tester.tap(find.text('Settings'));
      await tester.pump();

      expect(tapped, 1);
    });
  });
}
