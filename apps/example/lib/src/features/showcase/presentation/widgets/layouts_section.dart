import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import 'color_swatch.dart';

class LayoutsSection extends StatelessWidget {
  const LayoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return AppCard.muted(
      child: VStack(
        spacing: spacing.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HStack(
            spacing: spacing.sm,
            children: <Widget>[
              ColorSwatch(color: colors.primary, label: 'Primary'),
              ColorSwatch(
                color: colors.secondaryContainer,
                label: 'Secondary',
              ),
              ColorSwatch(
                color: colors.surfaceMuted,
                label: 'Muted',
              ),
            ],
          ),
          HStack(
            spacing: spacing.sm,
            children: <Widget>[
              const AppText.body('Breakpoint'),
              AppText.label(
                context.windowSize.name,
                tone: AppTextTone.primary,
              )
                  .paddingSymmetric(
                    horizontal: spacing.sm,
                    vertical: spacing.xs,
                  )
                  .background(
                    colors.primaryContainer,
                    radius: context.appRadius.pill,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
