import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_utils/index.dart';

void main() {
  group('AppResponsiveValue', () {
    test('falls back through the scale when larger breakpoints are omitted',
        () {
      const value = AppResponsiveValue<String>(
        compact: 'compact',
        medium: 'medium',
      );

      expect(value.resolveForWindowSize(AppWindowSize.compact), 'compact');
      expect(value.resolveForWindowSize(AppWindowSize.medium), 'medium');
      expect(value.resolveForWindowSize(AppWindowSize.expanded), 'medium');
      expect(value.resolveForWindowSize(AppWindowSize.large), 'medium');
    });

    testWidgets(
        'context extensions expose width, window size, and responsive picks', (
      tester,
    ) async {
      late double width;
      late AppWindowSize windowSize;
      late String selected;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(720, 900)),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                width = context.screenWidth;
                windowSize = context.windowSize;
                selected = context.responsive<String>(
                  compact: 'compact',
                  medium: 'medium',
                  expanded: 'expanded',
                );

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      expect(width, 720);
      expect(windowSize, AppWindowSize.medium);
      expect(selected, 'medium');
    });
  });
}
