import 'package:flutter/widgets.dart';

import 'di/app_dependencies.dart';
import 'example_app.dart';

Future<void> bootstrapExampleApp({AppDependencies? dependencies}) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ExampleApp(dependencies: dependencies ?? AppDependencies.production()),
  );
}
