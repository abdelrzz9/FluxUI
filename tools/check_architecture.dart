import 'dart:io';

void main() {
  final failures = <String>[];

  _requireDirectories(
    <String>[
      'packages/tokens',
      'packages/utils',
      'packages/fluxui',
      'packages/cli',
      'apps/example',
      'apps/example/lib/src/app',
      'apps/example/lib/src/features/showcase/data',
      'apps/example/lib/src/features/showcase/domain/models',
      'apps/example/lib/src/features/showcase/presentation/controllers',
      'apps/example/lib/src/features/showcase/presentation/mappers',
      'apps/example/lib/src/features/showcase/presentation/pages',
      'apps/example/lib/src/features/showcase/presentation/widgets',
      'docs',
    ],
    failures,
  );

  _requireFiles(
    <String>[
      'melos.yaml',
      '.github/workflows/ci.yml',
      '.github/workflows/publish_dry_run.yml',
      'apps/example/lib/src/app/example_app.dart',
      'apps/example/lib/src/app/theme_controller.dart',
      'apps/example/lib/src/features/showcase/data/showcase_catalog.dart',
      'apps/example/lib/src/features/showcase/domain/models/showcase_icon.dart',
      'apps/example/lib/src/features/showcase/presentation/controllers/showcase_controller.dart',
      'apps/example/lib/src/features/showcase/presentation/mappers/showcase_icon_mapper.dart',
      'apps/example/lib/src/features/showcase/presentation/pages/showcase_page.dart',
      'docs/example_architecture_review.md',
    ],
    failures,
  );

  _requireText(
    'melos.yaml',
    <String>[
      'analyze:flutter:',
      'analyze:cli:',
      'test:flutter:',
      'test:cli:',
      'publish:dry-run:flutter:',
      'publish:dry-run:cli:',
    ],
    failures,
  );

  _requireText(
    '.github/workflows/ci.yml',
    <String>[
      'subosito/flutter-action@v2',
      'dart run melos run check:architecture',
      'dart run melos run analyze:flutter',
      'dart run melos run analyze:cli',
      'dart run melos run test:flutter',
      'dart run melos run test:cli',
      'dart run melos run build',
    ],
    failures,
  );

  _forbidText(
    'melos.yaml',
    <String>[
      'tools/**',
      '--dir-exists=test -- flutter test',
    ],
    failures,
  );

  _forbidImports(
    Directory('apps/example/lib/src/features/showcase/domain'),
    <String>[
      "package:flutter/",
      "package:fluxui_kit/",
      '../presentation/',
    ],
    failures,
  );

  _forbidImports(
    Directory('apps/example/lib/src/features/showcase/data'),
    <String>[
      "package:flutter/",
      "package:fluxui_kit/",
      '../presentation/',
    ],
    failures,
  );

  if (failures.isNotEmpty) {
    stderr.writeln('Architecture check failed:');
    for (final failure in failures) {
      stderr.writeln('  - $failure');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln('Architecture check passed.');
}

void _requireDirectories(List<String> paths, List<String> failures) {
  for (final path in paths) {
    if (!Directory(path).existsSync()) {
      failures.add('Missing required directory: $path');
    }
  }
}

void _requireFiles(List<String> paths, List<String> failures) {
  for (final path in paths) {
    if (!File(path).existsSync()) {
      failures.add('Missing required file: $path');
    }
  }
}

void _requireText(
  String path,
  List<String> requiredSnippets,
  List<String> failures,
) {
  final file = File(path);
  if (!file.existsSync()) {
    failures.add('Cannot inspect missing file: $path');
    return;
  }

  final contents = file.readAsStringSync();
  for (final snippet in requiredSnippets) {
    if (!contents.contains(snippet)) {
      failures.add('$path must contain `$snippet`');
    }
  }
}

void _forbidText(
  String path,
  List<String> forbiddenSnippets,
  List<String> failures,
) {
  final file = File(path);
  if (!file.existsSync()) {
    failures.add('Cannot inspect missing file: $path');
    return;
  }

  final contents = file.readAsStringSync();
  for (final snippet in forbiddenSnippets) {
    if (contents.contains(snippet)) {
      failures.add('$path must not contain `$snippet`');
    }
  }
}

void _forbidImports(
  Directory directory,
  List<String> forbiddenSnippets,
  List<String> failures,
) {
  if (!directory.existsSync()) {
    failures.add('Cannot inspect missing directory: ${directory.path}');
    return;
  }

  final dartFiles = directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));

  for (final file in dartFiles) {
    final contents = file.readAsStringSync();
    for (final snippet in forbiddenSnippets) {
      if (contents.contains(snippet)) {
        failures.add('${file.path} must not depend on `$snippet`');
      }
    }
  }
}
