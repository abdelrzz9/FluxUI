import 'dart:io';

import 'package:flutter_ui_cli/flutter_ui_cli.dart';

Future<void> main(List<String> arguments) async {
  final cli = FlutterUiCli();
  exitCode = await cli.run(arguments);
}
