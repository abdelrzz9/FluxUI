import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../domain/models/registry_option.dart';
import '../controllers/showcase_controller.dart';

class InputsSection extends StatelessWidget {
  const InputsSection({
    super.key,
    required this.controller,
    required this.registryOptions,
  });

  final ShowcaseController controller;
  final List<RegistryOption> registryOptions;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppTextField.outline(
          controller: controller.searchController,
          labelText: 'Search',
          hintText: 'Search components',
          prefixIcon: const Icon(Icons.search),
        ),
        AppTextField.filled(
          controller: controller.emailController,
          labelText: 'Team email',
          helperText: 'Synced from your design system settings',
          prefixIcon: const Icon(Icons.mail_outline),
        ),
        AppCombobox(
          labelText: 'Registry',
          value: controller.selectedRegistry,
          helperText: 'Choose where FluxUI components should be generated from.',
          options: registryOptions
              .map(
                (option) => AppComboboxOption(
                  value: option.value,
                  label: option.label,
                  description: option.description,
                ),
              )
              .toList(),
          onChanged: controller.updateSelectedRegistry,
        ),
        VStack(
          spacing: spacing.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const AppText.label('Verification code'),
            AppOtpField(
              length: 6,
              onChanged: controller.updateOtpValue,
            ),
            AppText.body(
              controller.otpHelperText,
              variant: AppTextVariant.bodySmall,
              tone: AppTextTone.muted,
            ),
          ],
        ),
      ],
    );
  }
}
