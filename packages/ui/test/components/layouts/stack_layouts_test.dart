import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('Stack layouts', () {
    testWidgets('HStack inserts horizontal gaps between children', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: HStack(
            spacing: 12,
            children: <Widget>[
              Text('One'),
              Text('Two'),
              Text('Three'),
            ],
          ),
        ),
      );

      final row = tester.widget<Row>(find.byType(Row));
      final gaps = tester.widgetList<Gap>(find.byType(Gap)).toList();

      expect(row.mainAxisSize, MainAxisSize.min);
      expect(gaps.length, 2);
      expect(gaps.first.axis, Axis.horizontal);
      expect(gaps.first.size, 12);
    });

    testWidgets('VStack defaults to start alignment and vertical gaps', (
      tester,
    ) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: VStack(
            spacing: 8,
            children: <Widget>[
              Text('A'),
              Text('B'),
            ],
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column));
      final gap = tester.widget<Gap>(find.byType(Gap));

      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
      expect(gap.axis, Axis.vertical);
      expect(gap.size, 8);
    });
  });
}
