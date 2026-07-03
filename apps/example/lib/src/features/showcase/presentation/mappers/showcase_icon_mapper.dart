import 'package:flutter/material.dart';

import '../../domain/models/showcase_icon.dart';

extension ShowcaseIconMapper on ShowcaseIcon {
  IconData get iconData {
    switch (this) {
      case ShowcaseIcon.dashboard:
        return Icons.dashboard_customize_outlined;
      case ShowcaseIcon.widgets:
        return Icons.widgets_outlined;
      case ShowcaseIcon.terminal:
        return Icons.terminal_rounded;
      case ShowcaseIcon.docs:
        return Icons.menu_book_outlined;
      case ShowcaseIcon.registry:
        return Icons.inventory_2_outlined;
      case ShowcaseIcon.releases:
        return Icons.rocket_launch_outlined;
    }
  }
}
