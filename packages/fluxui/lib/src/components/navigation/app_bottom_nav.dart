import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

@immutable
class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeLabel,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String? badgeLabel;
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onChanged,
  })  : assert(items.length >= 2, 'At least 2 items are required.'),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex must be within the item range.',
        );

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.border, width: spacing.xxxs / 2),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: spacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(items.length, (index) {
              final item = items[index];
              final isActive = index == currentIndex;
              final fg = isActive ? colors.primary : colors.onSurfaceMuted;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onChanged != null ? () => onChanged!(index) : null,
                    borderRadius: BorderRadius.circular(context.appRadius.md),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: spacing.xs),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Icon(
                                isActive
                                    ? (item.activeIcon ?? item.icon)
                                    : item.icon,
                                size: context.appSizes.iconMd,
                                color: fg,
                              ),
                              if (item.badgeLabel != null)
                                Positioned(
                                  top: -spacing.xxs,
                                  right: -spacing.xs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spacing.xxxs + 1,
                                      vertical: spacing.xxxs / 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.error,
                                      borderRadius: BorderRadius.circular(
                                        context.appRadius.pill,
                                      ),
                                      border: Border.all(
                                        color: colors.surface,
                                        width: spacing.xxxs / 2,
                                      ),
                                    ),
                                    child: Text(
                                      item.badgeLabel!,
                                      style: typography.labelSmall.copyWith(
                                        color: colors.onPrimary,
                                        fontSize: 9,
                                        height: 1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spacing.xxs),
                          Text(
                            item.label,
                            style: typography.labelSmall.copyWith(
                              color: fg,
                              fontWeight:
                                  isActive ? FontWeight.w700 : FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
