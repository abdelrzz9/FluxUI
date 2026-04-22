import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppOtpField', () {
    testWidgets('distributes pasted input and notifies completion',
        (tester) async {
      String? latestValue;
      String? completedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppOtpField(
              length: 4,
              onChanged: (value) => latestValue = value,
              onCompleted: (value) => completedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '1234');
      await tester.pumpAndSettle();

      final firstField = tester.widget<TextField>(find.byType(TextField).at(0));
      final lastField = tester.widget<TextField>(find.byType(TextField).at(3));

      expect(firstField.controller?.text, '1');
      expect(lastField.controller?.text, '4');
      expect(latestValue, '1234');
      expect(completedValue, '1234');
    });

    testWidgets('initialValue populates the segmented fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppOtpField(
              length: 4,
              initialValue: '42',
            ),
          ),
        ),
      );

      final firstField = tester.widget<TextField>(find.byType(TextField).at(0));
      final secondField =
          tester.widget<TextField>(find.byType(TextField).at(1));
      final thirdField = tester.widget<TextField>(find.byType(TextField).at(2));

      expect(firstField.controller?.text, '4');
      expect(secondField.controller?.text, '2');
      expect(thirdField.controller?.text, '');
    });
  });
}
