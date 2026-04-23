import 'dart:io' as io;

Future<void> main(List<String> arguments) async {
  final scriptUri = io.Platform.script.resolve('../../../tools/cli/bin/flux.dart');
  final result = await io.Process.start(
    io.Platform.resolvedExecutable,
    <String>[scriptUri.toFilePath(), ...arguments],
    mode: io.ProcessStartMode.inheritStdio,
  );
  io.exitCode = await result.exitCode;
}
