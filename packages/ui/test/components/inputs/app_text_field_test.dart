import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  group('AppTextField', () {
    testWidgets(
        'filled variant maps token-driven decoration and forwards changes', (
      tester,
    ) async {
      String? value;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: AppTextField.filled(
              labelText: 'Email',
              hintText: 'you@example.com',
              onChanged: (next) => value = next,
            ),
          ),
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));
      final decoration = field.decoration!;
      final border = decoration.enabledBorder! as OutlineInputBorder;
      final padding = decoration.contentPadding! as EdgeInsets;

      expect(decoration.filled, isTrue);
      expect(decoration.fillColor, AppDesignTokens.light.colors.surfaceMuted);
      expect(border.borderRadius,
          BorderRadius.circular(AppDesignTokens.light.radius.md));
      expect(border.borderSide.color, AppDesignTokens.light.colors.border);
      expect(padding.left, AppDesignTokens.light.spacing.md);
      expect(padding.top, AppDesignTokens.light.spacing.sm);

      await tester.enterText(find.byType(TextField), 'a@b.com');

      expect(value, 'a@b.com');
    });

    testWidgets('outline variant keeps error text and disabled state visible', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            body: AppTextField.outline(
              enabled: false,
              errorText: 'Required field',
              helperText: 'Helper',
            ),
          ),
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));
      final decoration = field.decoration!;
      final disabledBorder = decoration.disabledBorder! as OutlineInputBorder;

      expect(field.enabled, isFalse);
      expect(decoration.filled, isFalse);
      expect(decoration.errorText, 'Required field');
      expect(disabledBorder.borderSide.color,
          AppDesignTokens.light.colors.disabled);
    });
  });
}
