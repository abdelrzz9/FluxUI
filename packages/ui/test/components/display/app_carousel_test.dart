import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppCarousel', () {
    testWidgets('navigates between slides and reports page changes', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      try {
        int? changedIndex;

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light(),
            home: Scaffold(
              body: AppCarousel(
                height: 220,
                onChanged: (index) => changedIndex = index,
                children: const <Widget>[
                  ColoredBox(
                    color: Colors.blue,
                    child: Center(child: Text('First slide')),
                  ),
                  ColoredBox(
                    color: Colors.green,
                    child: Center(child: Text('Second slide')),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('First slide'), findsOneWidget);

        await tester.tap(find.bySemanticsLabel('Next slide'));
        await tester.pumpAndSettle();

        expect(changedIndex, 1);
        expect(find.text('Second slide'), findsOneWidget);
      } finally {
        semantics.dispose();
      }
    });
  });
}
