import '../../features/showcase/data/showcase_catalog.dart';
import '../../features/showcase/domain/repositories/showcase_repository.dart';
import '../theme_controller.dart';

class AppDependencies {
  AppDependencies({
    required this.themeController,
    required this.showcaseRepository,
  });

  factory AppDependencies.production() {
    return AppDependencies(
      themeController: ThemeController(),
      showcaseRepository: const ShowcaseCatalog(),
    );
  }

  final ThemeController themeController;
  final ShowcaseRepository showcaseRepository;

  void dispose() {
    themeController.dispose();
  }
}
