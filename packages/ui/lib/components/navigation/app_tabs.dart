import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';

@immutable
class AppTabItem {
  const AppTabItem({
    required this.label,
    this.icon,
    this.description,
    this.badgeLabel,
    this.panel,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final String? description;
  final String? badgeLabel;
  final Widget? panel;
  final bool enabled;
}

class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showPanel = false,
  })  : assert(items.length > 0, 'items must not be empty.'),
        assert(
          selectedIndex >= 0 && selectedIndex < items.length,
          'selectedIndex must stay within the item range.',
        );

  final List<AppTabItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final bool showPanel;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final selectedItem = items[selectedIndex];
    final shouldShowPanel = showPanel ||
        items.any((item) => item.panel != null || item.description != null);

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppCard.outlined(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(items.length, (index) {
                final item = items[index];

                return _AppTabTrigger(
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
        ),
        if (shouldShowPanel)
          AppCard.muted(
            child: selectedItem.panel ?? _AppTabPanel(item: selectedItem),
          ),
      ],
    );
  }
}

class _AppTabTrigger extends StatelessWidget {
  const _AppTabTrigger({
    required this.item,
    required this.isSelected,
    required this.showDivider,
    required this.onTap,
  });

  final AppTabItem item;
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
              vertical: spacing.sm,
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
                  _AppTabsBadge(
                    label: badge,
                    isSelected: isSelected,
                    enabled: item.enabled,
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

class _AppTabPanel extends StatelessWidget {
  const _AppTabPanel({
    required this.item,
  });

  final AppTabItem item;

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

class _AppTabsBadge extends StatelessWidget {
  const _AppTabsBadge({
    required this.label,
    required this.isSelected,
    required this.enabled,
  });

  final String label;
  final bool isSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = !enabled
        ? colors.disabledForeground
        : isSelected
            ? colors.primary
            : colors.onSurfaceMuted;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryContainer : colors.surfaceMuted,
        borderRadius: BorderRadius.circular(context.appRadius.pill),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xs,
          vertical: spacing.xxxs,
        ),
        child: AppText.label(
          label,
          variant: AppTextVariant.labelSmall,
          color: foreground,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
