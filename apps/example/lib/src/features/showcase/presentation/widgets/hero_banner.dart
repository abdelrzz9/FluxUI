import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return AppCard(
      child: VStack(
        spacing: spacing.lg,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HStack(
            spacing: spacing.md,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: VStack(
                  spacing: spacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    AppText.display('FluxUI'),
                    AppText.body(
                      'Package-driven theme, copy-pasteable components, and a CLI that turns primitives into local code.',
                      tone: AppTextTone.muted,
                    ),
                  ],
                ),
              ),
              AppButton.outline(
                text: isDarkMode ? 'Light mode' : 'Dark mode',
                onPressed: onToggleTheme,
              ),
            ],
          ),
          HStack(
            spacing: spacing.sm,
            children: <Widget>[
              const AppButton.primary(text: 'Install package'),
              AppButton.ghost(
                text: 'Generate locally',
                onPressed: onToggleTheme,
              ),
            ],
          ),
          AppText.label(
            'Tokens • ThemeExtensions • Fluent extensions • CLI',
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
    ).shadow(color: colors.shadow, blurRadius: 24, offset: const Offset(0, 12));
  }
}
