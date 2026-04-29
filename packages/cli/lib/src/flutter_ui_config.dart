import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

final class FlutterUiConfig {
  const FlutterUiConfig({
    required this.componentsDir,
    required this.coreDir,
    required this.indexFile,
    required this.generatedComponents,
  });

  factory FlutterUiConfig.initial({
    String componentsDir = 'lib/ui/components',
    String coreDir = 'lib/ui/core',
    String indexFile = 'lib/ui/index.dart',
  }) {
    return FlutterUiConfig(
      componentsDir: componentsDir,
      coreDir: coreDir,
      indexFile: indexFile,
      generatedComponents: const <String>[],
    );
  }

  factory FlutterUiConfig.fromJson(Map<String, dynamic> json) {
    return FlutterUiConfig(
      componentsDir: json['components_dir'] as String? ?? 'lib/ui/components',
      coreDir: json['core_dir'] as String? ?? 'lib/ui/core',
      indexFile: json['index_file'] as String? ?? 'lib/ui/index.dart',
      generatedComponents:
          (json['generated_components'] as List<dynamic>? ?? const <dynamic>[])
              .cast<String>(),
    );
  }

  static const String fileName = 'flutter_ui.json';

  final String componentsDir;
  final String coreDir;
  final String indexFile;
  final List<String> generatedComponents;

  String get bridgeFile => p.join(coreDir, 'flutter_ui.dart');

  String get componentsIndexFile => p.join(componentsDir, 'index.dart');

  FlutterUiConfig copyWith({
    String? componentsDir,
    String? coreDir,
    String? indexFile,
    List<String>? generatedComponents,
  }) {
    return FlutterUiConfig(
      componentsDir: componentsDir ?? this.componentsDir,
      coreDir: coreDir ?? this.coreDir,
      indexFile: indexFile ?? this.indexFile,
      generatedComponents: generatedComponents ?? this.generatedComponents,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'schema_version': 1,
      'components_dir': componentsDir,
      'core_dir': coreDir,
      'index_file': indexFile,
      'generated_components': generatedComponents,
    };
  }

  String toJsonString() {
    const encoder = JsonEncoder.withIndent('  ');
    return '${encoder.convert(toJson())}\n';
  }

  static FlutterUiConfig loadFromProject(Directory projectDirectory) {
    final file = File(p.join(projectDirectory.path, fileName));
    final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    return FlutterUiConfig.fromJson(json);
  }

  void saveToProject(Directory projectDirectory) {
    final file = File(p.join(projectDirectory.path, fileName));
    file.writeAsStringSync(toJsonString());
  }
}
