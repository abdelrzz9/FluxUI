import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import '../src/component_registry.dart';
import '../src/flutter_ui_config.dart';

final class AddCommand {
  AddCommand({
    io.Directory? workingDirectory,
    StringSink? stdoutSink,
    StringSink? stderrSink,
    io.Stdin? stdin,
    io.Stdin? input,
  })  : workingDirectory = workingDirectory ?? io.Directory.current,
        stdoutSink = stdoutSink ?? io.stdout,
        stderrSink = stderrSink ?? io.stderr,
        stdin = stdin ?? input ?? io.stdin;

  final io.Directory workingDirectory;
  final StringSink stdoutSink;
  final StringSink stderrSink;
  final io.Stdin stdin;

  String usage() {
    return _usage(_buildParser());
  }

  Future<int> run(List<String> arguments) async {
    final parser = _buildParser();
    ArgResults results;

    try {
      results = parser.parse(arguments);
    } on ArgParserException catch (error) {
      stderrSink.writeln(error.message);
      stderrSink.writeln('');
      stderrSink.writeln(_usage(parser));
      return 64;
    }

    if (results['help'] as bool) {
      stdoutSink.writeln(_usage(parser));
      return 0;
    }

    final rawComponentNames = results.rest;
    if (rawComponentNames.isEmpty) {
      stderrSink.writeln('No components provided.');
      stderrSink.writeln('');
      stderrSink.writeln(_usage(parser));
      return 64;
    }

    final projectDirectory = _resolveProjectDirectory(
      results['project-dir'] as String,
    );
    if (!_looksLikeFlutterProject(projectDirectory)) {
      stderrSink.writeln(
        'No `pubspec.yaml` found in `${projectDirectory.path}`. Run this command inside a Flutter project.',
      );
      return 66;
    }

    final config = _loadOrCreateConfig(projectDirectory);
    final overwrite = results['overwrite'] as bool;
    final definitions = <ComponentDefinition>[];
    final visited = <String>{};

    for (final rawName in rawComponentNames) {
      final definition = _resolveComponent(rawName);
      if (definition == null) {
        final replacement = _promptForComponent(projectDirectory, rawName);
        if (replacement == null) {
          stderrSink.writeln(
            'Unknown component `$rawName` and no selection was made.',
          );
          return 64;
        }
        _visitDefinition(
          replacement,
          definitions: definitions,
          visited: visited,
        );
        continue;
      }

      _visitDefinition(
        definition,
        definitions: definitions,
        visited: visited,
      );
    }

    final installed = <String>{...config.generatedComponents};
    var writtenCount = 0;

    for (final definition in definitions) {
      final targetPath = p.join(config.componentsDir, definition.outputPath);
      final absolutePath = p.join(projectDirectory.path, targetPath);
      final file = io.File(absolutePath);
      file.parent.createSync(recursive: true);

      if (file.existsSync() && !overwrite) {
        if (!_confirmOverwrite(targetPath)) {
          stdoutSink.writeln('Skipped `$targetPath`.');
          continue;
        }
      }

      file.writeAsStringSync(definition.template);
      installed.add(definition.id);
      writtenCount++;
      stdoutSink.writeln('Added `$targetPath`');
    }

    final updatedConfig = config.copyWith(
      generatedComponents: installed.toList()..sort(),
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
      'Installed $writtenCount component(s). Import `package:${_packageName(projectDirectory)}/${_packageImportPath(updatedConfig.indexFile)}` to use your local copies.',
    );
    return 0;
  }

  ArgParser _buildParser() {
    return ArgParser()
      ..addFlag('help', abbr: 'h', negatable: false)
      ..addOption('project-dir', defaultsTo: '.')
      ..addFlag('overwrite', negatable: false);
  }

  String _usage(ArgParser parser) {
    return '''
flux add

Copy one or more FluxUI components into a Flutter project.

Usage:
  flux add button
  flux add button card

Options:
${parser.usage}
''';
  }

  io.Directory _resolveProjectDirectory(String rawPath) {
    return io.Directory(p.normalize(p.join(workingDirectory.path, rawPath)));
  }

  bool _looksLikeFlutterProject(io.Directory directory) {
    return io.File(p.join(directory.path, 'pubspec.yaml')).existsSync();
  }

  FlutterUiConfig _loadOrCreateConfig(io.Directory projectDirectory) {
    final file =
        io.File(p.join(projectDirectory.path, FlutterUiConfig.fileName));
    if (file.existsSync()) {
      return FlutterUiConfig.loadFromProject(projectDirectory);
    }

    return FlutterUiConfig.initial();
  }

  ComponentDefinition? _resolveComponent(String rawName) {
    return ComponentRegistry.resolve(rawName);
  }

  void _visitDefinition(
    ComponentDefinition definition, {
    required List<ComponentDefinition> definitions,
    required Set<String> visited,
  }) {
    if (!visited.add(definition.id)) {
      return;
    }

    for (final dependency in definition.dependencies) {
      final dependencyDefinition = _resolveComponent(dependency);
      if (dependencyDefinition != null) {
        _visitDefinition(
          dependencyDefinition,
          definitions: definitions,
          visited: visited,
        );
      }
    }

    definitions.add(definition);
  }

  ComponentDefinition? _promptForComponent(
    io.Directory projectDirectory,
    String rawName,
  ) {
    if (!stdin.hasTerminal) {
      stdoutSink.writeln(_componentList());
      return null;
    }

    stdoutSink.writeln('Component `$rawName` was not found.');
    stdoutSink.writeln(_componentList());
    stdoutSink.write('Choose a component by name or number: ');

    final selection = stdin.readLineSync()?.trim();
    if (selection == null || selection.isEmpty) {
      return null;
    }

    final selected = _resolveSelection(selection);
    if (selected != null) {
      return selected;
    }

    stdoutSink.writeln(
        'Unable to resolve `$selection` inside `${projectDirectory.path}`.');
    return null;
  }

  ComponentDefinition? _resolveSelection(String selection) {
    final asNumber = int.tryParse(selection);
    if (asNumber != null) {
      final items = ComponentRegistry.available();
      if (asNumber < 1 || asNumber > items.length) {
        return null;
      }
      return items[asNumber - 1];
    }

    return _resolveComponent(selection);
  }

  bool _confirmOverwrite(String relativePath) {
    if (!stdin.hasTerminal) {
      return false;
    }

    stdoutSink.write('`$relativePath` already exists. Overwrite? [y/N]: ');
    final answer = stdin.readLineSync()?.trim().toLowerCase();
    return answer == 'y' || answer == 'yes';
  }

  String _componentList() {
    final buffer = StringBuffer('Available components:\n');
    final items = ComponentRegistry.available();
    for (var index = 0; index < items.length; index++) {
      final definition = items[index];
      final aliases = definition.aliases.isEmpty
          ? ''
          : ' (aliases: ${definition.aliases.join(', ')})';
      buffer.writeln('${index + 1}. ${definition.id}$aliases');
      buffer.writeln('   ${definition.description}');
    }
    return buffer.toString().trimRight();
  }

  void _writeGeneratedFile(
    io.Directory projectDirectory,
    String relativePath,
    String contents, {
    required bool overwrite,
  }) {
    final file = io.File(p.join(projectDirectory.path, relativePath));
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
// Generated by flux.
// Local copied components hide their package counterparts here so the app can
// export and customize them without symbol conflicts.
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
// Generated by flux.
// No local components yet. Run `flux add button` to start copying code.
''';
    }

    final exports = definitions
        .map((definition) =>
            "export '${definition.outputPath.replaceAll(r'\\', '/')}';")
        .join('\n');

    return '''
// Generated by flux.
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
// Generated by flux.
export '$bridgePath';
export '$componentsIndexPath';
''';
  }

  String _packageName(io.Directory projectDirectory) {
    final pubspec = io.File(p.join(projectDirectory.path, 'pubspec.yaml'));
    final line = pubspec.readAsLinesSync().firstWhere(
          (value) => value.trim().startsWith('name:'),
          orElse: () => 'name: app',
        );
    return line.split(':').last.trim();
  }

  String _packageImportPath(String relativePath) {
    return relativePath.startsWith('lib/')
        ? relativePath.substring('lib/'.length)
        : relativePath;
  }
}
