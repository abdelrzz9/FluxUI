import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.leading,
    this.enabled = true,
  })  : _removable = false,
        onRemoved = null;

  const AppChip.removable({
    super.key,
    required this.label,
    this.selected = false,
    this.onSelected,
    this.onRemoved,
    this.leading,
    this.enabled = true,
  }) : _removable = true;

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onRemoved;
  final Widget? leading;
  final bool enabled;
  final bool _removable;

  bool get _isInteractive => enabled && onSelected != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final radius = BorderRadius.circular(context.appRadius.pill);
    final borderWidth = spacing.xxxs / 2;

    final Color bg;
    final Color fg;
    final Color border;

    if (!enabled) {
      bg = colors.surfaceMuted;
      fg = colors.disabledForeground;
      border = colors.disabled;
    } else if (selected) {
      bg = colors.primaryContainer;
      fg = colors.primary;
      border = Color.lerp(colors.borderStrong, colors.primary, 0.4)!;
    } else {
      bg = colors.surface;
      fg = colors.onSurface;
      border = colors.borderStrong;
    }

    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.xxs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (leading != null) ...<Widget>[
            IconTheme.merge(
              data: IconThemeData(
                size: context.appSizes.iconSm,
                color: fg,
              ),
              child: leading!,
            ),
            SizedBox(width: spacing.xxs),
          ],
          Text(
            label,
            style: typography.labelMedium.copyWith(
              color: fg,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          if (_removable && onRemoved != null) ...<Widget>[
            SizedBox(width: spacing.xxs),
            GestureDetector(
              onTap: enabled ? onRemoved : null,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.close_rounded,
                size: context.appSizes.iconXs,
                color: fg,
              ),
            ),
          ],
        ],
      ),
    );

    return Semantics(
      button: _isInteractive,
      selected: selected,
      enabled: enabled,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
            border: Border.all(color: border, width: borderWidth),
          ),
          child: InkWell(
            onTap: _isInteractive ? () => onSelected!(!selected) : null,
            borderRadius: radius,
            child: content,
          ),
        ),
      ),
    );
  }
}
