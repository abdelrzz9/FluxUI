import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppTabs', () {
    testWidgets('shows the selected panel and forwards tab changes',
        (tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppTabs(
              selectedIndex: 0,
              showPanel: true,
              onChanged: (index) => selectedIndex = index,
              items: const <AppTabItem>[
                AppTabItem(
                  label: 'Overview',
                  description: 'Overview panel',
                ),
                AppTabItem(
                  label: 'Components',
                  description: 'Component panel',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Overview panel'), findsOneWidget);

      await tester.tap(find.text('Components'));
      await tester.pump();

      expect(selectedIndex, 1);
    });

    testWidgets('disabled tabs do not trigger selection changes',
        (tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppTabs(
              selectedIndex: 0,
              onChanged: (_) => callCount += 1,
              items: const <AppTabItem>[
                AppTabItem(label: 'Overview'),
                AppTabItem(
                  label: 'Disabled',
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pump();

      expect(callCount, 0);
    });
  });
}
