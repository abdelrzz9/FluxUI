import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppSwitch', () {
    testWidgets('renders copy and toggles when the row is tapped',
        (tester) async {
      bool? nextValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppSwitch(
              value: true,
              label: 'Release notifications',
              description: 'Notify the team when FluxUI updates land.',
              onChanged: (value) => nextValue = value,
            ),
          ),
        ),
      );

      expect(find.text('Release notifications'), findsOneWidget);
      expect(find.text('Notify the team when FluxUI updates land.'),
          findsOneWidget);

      await tester.tap(find.text('Release notifications'));
      await tester.pump();

      expect(nextValue, isFalse);
    });
  });
}
