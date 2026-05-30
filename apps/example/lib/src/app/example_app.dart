import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import 'di/app_dependencies.dart';
import 'router/app_router.dart';
import 'router/app_routes.dart';

void runExampleApp() {
  runApp(ExampleApp(dependencies: AppDependencies.production()));
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({
    super.key,
    required this.dependencies,
  });

  final AppDependencies dependencies;

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter(dependencies: widget.dependencies);
  }

  @override
  void dispose() {
    widget.dependencies.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: widget.dependencies.themeController,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'FluxUI example',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          initialRoute: AppRoutes.showcase,
          onGenerateRoute: _router.onGenerateRoute,
        );
      },
    );
  }
}
