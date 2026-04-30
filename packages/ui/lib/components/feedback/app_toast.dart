import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

enum AppToastVariant { info, success, warning, error, neutral }

abstract final class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    AppToastVariant variant = AppToastVariant.neutral,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: _AppToastContent(message: message, variant: variant),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          duration: duration,
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.zero,
        ),
      );
  }
}

class _AppToastContent extends StatelessWidget {
  const _AppToastContent({
    required this.message,
    required this.variant,
  });

  final String message;
  final AppToastVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final style = _resolveStyle(context);
    final borderWidth = spacing.xxxs / 2;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: style.background,
          borderRadius: BorderRadius.circular(context.appRadius.lg),
          border: Border.all(color: style.border, width: borderWidth),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: colors.shadow,
              blurRadius: spacing.md,
              offset: Offset(0, spacing.xxs),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.md,
            vertical: spacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                style.icon,
                size: context.appSizes.iconSm,
                color: style.foreground,
              ),
              SizedBox(width: spacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: typography.bodyMedium.copyWith(
                    color: style.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ToastStyle _resolveStyle(BuildContext context) {
    final colors = context.appColors;
    return switch (variant) {
      AppToastVariant.info => _ToastStyle(
          background: Color.lerp(colors.surface, colors.info, 0.08)!,
          foreground: colors.info,
          textColor: colors.onSurface,
          border: Color.lerp(colors.borderStrong, colors.info, 0.32)!,
          icon: Icons.info_outline_rounded,
        ),
      AppToastVariant.success => _ToastStyle(
          background: Color.lerp(colors.surface, colors.success, 0.08)!,
          foreground: colors.success,
          textColor: colors.onSurface,
          border: Color.lerp(colors.borderStrong, colors.success, 0.32)!,
          icon: Icons.check_circle_outline_rounded,
        ),
      AppToastVariant.warning => _ToastStyle(
          background: Color.lerp(colors.surface, colors.warning, 0.08)!,
          foreground: colors.warning,
          textColor: colors.onSurface,
          border: Color.lerp(colors.borderStrong, colors.warning, 0.32)!,
          icon: Icons.warning_amber_rounded,
        ),
      AppToastVariant.error => _ToastStyle(
          background: Color.lerp(colors.surface, colors.error, 0.08)!,
          foreground: colors.error,
          textColor: colors.onSurface,
          border: Color.lerp(colors.borderStrong, colors.error, 0.32)!,
          icon: Icons.error_outline_rounded,
        ),
      AppToastVariant.neutral => _ToastStyle(
          background: colors.surfaceInverse,
          foreground: colors.surface,
          textColor: colors.surface,
          border: colors.surfaceInverse,
          icon: Icons.notifications_none_rounded,
        ),
    };
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.background,
    required this.foreground,
    required this.textColor,
    required this.border,
    required this.icon,
  });

  final Color background;
  final Color foreground;
  final Color textColor;
  final Color border;
  final IconData icon;
}
