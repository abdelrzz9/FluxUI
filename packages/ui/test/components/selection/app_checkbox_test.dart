import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppCheckbox', () {
    testWidgets('renders copy and toggles when the row is tapped',
        (tester) async {
      bool? nextValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppCheckbox(
              value: false,
              label: 'Include CLI templates',
              description:
                  'Keep generated templates aligned with package components.',
              onChanged: (value) => nextValue = value,
            ),
          ),
        ),
      );

      expect(find.text('Include CLI templates'), findsOneWidget);
      expect(
        find.text('Keep generated templates aligned with package components.'),
        findsOneWidget,
      );

      await tester.tap(find.text('Include CLI templates'));
      await tester.pump();

      expect(nextValue, isTrue);
    });

    testWidgets('supports tristate transitions', (tester) async {
      bool? nextValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppCheckbox(
              value: null,
              tristate: true,
              label: 'Optional state',
              onChanged: (value) => nextValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Optional state'));
      await tester.pump();

      expect(nextValue, isTrue);
    });
  });
}
