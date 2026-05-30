import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppAlert.info(
          title: 'Registry sync ready',
          description:
              'FluxUI can generate package-backed components into your workspace with the current registry settings.',
          action: AppButton.ghost(
            text: 'Review',
            onPressed: () {},
          ),
        ),
        AppAlert.success(
          title: 'Release pipeline is healthy',
          description:
              'Tests, golden snapshots, and example verification all completed before publish.',
        ),
        AppCard.muted(
          child: VStack(
            spacing: spacing.md,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              AppProgress(
                value: 0.72,
                label: 'Component rollout',
                description:
                    'The next release is bundling feedback and display primitives.',
              ),
              AppProgress.circular(
                value: 0.88,
                label: 'Docs sync',
                description:
                    'API examples and showcase content are almost aligned.',
                size: AppProgressSize.sm,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
