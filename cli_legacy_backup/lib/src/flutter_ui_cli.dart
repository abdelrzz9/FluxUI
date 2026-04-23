import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'component_registry.dart';
import 'flutter_ui_config.dart';

final class FlutterUiCli {
  FlutterUiCli({
    Directory? workingDirectory,
    StringSink? stdoutSink,
    StringSink? stderrSink,
  })  : workingDirectory = workingDirectory ?? Directory.current,
        stdoutSink = stdoutSink ?? stdout,
        stderrSink = stderrSink ?? stderr;

  final Directory workingDirectory;
  final StringSink stdoutSink;
  final StringSink stderrSink;

  Future<int> run(List<String> arguments) async {
    final parser = _buildParser();
    ArgResults results;

    try {
      results = parser.parse(arguments);
    } on ArgParserException catch (error) {
      stderrSink.writeln(error.message);
      stderrSink.writeln('');
      stderrSink.writeln(parser.usage);
      return 64;
    }

    final helpRequested = results['help'] as bool;
    final command = results.command;

    if (helpRequested || command == null) {
      stdoutSink.writeln(_usage(parser));
      return 0;
    }

    final commandHelp = command['help'] as bool;
    if (commandHelp) {
      stdoutSink.writeln(parser.commands[command.name]?.usage ?? parser.usage);
      return 0;
    }

    switch (command.name) {
      case 'init':
        return _runInit(command);
      case 'add':
        return _runAdd(command);
      case 'list':
        return _runList();
    }

    stderrSink.writeln('Unknown command `${command.name}`.');
    return 64;
  }

  ArgParser _buildParser() {
    final parser = ArgParser()..addFlag('help', abbr: 'h', negatable: false);

    parser.addCommand('init')
      ..addFlag('help', abbr: 'h', negatable: false)
      ..addOption('project-dir', defaultsTo: '.')
      ..addOption('components-dir', defaultsTo: 'lib/ui/components')
      ..addOption('core-dir', defaultsTo: 'lib/ui/core')
      ..addOption('index-file', defaultsTo: 'lib/ui/index.dart')
      ..addFlag('force', negatable: false);

    parser.addCommand('add')
      ..addFlag('help', abbr: 'h', negatable: false)
      ..addOption('project-dir', defaultsTo: '.')
      ..addFlag('overwrite', negatable: false);

    parser.addCommand('list').addFlag('help', abbr: 'h', negatable: false);

    return parser;
  }

  String _usage(ArgParser parser) {
    return '''
flutter_ui

Developer-first CLI for initializing a local Flutter UI workspace and copying
editable component files into your app.

Usage:
  flutter_ui init
  flutter_ui add button card
  flutter_ui list

Commands:
${parser.usage}
''';
  }

  int _runInit(ArgResults results) {
    final projectDirectory = _resolveProjectDirectory(
      results['project-dir'] as String,
    );

    if (!_looksLikeFlutterProject(projectDirectory)) {
      stderrSink.writeln(
        'No `pubspec.yaml` found in `${projectDirectory.path}`. Run `flutter_ui init` inside a Flutter project.',
      );
      return 66;
    }

    final configFile = File(
      p.join(projectDirectory.path, FlutterUiConfig.fileName),
    );
    final force = results['force'] as bool;
    var config = configFile.existsSync() && !force
        ? FlutterUiConfig.loadFromProject(projectDirectory)
        : FlutterUiConfig.initial(
            componentsDir: results['components-dir'] as String,
            coreDir: results['core-dir'] as String,
            indexFile: results['index-file'] as String,
          );

    config = config.copyWith(
      generatedComponents: config.generatedComponents.toSet().toList()..sort(),
    );

    Directory(p.join(projectDirectory.path, config.componentsDir))
        .createSync(recursive: true);
    Directory(p.join(projectDirectory.path, config.coreDir))
        .createSync(recursive: true);
    Directory(
      p.join(projectDirectory.path, p.dirname(config.indexFile)),
    ).createSync(recursive: true);

    _writeGeneratedFile(
      projectDirectory,
      config.bridgeFile,
      _buildBridgeFile(config.generatedComponents),
      overwrite: force,
    );
    _writeGeneratedFile(
      projectDirectory,
      config.componentsIndexFile,
      _buildComponentsIndex(config.generatedComponents),
      overwrite: force,
    );
    _writeGeneratedFile(
      projectDirectory,
      config.indexFile,
      _buildRootIndex(config),
      overwrite: force,
    );

    config.saveToProject(projectDirectory);

    stdoutSink.writeln(
        'Initialized flutter_ui workspace in `${projectDirectory.path}`.');
    stdoutSink.writeln('Config: `${FlutterUiConfig.fileName}`');
    stdoutSink.writeln('Components dir: `${config.componentsDir}`');
    stdoutSink.writeln('Core bridge: `${config.bridgeFile}`');
    return 0;
  }

  int _runAdd(ArgResults results) {
    final projectDirectory = _resolveProjectDirectory(
      results['project-dir'] as String,
    );
    final names = results.rest;

    if (names.isEmpty) {
      stderrSink
          .writeln('No components provided. Example: `flutter_ui add button`');
      return 64;
    }

    final configFile = File(
      p.join(projectDirectory.path, FlutterUiConfig.fileName),
    );

    if (!configFile.existsSync()) {
      stderrSink.writeln(
        'Missing `${FlutterUiConfig.fileName}`. Run `flutter_ui init` first.',
      );
      return 66;
    }

    final config = FlutterUiConfig.loadFromProject(projectDirectory);
    final overwrite = results['overwrite'] as bool;
    final ordered = <ComponentDefinition>[];
    final visited = <String>{};

    void visit(String name) {
      final definition = ComponentRegistry.resolve(name);
      if (definition == null) {
        throw ArgumentError('Unknown component `$name`.');
      }
      if (!visited.add(definition.id)) {
        return;
      }
      for (final dependency in definition.dependencies) {
        visit(dependency);
      }
      ordered.add(definition);
    }

    try {
      for (final name in names) {
        visit(name);
      }
    } on ArgumentError catch (error) {
      stderrSink.writeln(error.message);
      stderrSink.writeln('');
      stderrSink.writeln(_componentList());
      return 64;
    }

    final generated = <String>{...config.generatedComponents};

    for (final definition in ordered) {
      final targetPath = p.join(config.componentsDir, definition.outputPath);
      final absolute = p.join(projectDirectory.path, targetPath);
      final file = File(absolute);
      file.parent.createSync(recursive: true);

      if (file.existsSync() && !overwrite) {
        stdoutSink
            .writeln('Skipped `${targetPath}` because it already exists.');
      } else {
        file.writeAsStringSync(definition.template);
        stdoutSink.writeln('Added `${targetPath}`');
      }

      generated.add(definition.id);
    }

    final updatedConfig = config.copyWith(
      generatedComponents: generated.toList()..sort(),
    );
    updatedConfig.saveToProject(projectDirectory);

    _writeGeneratedFile(
      projectDirectory,
      updatedConfig.bridgeFile,
      _buildBridgeFile(updatedConfig.generatedComponents),
      overwrite: true,
    );
    _writeGeneratedFile(
      projectDirectory,
      updatedConfig.componentsIndexFile,
      _buildComponentsIndex(updatedConfig.generatedComponents),
      overwrite: true,
    );
    _writeGeneratedFile(
      projectDirectory,
      updatedConfig.indexFile,
      _buildRootIndex(updatedConfig),
      overwrite: true,
    );

    stdoutSink.writeln(
      'Installed ${ordered.length} component(s). Import `package:${_packageName(projectDirectory)}/${updatedConfig.indexFile}` to use your local copies.',
    );
    return 0;
  }

  int _runList() {
    stdoutSink.writeln(_componentList());
    return 0;
  }

  String _componentList() {
    final buffer = StringBuffer('Available components:\n');
    for (final definition in ComponentRegistry.available()) {
      final aliases = definition.aliases.isEmpty
          ? ''
          : ' (aliases: ${definition.aliases.join(', ')})';
      buffer.writeln('- ${definition.id}$aliases');
      buffer.writeln('  ${definition.description}');
    }
    return buffer.toString().trimRight();
  }

  Directory _resolveProjectDirectory(String rawPath) {
    return Directory(p.normalize(p.join(workingDirectory.path, rawPath)));
  }

  bool _looksLikeFlutterProject(Directory directory) {
    return File(p.join(directory.path, 'pubspec.yaml')).existsSync();
  }

  void _writeGeneratedFile(
    Directory projectDirectory,
    String relativePath,
    String contents, {
    required bool overwrite,
  }) {
    final file = File(p.join(projectDirectory.path, relativePath));
    file.parent.createSync(recursive: true);

    if (!file.existsSync() || overwrite) {
      file.writeAsStringSync(contents);
    }
  }

  String _buildBridgeFile(Iterable<String> generatedComponents) {
    final hiddenSymbols = <String>{
      for (final componentId in generatedComponents)
        ...?ComponentRegistry.definitions[componentId]?.publicSymbols,
    }.toList()
      ..sort();

    final exportLine = hiddenSymbols.isEmpty
        ? "export 'package:flutter_ui/index.dart';"
        : "export 'package:flutter_ui/index.dart' hide ${hiddenSymbols.join(', ')};";

    return '''
// Generated by flutter_ui_cli. Local copied components hide their package
// counterparts here so your app can export and customize them without symbol
// conflicts.
$exportLine
''';
  }

  String _buildComponentsIndex(Iterable<String> generatedComponents) {
    final definitions = generatedComponents
        .map((id) => ComponentRegistry.definitions[id])
        .whereType<ComponentDefinition>()
        .toList()
      ..sort((a, b) => a.outputPath.compareTo(b.outputPath));

    if (definitions.isEmpty) {
      return '''
// Generated by flutter_ui_cli.
// No local components yet. Run `flutter_ui add button` to start copying code.
''';
    }

    final exports = definitions
        .map((definition) =>
            "export '${definition.outputPath.replaceAll(r'\\', '/')}';")
        .join('\n');

    return '''
// Generated by flutter_ui_cli.
$exports
''';
  }

  String _buildRootIndex(FlutterUiConfig config) {
    final bridgePath = p
        .relative(
          config.bridgeFile,
          from: p.dirname(config.indexFile),
        )
        .replaceAll(r'\\', '/');
    final componentsIndexPath = p
        .relative(
          config.componentsIndexFile,
          from: p.dirname(config.indexFile),
        )
        .replaceAll(r'\\', '/');

    return '''
// Generated by flutter_ui_cli.
export '$bridgePath';
export '$componentsIndexPath';
''';
  }

  String _packageName(Directory projectDirectory) {
    final pubspec = File(p.join(projectDirectory.path, 'pubspec.yaml'));
    final line = pubspec.readAsLinesSync().firstWhere(
          (value) => value.trim().startsWith('name:'),
          orElse: () => 'name: app',
        );
    return line.split(':').last.trim();
  }
}
