import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppPagination', () {
    testWidgets('renders page ranges with ellipses and forwards next actions', (
      tester,
    ) async {
      int? selectedPage;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppPagination(
              currentPage: 6,
              totalPages: 12,
              onPageChanged: (page) => selectedPage = page,
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('…'), findsAtLeastNWidgets(1));

      await tester.tap(find.text('Next'));
      await tester.pump();

      expect(selectedPage, 7);
    });

    testWidgets('keeps previous disabled on the first page', (tester) async {
      var callCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppPagination(
              currentPage: 1,
              totalPages: 4,
              onPageChanged: (_) => callCount += 1,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Previous'));
      await tester.pump();

      expect(callCount, 0);
    });
  });
}
