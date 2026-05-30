import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText.title(title),
        AppText.body(description, tone: AppTextTone.muted),
        child,
      ],
    );
  }
}
