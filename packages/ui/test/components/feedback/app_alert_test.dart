import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppAlert', () {
    testWidgets('info variant renders content and forwards action taps', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppAlert.info(
              title: 'Registry sync ready',
              description: 'The workspace can pull package-backed components.',
              action: AppButton.ghost(
                text: 'Review',
                onPressed: () => tapped += 1,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Registry sync ready'), findsOneWidget);
      expect(
        find.text('The workspace can pull package-backed components.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.info_outline_rounded), findsOneWidget);

      await tester.tap(find.text('Review'));
      await tester.pump();

      expect(tapped, 1);
    });

    testWidgets('warning constructor uses the warning icon by default', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppAlert.warning(
              title: 'Review pending changes',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      expect(find.text('Review pending changes'), findsOneWidget);
    });
  });
}
