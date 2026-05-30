import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../features/showcase/presentation/pages/showcase_page.dart';
import 'theme_controller.dart';

void runExampleApp() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({
    super.key,
    this.themeController,
  });

  final ThemeController? themeController;

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late final ThemeController _ownedThemeController;

  ThemeController get _themeController =>
      widget.themeController ?? _ownedThemeController;

  @override
  void initState() {
    super.initState();
    _ownedThemeController = ThemeController();
  }

  @override
  void dispose() {
    if (widget.themeController == null) {
      _ownedThemeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeController,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'FluxUI example',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          home: ShowcasePage(
            isDarkMode: _themeController.isDarkMode,
            onToggleTheme: _themeController.toggleTheme,
          ),
        );
      },
    );
  }
}
