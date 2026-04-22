import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

enum AppCardVariant {
  surface,
  outline,
  muted,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.surface,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  });

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.outline;

  const AppCard.muted({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.muted;

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final radius = BorderRadius.circular(borderRadius ?? context.appRadius.lg);
    final borderWidth = spacing.xxxs / 2;
    final resolvedPadding = padding ?? EdgeInsets.all(spacing.lg);
    final surfaceColor = switch (variant) {
      AppCardVariant.surface => colors.surface,
      AppCardVariant.outline => colors.surface,
      AppCardVariant.muted => colors.surfaceMuted,
    };
    final borderColor = switch (variant) {
      AppCardVariant.surface => colors.border,
      AppCardVariant.outline => colors.borderStrong,
      AppCardVariant.muted => colors.border,
    };
    final content = Padding(
      padding: resolvedPadding,
      child: child,
    );

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        clipBehavior: clipBehavior,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: Ink(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: radius,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child: onTap == null
              ? content
              : InkWell(
                  onTap: onTap,
                  borderRadius: radius,
                  child: content,
                ),
        ),
      ),
    );
  }
}
