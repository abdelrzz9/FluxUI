import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../domain/models/carousel_slide_content.dart';
import '../controllers/showcase_controller.dart';
import 'carousel_slide.dart';

class DisplaySection extends StatelessWidget {
  const DisplaySection({
    super.key,
    required this.controller,
    required this.carouselSlides,
  });

  final ShowcaseController controller;
  final List<CarouselSlideContent> carouselSlides;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppCarousel(
          height: 260,
          onChanged: controller.updateCarouselIndex,
          children: carouselSlides
              .map((slide) => CarouselSlide(content: slide))
              .toList(),
        ),
        AppText.body(
          'Current slide: ${controller.carouselIndex + 1} '
              'of ${carouselSlides.length}',
          variant: AppTextVariant.bodySmall,
          tone: AppTextTone.muted,
        ),
      ],
    );
  }
}
