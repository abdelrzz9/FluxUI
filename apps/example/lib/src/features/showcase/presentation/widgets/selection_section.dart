import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../controllers/showcase_controller.dart';

class SelectionSection extends StatelessWidget {
  const SelectionSection({
    super.key,
    required this.controller,
  });

  final ShowcaseController controller;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return AppCard.muted(
      child: VStack(
        spacing: spacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppSwitch(
            value: controller.notificationsEnabled,
            label: 'Release notifications',
            description:
                'Send a heads-up when FluxUI ships new primitives or breaking changes.',
            onChanged: controller.updateNotificationsEnabled,
          ),
          Divider(
            height: spacing.md,
            thickness: 1,
            color: colors.border,
          ),
          AppCheckbox(
            value: controller.includeCliTemplates,
            label: 'Include CLI templates',
            description:
                'Keep `flux add` templates aligned with the package components you install.',
            onChanged: controller.updateIncludeCliTemplates,
          ),
        ],
      ),
    );
  }
}
