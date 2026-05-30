import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class TypographySection extends StatelessWidget {
  const TypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return AppCard(
      child: VStack(
        spacing: spacing.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          AppText.display('Design system'),
          AppText.headline('Reusable primitives'),
          AppText.title('Production-grade Flutter UI'),
          AppText.body(
            'Use the package directly or copy generated files into your app with the CLI.',
          ),
          AppText.label(
            'Muted helper copy',
            tone: AppTextTone.muted,
          ),
        ],
      ),
    );
  }
}
