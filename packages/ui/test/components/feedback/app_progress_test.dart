import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppProgress', () {
    testWidgets('linear variant renders label, description, and percentage', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppProgress(
              value: 0.72,
              label: 'Component rollout',
              description: 'The next release is bundling new primitives.',
            ),
          ),
        ),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );

      expect(indicator.value, 0.72);
      expect(indicator.minHeight, AppDesignTokens.light.spacing.xs);
      expect(find.text('Component rollout'), findsOneWidget);
      expect(find.text('72%'), findsOneWidget);
      expect(
        find.text('The next release is bundling new primitives.'),
        findsOneWidget,
      );
    });

    testWidgets('circular variant renders the circular indicator and value', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppProgress.circular(
              value: 0.5,
              label: 'Docs sync',
              size: AppProgressSize.sm,
            ),
          ),
        ),
      );

      final indicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );

      expect(indicator.value, 0.5);
      expect(find.text('Docs sync'), findsOneWidget);
      expect(find.text('50%'), findsOneWidget);
    });
  });
}
