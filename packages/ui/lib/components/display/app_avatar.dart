import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

enum AppAvatarSize { xs, sm, md, lg, xl }

enum AppAvatarShape { circle, rounded }

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = AppAvatarSize.md,
    this.shape = AppAvatarShape.circle,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final AppAvatarSize size;
  final AppAvatarShape shape;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final sizeStyle = _AppAvatarSizeStyle.resolve(context, size);
    final resolvedBg = backgroundColor ?? colors.primaryContainer;
    final resolvedFg = foregroundColor ?? colors.onPrimaryContainer;
    final radius = shape == AppAvatarShape.circle
        ? sizeStyle.dimension / 2
        : context.appRadius.md;
    final borderWidth = spacing.xxxs;

    final inner = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox.square(
        dimension: sizeStyle.dimension,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    _buildFallback(resolvedBg, resolvedFg, sizeStyle),
                loadingBuilder: (_, child, progress) => progress == null
                    ? child
                    : ColoredBox(color: colors.surfaceMuted),
              )
            : _buildFallback(resolvedBg, resolvedFg, sizeStyle),
      ),
    );

    final Widget avatar = borderColor == null
        ? inner
        : Container(
            width: sizeStyle.dimension + borderWidth * 2,
            height: sizeStyle.dimension + borderWidth * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius + borderWidth),
              border: Border.all(color: borderColor!, width: borderWidth),
            ),
            child: inner,
          );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildFallback(
    Color bg,
    Color fg,
    _AppAvatarSizeStyle style,
  ) {
    final String? label;
    if (initials != null && initials!.trim().isNotEmpty) {
      final raw = initials!.trim().toUpperCase();
      label = raw.length > 2 ? raw.substring(0, 2) : raw;
    } else {
      label = null;
    }

    return ColoredBox(
      color: bg,
      child: Center(
        child: label != null
            ? Text(label, style: style.textStyle.copyWith(color: fg, height: 1))
            : Icon(icon ?? Icons.person_rounded,
                size: style.iconSize, color: fg),
      ),
    );
  }
}

class _AppAvatarSizeStyle {
  const _AppAvatarSizeStyle({
    required this.dimension,
    required this.iconSize,
    required this.textStyle,
  });

  final double dimension;
  final double iconSize;
  final TextStyle textStyle;

  static _AppAvatarSizeStyle resolve(BuildContext context, AppAvatarSize size) {
    final sizes = context.appSizes;
    final t = context.appTypography;

    return switch (size) {
      AppAvatarSize.xs => _AppAvatarSizeStyle(
          dimension: sizes.controlXs,
          iconSize: sizes.iconXs,
          textStyle: t.labelSmall,
        ),
      AppAvatarSize.sm => _AppAvatarSizeStyle(
          dimension: sizes.controlSm,
          iconSize: sizes.iconSm,
          textStyle: t.labelMedium,
        ),
      AppAvatarSize.md => _AppAvatarSizeStyle(
          dimension: sizes.controlMd,
          iconSize: sizes.iconMd,
          textStyle: t.labelLarge,
        ),
      AppAvatarSize.lg => _AppAvatarSizeStyle(
          dimension: sizes.controlLg,
          iconSize: sizes.iconLg,
          textStyle: t.titleSmall,
        ),
      AppAvatarSize.xl => _AppAvatarSizeStyle(
          dimension: sizes.controlXl,
          iconSize: sizes.iconXl,
          textStyle: t.titleMedium,
        ),
    };
  }
}
