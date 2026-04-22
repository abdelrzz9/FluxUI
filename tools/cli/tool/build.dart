import 'dart:io' as io;

Future<void> main(List<String> arguments) async {
  final buildDirectory = io.Directory('build');
  if (!buildDirectory.existsSync()) {
    buildDirectory.createSync(recursive: true);
  }

  final result = await io.Process.run(
    io.Platform.resolvedExecutable,
    <String>[
      'compile',
      'exe',
      'bin/flux.dart',
      '-o',
      'build/flux',
    ],
    workingDirectory: io.Directory.current.path,
  );

  if (result.stdout case final String stdoutText when stdoutText.isNotEmpty) {
    io.stdout.write(stdoutText);
  }

  if (result.stderr case final String stderrText when stderrText.isNotEmpty) {
    io.stderr.write(stderrText);
  }

  io.exitCode = result.exitCode;
}
