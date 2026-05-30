import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      children: const <Widget>[
        AppButton.primary(text: 'Primary'),
        AppButton.secondary(text: 'Secondary'),
        AppButton.outline(text: 'Outline'),
        AppButton.ghost(text: 'Ghost'),
        AppButton.primary(
          text: 'Loading',
          isLoading: true,
        ),
      ],
    );
  }
}
