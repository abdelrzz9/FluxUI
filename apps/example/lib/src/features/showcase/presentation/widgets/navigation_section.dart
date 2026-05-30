import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../domain/models/release_tab_content.dart';
import '../../domain/models/showcase_navigation_item.dart';
import '../controllers/showcase_controller.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({
    super.key,
    required this.controller,
    required this.releaseTabs,
    required this.navigationItems,
  });

  final ShowcaseController controller;
  final List<ReleaseTabContent> releaseTabs;
  final List<ShowcaseNavigationItem> navigationItems;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppTabs(
          items: releaseTabs
              .map(
                (tab) => AppTabItem(
                  label: tab.label,
                  icon: tab.icon,
                  badgeLabel: tab.badgeLabel,
                  description: tab.description,
                ),
              )
              .toList(),
          selectedIndex: controller.selectedTabIndex,
          showPanel: true,
          onChanged: controller.updateSelectedTabIndex,
        ),
        AppNavigationMenu(
          items: navigationItems
              .map(
                (item) => AppNavigationMenuItem(
                  label: item.label,
                  icon: item.icon,
                  badgeLabel: item.badgeLabel,
                  description: item.description,
                ),
              )
              .toList(),
          selectedIndex: controller.selectedNavigationIndex,
          onChanged: controller.updateSelectedNavigationIndex,
        ),
        VStack(
          spacing: spacing.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppPagination(
              currentPage: controller.selectedPage,
              totalPages: 18,
              onPageChanged: controller.updateSelectedPage,
            ),
            AppText.body(
              controller.currentReleasePageLabel,
              variant: AppTextVariant.bodySmall,
              tone: AppTextTone.muted,
            ),
          ],
        ),
      ],
    );
  }
}
