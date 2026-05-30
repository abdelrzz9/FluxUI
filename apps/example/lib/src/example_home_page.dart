import 'package:flutter/widgets.dart';

import 'features/showcase/data/showcase_catalog.dart';
import 'features/showcase/presentation/pages/showcase_page.dart';

class ExampleHomePage extends ShowcasePage {
  const ExampleHomePage({
    super.key,
    required bool isDarkMode,
    required VoidCallback onToggleTheme,
  }) : super(
          isDarkMode: isDarkMode,
          onToggleTheme: onToggleTheme,
          repository: const ShowcaseCatalog(),
        );
}
