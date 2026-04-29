import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('package-level flux entrypoint exists', () {
    expect(File('bin/flux.dart').existsSync(), isTrue);
  });

  test('package-level flutter_ui entrypoint exists', () {
    expect(File('bin/flutter_ui.dart').existsSync(), isTrue);
  });
}
