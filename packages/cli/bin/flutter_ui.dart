import 'dart:io';

Future<void> main(List<String> arguments) async {
  final scriptUri = Platform.script.resolve('../../../tools/cli/bin/flutter_ui.dart');
  final result = await Process.start(
    Platform.resolvedExecutable,
    <String>[scriptUri.toFilePath(), ...arguments],
    mode: ProcessStartMode.inheritStdio,
  );
  exitCode = await result.exitCode;
}
