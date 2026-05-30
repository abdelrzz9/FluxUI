import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class ColorSwatch extends StatelessWidget {
  const ColorSwatch({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      children: <Widget>[
        const SizedBox(width: 56, height: 56)
            .background(color, radius: context.appRadius.md)
            .border(
              color: context.appColors.border,
              radius: context.appRadius.md,
            ),
        AppText.label(label, tone: AppTextTone.muted),
      ],
    );
  }
}
