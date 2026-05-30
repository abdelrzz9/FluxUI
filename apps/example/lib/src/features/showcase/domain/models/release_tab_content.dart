import 'showcase_icon.dart';

class ReleaseTabContent {
  const ReleaseTabContent({
    required this.label,
    required this.icon,
    required this.description,
    this.badgeLabel,
  });

  final String label;
  final ShowcaseIcon icon;
  final String description;
  final String? badgeLabel;
}
