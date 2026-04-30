import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';

@immutable
class AppNavigationMenuItem {
  const AppNavigationMenuItem({
    required this.label,
    this.icon,
    this.description,
    this.badgeLabel,
    this.child,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final String? description;
  final String? badgeLabel;
  final Widget? child;
  final bool enabled;
}

class AppNavigationMenu extends StatelessWidget {
  const AppNavigationMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
  })  : assert(items.length > 0, 'items must not be empty.'),
        assert(
          selectedIndex >= 0 && selectedIndex < items.length,
          'selectedIndex must stay within the item range.',
        );

  final List<AppNavigationMenuItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final selectedItem = items[selectedIndex];

    return AppCard.outlined(
      padding: EdgeInsets.zero,
      child: VStack(
        spacing: spacing.none,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(items.length, (index) {
                final item = items[index];

                return _AppNavigationMenuTrigger(
                  item: item,
                  isSelected: index == selectedIndex,
                  showDivider: index != items.length - 1,
                  onTap: item.enabled && onChanged != null
                      ? () => onChanged!(index)
                      : null,
                );
              }),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: context.appColors.border,
          ),
          Padding(
            padding: EdgeInsets.all(spacing.lg),
            child: selectedItem.child ??
                _AppNavigationMenuPanel(item: selectedItem),
          ),
        ],
      ),
    );
  }
}

class _AppNavigationMenuTrigger extends StatelessWidget {
  const _AppNavigationMenuTrigger({
    required this.item,
    required this.isSelected,
    required this.showDivider,
    required this.onTap,
  });

  final AppNavigationMenuItem item;
  final bool isSelected;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = item.enabled
        ? (isSelected ? colors.primary : colors.onSurface)
        : colors.disabledForeground;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceMuted : colors.surface,
          border: showDivider
              ? Border(
                  right: BorderSide(
                    color: colors.border,
                    width: spacing.xxxs / 2,
                  ),
                )
              : null,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.md,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (item.icon != null) ...[
                  Icon(item.icon,
                      size: context.appSizes.iconSm, color: foreground),
                  SizedBox(width: spacing.xs),
                ],
                AppText.label(
                  item.label,
                  color: foreground,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                if (item.badgeLabel case final String badge) ...[
                  SizedBox(width: spacing.xs),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primaryContainer
                          : colors.surfaceMuted,
                      borderRadius:
                          BorderRadius.circular(context.appRadius.pill),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.xs,
                        vertical: spacing.xxxs,
                      ),
                      child: AppText.label(
                        badge,
                        variant: AppTextVariant.labelSmall,
                        color: foreground,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppNavigationMenuPanel extends StatelessWidget {
  const _AppNavigationMenuPanel({
    required this.item,
  });

  final AppNavigationMenuItem item;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText.title(
          item.label,
          variant: AppTextVariant.titleMedium,
        ),
        if (item.description != null)
          AppText.body(
            item.description!,
            tone: AppTextTone.muted,
          ),
      ],
    );
  }
}
