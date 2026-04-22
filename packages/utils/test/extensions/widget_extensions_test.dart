import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_utils/index.dart';

void main() {
  testWidgets('padding and center produce a readable widget chain', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const Text('Hello').padding(16).center(),
      ),
    );

    final padding = tester.widget<Padding>(find.byType(Padding));
    final center = tester.widget<Center>(find.byType(Center));

    expect((padding.padding as EdgeInsets).left, 16);
    expect(center.child, isA<Padding>());
  });

  testWidgets('rounded and shadow merge into a single decorated surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: const SizedBox(width: 40, height: 40)
            .rounded(12)
            .shadow()
            .background(Colors.white),
      ),
    );

    final decoratedBox = tester.widget<DecoratedBox>(find.byType(DecoratedBox));
    final clip = tester.widget<ClipRRect>(find.byType(ClipRRect));
    final decoration = decoratedBox.decoration as BoxDecoration;

    expect(find.byType(DecoratedBox), findsOneWidget);
    expect(decoration.borderRadius, BorderRadius.circular(12));
    expect(decoration.boxShadow, isNotEmpty);
    expect(decoration.color, Colors.white);
    expect(clip.borderRadius, BorderRadius.circular(12));
  });
}
