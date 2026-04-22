import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppCombobox', () {
    testWidgets('opens the option sheet and forwards selections',
        (tester) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppCombobox(
              labelText: 'Registry',
              hintText: 'Select a registry',
              options: const <AppComboboxOption>[
                AppComboboxOption(value: 'core', label: 'Core registry'),
                AppComboboxOption(value: 'labs', label: 'Labs registry'),
              ],
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Select a registry'));
      await tester.pumpAndSettle();

      expect(find.text('Core registry'), findsOneWidget);

      await tester.tap(find.text('Labs registry'));
      await tester.pumpAndSettle();

      expect(selectedValue, 'labs');
    });

    testWidgets('filters options and shows an empty state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppCombobox(
              hintText: 'Select a registry',
              options: const <AppComboboxOption>[
                AppComboboxOption(value: 'core', label: 'Core registry'),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('Select a registry'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'missing');
      await tester.pumpAndSettle();

      expect(find.text('No results found.'), findsOneWidget);
    });
  });
}
