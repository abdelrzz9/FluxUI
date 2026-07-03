import 'package:flutter/material.dart';

import '../../features/showcase/presentation/pages/showcase_page.dart';
import '../di/app_dependencies.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter({required this.dependencies});

  final AppDependencies dependencies;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.showcase:
      case null:
        return _showcaseRoute(const RouteSettings(name: AppRoutes.showcase));
      default:
        return _showcaseRoute(settings);
    }
  }

  Route<dynamic> _showcaseRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => ValueListenableBuilder<ThemeMode>(
        valueListenable: dependencies.themeController,
        builder: (_, themeMode, __) {
          return ShowcasePage(
            isDarkMode: themeMode == ThemeMode.dark,
            onToggleTheme: dependencies.themeController.toggleTheme,
            repository: dependencies.showcaseRepository,
          );
        },
      ),
    );
  }
}
