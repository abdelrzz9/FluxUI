import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.showDivider = true,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showDivider;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final resolvedBg = backgroundColor ?? colors.background;
    final resolvedFg = foregroundColor ?? colors.onBackground;

    final appBar = AppBar(
      title: Text(
        title,
        style: typography.titleLarge.copyWith(
          color: resolvedFg,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: leading,
      actions: actions,
      bottom: bottom,
      centerTitle: centerTitle,
      backgroundColor: resolvedBg,
      foregroundColor: resolvedFg,
      surfaceTintColor: resolvedBg,
      scrolledUnderElevation: 0,
      elevation: 0,
      iconTheme: IconThemeData(
        color: resolvedFg,
        size: context.appSizes.iconMd,
      ),
    );

    if (!showDivider) return appBar;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.border,
            width: spacing.xxxs / 2,
          ),
        ),
      ),
      child: appBar,
    );
  }
}
