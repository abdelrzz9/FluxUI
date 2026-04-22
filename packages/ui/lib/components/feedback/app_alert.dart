import 'package:flutter/material.dart';
import 'package:flutter_ui_tokens/index.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

enum AppAlertVariant {
  info,
  success,
  warning,
  danger,
  neutral,
}

class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
    this.variant = AppAlertVariant.info,
  });

  const AppAlert.info({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.info;

  const AppAlert.success({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.success;

  const AppAlert.warning({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.warning;

  const AppAlert.danger({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.danger;

  const AppAlert.neutral({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.neutral;

  final String title;
  final String? description;
  final Widget? action;
  final Widget? child;
  final IconData? icon;
  final AppAlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final style = _AppAlertStyle.resolve(colors, variant);
    final radius = BorderRadius.circular(context.appRadius.lg);
    final borderWidth = spacing.xxxs / 2;
    final resolvedIcon = icon ?? style.icon;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: style.background,
          borderRadius: radius,
          border: Border.all(
            color: style.border,
            width: borderWidth,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: style.iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spacing.xs),
                  child: Icon(
                    resolvedIcon,
                    size: context.appSizes.iconSm,
                    color: style.foreground,
                  ),
                ),
              ),
              SizedBox(width: spacing.md),
              Expanded(
                child: VStack(
                  spacing: spacing.xs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText.title(
                      title,
                      variant: AppTextVariant.titleMedium,
                      color: colors.onSurface,
                    ),
                    if (description != null)
                      AppText.body(
                        description!,
                        tone: AppTextTone.muted,
                      ),
                    if (child != null) child!,
                  ],
                ),
              ),
              if (action != null) ...[
                SizedBox(width: spacing.md),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AppAlertStyle {
  const _AppAlertStyle({
    required this.foreground,
    required this.background,
    required this.iconBackground,
    required this.border,
    required this.icon,
  });

  final Color foreground;
  final Color background;
  final Color iconBackground;
  final Color border;
  final IconData icon;

  static _AppAlertStyle resolve(
    AppColorTokens colors,
    AppAlertVariant variant,
  ) {
    return switch (variant) {
      AppAlertVariant.info => _AppAlertStyle(
          foreground: colors.info,
          background: Color.lerp(colors.surface, colors.info, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.info, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.info, 0.32)!,
          icon: Icons.info_outline_rounded,
        ),
      AppAlertVariant.success => _AppAlertStyle(
          foreground: colors.success,
          background: Color.lerp(colors.surface, colors.success, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.success, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.success, 0.32)!,
          icon: Icons.check_circle_outline_rounded,
        ),
      AppAlertVariant.warning => _AppAlertStyle(
          foreground: colors.warning,
          background: Color.lerp(colors.surface, colors.warning, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.warning, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.warning, 0.32)!,
          icon: Icons.warning_amber_rounded,
        ),
      AppAlertVariant.danger => _AppAlertStyle(
          foreground: colors.error,
          background: Color.lerp(colors.surface, colors.error, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.error, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.error, 0.32)!,
          icon: Icons.error_outline_rounded,
        ),
      AppAlertVariant.neutral => _AppAlertStyle(
          foreground: colors.secondary,
          background: colors.surfaceMuted,
          iconBackground:
              Color.lerp(colors.surface, colors.secondaryContainer, 0.72)!,
          border: colors.borderStrong,
          icon: Icons.notifications_none_rounded,
        ),
    };
  }
}
