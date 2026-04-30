import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

enum AppBadgeVariant { primary, success, warning, danger, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.child,
  }) : _dot = false;

  const AppBadge.dot({
    super.key,
    this.variant = AppBadgeVariant.danger,
    this.child,
  })  : label = null,
        _dot = true;

  final String? label;
  final AppBadgeVariant variant;
  final Widget? child;
  final bool _dot;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final style = _resolveBadgeStyle(context);
    final borderWidth = spacing.xxxs / 2;

    final badgeWidget = _dot
        ? Container(
            width: spacing.xs,
            height: spacing.xs,
            decoration: BoxDecoration(
              color: style.background,
              shape: BoxShape.circle,
              border: Border.all(color: colors.surface, width: borderWidth * 2),
            ),
          )
        : DecoratedBox(
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: BorderRadius.circular(context.appRadius.pill),
              border: Border.all(color: style.border, width: borderWidth),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.xs,
                vertical: spacing.xxxs,
              ),
              child: Text(
                label!,
                style: typography.labelSmall.copyWith(
                  color: style.foreground,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          );

    if (child == null) return badgeWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child!,
        Positioned(
          top: _dot ? -spacing.xxxs : -spacing.xxs,
          right: _dot ? -spacing.xxxs : -spacing.xs,
          child: badgeWidget,
        ),
      ],
    );
  }

  _BadgeStyle _resolveBadgeStyle(BuildContext context) {
    final colors = context.appColors;
    return switch (variant) {
      AppBadgeVariant.primary => _BadgeStyle(
          background: colors.primaryContainer,
          foreground: colors.primary,
          border: Color.lerp(colors.borderStrong, colors.primary, 0.32)!,
        ),
      AppBadgeVariant.success => _BadgeStyle(
          background: Color.lerp(colors.surface, colors.success, 0.12)!,
          foreground: colors.success,
          border: Color.lerp(colors.borderStrong, colors.success, 0.32)!,
        ),
      AppBadgeVariant.warning => _BadgeStyle(
          background: Color.lerp(colors.surface, colors.warning, 0.12)!,
          foreground: colors.warning,
          border: Color.lerp(colors.borderStrong, colors.warning, 0.32)!,
        ),
      AppBadgeVariant.danger => _BadgeStyle(
          background: Color.lerp(colors.surface, colors.error, 0.12)!,
          foreground: colors.error,
          border: Color.lerp(colors.borderStrong, colors.error, 0.32)!,
        ),
      AppBadgeVariant.neutral => _BadgeStyle(
          background: colors.surfaceMuted,
          foreground: colors.onSurfaceMuted,
          border: colors.borderStrong,
        ),
    };
  }
}

class _BadgeStyle {
  const _BadgeStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}
