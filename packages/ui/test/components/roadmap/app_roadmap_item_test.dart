import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppRoadmapItem', () {
    testWidgets('renders title, badges, and metadata from the public API', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppRoadmapItem(
              title: 'Implement AppPagination component',
              categoryLabel: 'component',
              issueNumber: 16,
              owner: 'abdelrzz9',
              activityLabel: 'planned for the next release',
            ),
          ),
        ),
      );

      expect(find.text('Implement AppPagination component'), findsOneWidget);
      expect(find.text('Task'), findsOneWidget);
      expect(find.text('component'), findsOneWidget);
      expect(
        find.text('#16 • by abdelrzz9 • planned for the next release'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);
    });

    testWidgets('supports highlighted state, alternate status icons, and taps',
        (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppRoadmapItem(
              title: 'Implement AppTabs component',
              categoryLabel: 'component',
              issueNumber: 14,
              owner: 'abdelrzz9',
              activityLabel: 'in API review',
              state: AppRoadmapItemState.active,
              isHighlighted: true,
              onTap: () => tapped += 1,
            ),
          ),
        ),
      );

      final ink = tester.widget<Ink>(
        find.descendant(
          of: find.byType(AppRoadmapItem),
          matching: find.byType(Ink),
        ),
      );
      final decoration = ink.decoration! as BoxDecoration;

      expect(decoration.color, AppDesignTokens.light.colors.surfaceMuted);
      expect(find.byIcon(Icons.autorenew_rounded), findsOneWidget);

      await tester.tap(find.text('Implement AppTabs component'));
      await tester.pump();

      expect(tapped, 1);
    });
  });
}
