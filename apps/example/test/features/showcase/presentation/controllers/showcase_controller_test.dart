import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_example/src/features/showcase/presentation/controllers/showcase_controller.dart';
import 'package:flutter_ui_example/src/features/showcase/presentation/state/showcase_state.dart';

void main() {
  group('ShowcaseController', () {
    test('starts with the expected default state', () {
      final controller = ShowcaseController();
      addTearDown(controller.dispose);

      expect(controller.state.selectedRegistry, 'core');
      expect(controller.state.selectedPage, 6);
      expect(controller.state.notificationsEnabled, isTrue);
      expect(controller.state.includeCliTemplates, isTrue);
      expect(controller.otpHelperText, contains('Paste a 6-character code'));
    });

    test('updates immutable state and notifies listeners once', () {
      final controller = ShowcaseController();
      addTearDown(controller.dispose);
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.updateSelectedRegistry('labs');

      expect(controller.state.selectedRegistry, 'labs');
      expect(notifications, 1);
    });

    test('does not notify listeners when the next state is unchanged', () {
      final controller = ShowcaseController(
        initialState: const ShowcaseState(selectedRegistry: 'core'),
      );
      addTearDown(controller.dispose);
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.updateSelectedRegistry('core');

      expect(notifications, 0);
    });
  });
}
