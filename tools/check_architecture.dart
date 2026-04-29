import 'dart:io';

void main() {
  final requiredPaths = <String>[
    'packages/cli',
    'packages/ui/content/docs',
    'packages/tokens',
    'packages/utils',
    'packages/ui',
    'apps/example',
  ];

  final missing = <String>[];
  for (final path in requiredPaths) {
    if (!Directory(path).existsSync()) {
      missing.add(path);
    }
  }

  if (missing.isNotEmpty) {
    stderr.writeln('Architecture check failed. Missing required paths:');
    for (final path in missing) {
      stderr.writeln('- $path');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln('Architecture check passed.');
}
