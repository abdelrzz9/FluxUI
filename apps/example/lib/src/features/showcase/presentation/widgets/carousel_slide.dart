import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../domain/models/carousel_slide_content.dart';

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({
    super.key,
    required this.content,
  });

  final CarouselSlideContent content;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.lerp(colors.primaryContainer, colors.surface, 0.2)!,
            Color.lerp(colors.secondaryContainer, colors.surface, 0.08)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.xl),
        child: VStack(
          spacing: spacing.md,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText.label(
              content.eyebrow,
              tone: AppTextTone.primary,
            )
                .paddingSymmetric(
                  horizontal: spacing.sm,
                  vertical: spacing.xs,
                )
                .background(
                  colors.primaryContainer,
                  radius: context.appRadius.pill,
                ),
            AppText.display(
              content.title,
              variant: AppTextVariant.displaySmall,
            ),
            AppText.body(
              content.description,
              tone: AppTextTone.muted,
              style: const TextStyle(height: 1.45),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Icon(
                  Icons.rocket_launch_outlined,
                  size: context.appSizes.iconSm,
                  color: colors.primary,
                ),
                SizedBox(width: spacing.xs),
                const AppText.label(
                  'FluxUI release preview',
                  tone: AppTextTone.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
