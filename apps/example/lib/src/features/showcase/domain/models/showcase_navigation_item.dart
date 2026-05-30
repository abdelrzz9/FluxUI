import 'package:flutter/widgets.dart';

class ShowcaseNavigationItem {
  const ShowcaseNavigationItem({
    required this.label,
    required this.icon,
    required this.description,
    this.badgeLabel,
  });

  final String label;
  final IconData icon;
  final String description;
  final String? badgeLabel;
}
