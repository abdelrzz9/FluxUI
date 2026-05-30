import '../models/carousel_slide_content.dart';
import '../models/registry_option.dart';
import '../models/release_tab_content.dart';
import '../models/roadmap_entry.dart';
import '../models/showcase_navigation_item.dart';

abstract interface class ShowcaseRepository {
  List<RegistryOption> getRegistryOptions();
  List<ReleaseTabContent> getReleaseTabs();
  List<ShowcaseNavigationItem> getNavigationItems();
  List<CarouselSlideContent> getCarouselSlides();
  List<RoadmapEntry> getRoadmapEntries();
}
