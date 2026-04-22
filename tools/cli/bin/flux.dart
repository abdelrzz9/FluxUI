import 'dart:io' as io;

import 'package:flutter_ui_cli/commands/add_command.dart';

Future<void> main(List<String> arguments) async {
  final cli = FluxCli();
  io.exitCode = await cli.run(arguments);
}

final class FluxCli {
  FluxCli({
    io.Directory? workingDirectory,
    StringSink? stdoutSink,
    StringSink? stderrSink,
    io.Stdin? stdin,
  })  : workingDirectory = workingDirectory ?? io.Directory.current,
        stdoutSink = stdoutSink ?? io.stdout,
        stderrSink = stderrSink ?? io.stderr,
        stdin = stdin ?? io.stdin;

  final io.Directory workingDirectory;
  final StringSink stdoutSink;
  final StringSink stderrSink;
  final io.Stdin stdin;

  Future<int> run(List<String> arguments) async {
    if (arguments.isEmpty || _isHelpToken(arguments.first)) {
      stdoutSink.writeln(_usage());
      return 0;
    }

    final command = arguments.first;
    final remaining = arguments.sublist(1);

    switch (command) {
      case 'add':
        return AddCommand(
          workingDirectory: workingDirectory,
          stdoutSink: stdoutSink,
          stderrSink: stderrSink,
          input: stdin,
        ).run(remaining);
      case 'help':
        stdoutSink.writeln(_usage());
        return 0;
    }

    stderrSink.writeln('Unknown command `$command`.');
    stderrSink.writeln('');
    stderrSink.writeln(_usage());
    return 64;
  }

  bool _isHelpToken(String value) {
    return value == '-h' || value == '--help' || value == 'help';
  }

  String _usage() {
    return '''
FluxUI CLI

Copy FluxUI components into a Flutter project.

Usage:
  flux add button
  flux add button card

Commands:
  add    Copy components into the current Flutter project
''';
  }
}
