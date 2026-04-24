import 'dart:io';

import 'package:flutter_ui_cli/commands/add_command.dart';
import 'package:flutter_ui_cli/flutter_ui_cli.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('FlutterUiCli', () {
    test('init creates config and local bridge files', () async {
      final project = await _createProject();
      final stdout = StringBuffer();
      final stderr = StringBuffer();
      final cli = FlutterUiCli(
        workingDirectory: project,
        stdoutSink: stdout,
        stderrSink: stderr,
      );

      final code = await cli.run(<String>['init']);

      expect(code, 0);
      expect(stderr.toString(), isEmpty);
      expect(
        File(p.join(project.path, 'flutter_ui.json')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(project.path, 'lib/ui/core/flutter_ui.dart'))
            .readAsStringSync(),
        contains("export 'package:flutter_ui/index.dart';"),
      );
      expect(
        File(p.join(project.path, 'lib/ui/index.dart')).readAsStringSync(),
        contains("export 'core/flutter_ui.dart';"),
      );
    });

    test(
      'add installs components, dependencies, and updates the bridge hide list',
      () async {
        final project = await _createProject();
        final stdout = StringBuffer();
        final stderr = StringBuffer();
        final cli = FlutterUiCli(
          workingDirectory: project,
          stdoutSink: stdout,
          stderrSink: stderr,
        );

        await cli.run(<String>['init']);
        final code = await cli.run(<String>['add', 'button', 'h-stack']);

        expect(code, 0);
        expect(stderr.toString(), isEmpty);
        expect(
          File(p.join(project.path, 'lib/ui/components/buttons/app_button.dart'))
              .existsSync(),
          isTrue,
        );
        expect(
          File(p.join(project.path, 'lib/ui/components/layouts/h_stack.dart'))
              .existsSync(),
          isTrue,
        );
        expect(
          File(p.join(project.path, 'lib/ui/components/layouts/gap.dart'))
              .existsSync(),
          isTrue,
        );

        final bridge = File(p.join(project.path, 'lib/ui/core/flutter_ui.dart'))
            .readAsStringSync();
        final index = File(p.join(project.path, 'lib/ui/components/index.dart'))
            .readAsStringSync();

        expect(bridge, contains('hide AppButton'));
        expect(bridge, contains('HStack'));
        expect(bridge, contains('Gap'));
        expect(index, contains("export 'buttons/app_button.dart';"));
        expect(index, contains("export 'layouts/h_stack.dart';"));
        expect(index, contains("export 'layouts/gap.dart';"));
      },
    );
  });

  group('AddCommand', () {
    test('add resolves close typos and writes into the local ui directory',
        () async {
      final project = await _createProject();
      final stdout = StringBuffer();
      final stderr = StringBuffer();
      final cli = AddCommand(
        workingDirectory: project,
        stdoutSink: stdout,
        stderrSink: stderr,
      );

      final code = await cli.run(<String>['buttom']);

      expect(code, 0);
      expect(stderr.toString(), isEmpty);
      expect(
        File(p.join(project.path, 'lib/ui/components/buttons/app_button.dart'))
            .existsSync(),
        isTrue,
      );
      expect(
        File(p.join(project.path, 'lib/ui/index.dart')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(project.path, 'flutter_ui.json')).existsSync(),
        isTrue,
      );
      expect(
        stdout.toString(),
        contains('Did you mean `button`? Installing it...'),
      );
    });
  });
}

Future<Directory> _createProject() async {
  final root = await Directory.systemTemp.createTemp('flutter_ui_cli_test_');
  final pubspec = File(p.join(root.path, 'pubspec.yaml'));

  pubspec.writeAsStringSync('''
name: sample_app
description: test project
environment:
  sdk: '>=3.4.0 <4.0.0'
''');

  return root;
}
