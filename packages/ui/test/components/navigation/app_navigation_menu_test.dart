import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppNavigationMenu', () {
    testWidgets('renders selected content and forwards menu changes',
        (tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppNavigationMenu(
              selectedIndex: 0,
              onChanged: (index) => selectedIndex = index,
              items: const <AppNavigationMenuItem>[
                AppNavigationMenuItem(
                  label: 'Docs',
                  description: 'Read the documentation.',
                ),
                AppNavigationMenuItem(
                  label: 'Registry',
                  badgeLabel: 'new',
                  description: 'Inspect the registered components.',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Read the documentation.'), findsOneWidget);
      expect(find.text('new'), findsOneWidget);

      await tester.tap(find.text('Registry'));
      await tester.pump();

      expect(selectedIndex, 1);
    });
  });
}
