import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_example/src/features/showcase/data/showcase_catalog.dart';

void main() {
  group('ShowcaseCatalog', () {
    const catalog = ShowcaseCatalog();

    test('provides a default selected registry option', () {
      final options = catalog.getRegistryOptions();

      expect(options, isNotEmpty);
      expect(options.any((option) => option.value == 'core'), isTrue);
    });

    test('keeps carousel and navigation content available', () {
      expect(catalog.getCarouselSlides(), hasLength(3));
      expect(catalog.getReleaseTabs(), isNotEmpty);
      expect(catalog.getNavigationItems(), isNotEmpty);
      expect(catalog.getRoadmapEntries(), isNotEmpty);
    });
  });
}
