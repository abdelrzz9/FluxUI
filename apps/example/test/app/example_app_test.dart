import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_example/src/app/di/app_dependencies.dart';
import 'package:flutter_ui_example/src/app/example_app.dart';
import 'package:flutter_ui_example/src/app/router/app_routes.dart';
import 'package:flutter_ui_example/src/app/theme_controller.dart';
import 'package:flutter_ui_example/src/features/showcase/data/showcase_catalog.dart';

void main() {
  testWidgets('ExampleApp wires router, theme, and showcase dependencies',
      (tester) async {
    final dependencies = AppDependencies(
      themeController: ThemeController(),
      showcaseRepository: const ShowcaseCatalog(),
    );

    await tester.pumpWidget(ExampleApp(dependencies: dependencies));

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.initialRoute, AppRoutes.showcase);
    expect(materialApp.onGenerateRoute, isNotNull);
    expect(find.text('FluxUI'), findsWidgets);
  });
}
