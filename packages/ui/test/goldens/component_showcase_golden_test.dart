@Tags(<String>['golden'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/index.dart';

void main() {
  testWidgets('light component showcase matches golden', (tester) async {
    await _pumpGoldenScene(tester, brightness: Brightness.light);

    await expectLater(
      find.byKey(_sceneKey),
      matchesGoldenFile('goldens/component_showcase_light.png'),
    );
  });

  testWidgets('dark component showcase matches golden', (tester) async {
    await _pumpGoldenScene(tester, brightness: Brightness.dark);

    await expectLater(
      find.byKey(_sceneKey),
      matchesGoldenFile('goldens/component_showcase_dark.png'),
    );
  });
}

const Key _sceneKey = ValueKey<String>('component-showcase-scene');

Future<void> _pumpGoldenScene(
  WidgetTester tester, {
  required Brightness brightness,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(960, 760);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  final theme =
      brightness == Brightness.dark ? AppTheme.dark() : AppTheme.light();

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: RepaintBoundary(
            key: _sceneKey,
            child: SizedBox(
              width: 920,
              height: 720,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _GoldenShowcase(theme: theme),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();
}

class _GoldenShowcase extends StatelessWidget {
  const _GoldenShowcase({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return VStack(
      spacing: spacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppCard(
          child: VStack(
            spacing: spacing.md,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppText.display('flutter_ui'),
              const AppText.body(
                'Golden coverage for the public component surface.',
                tone: AppTextTone.muted,
              ),
              HStack(
                spacing: spacing.sm,
                children: const <Widget>[
                  AppButton.primary(text: 'Primary'),
                  AppButton.secondary(text: 'Secondary'),
                  AppButton.outline(text: 'Outline'),
                  AppButton.ghost(text: 'Ghost'),
                ],
              ),
            ],
          ),
        ),
        HStack(
          spacing: spacing.lg,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AppCard.outlined(
                child: VStack(
                  spacing: spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppText.title('Inputs'),
                    const AppTextField.outline(
                      labelText: 'Email',
                      hintText: 'design@flutter-ui.dev',
                    ),
                    const AppTextField.filled(
                      labelText: 'Workspace',
                      initialValue: 'Design systems',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AppCard.muted(
                child: VStack(
                  spacing: spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppText.title('Layout'),
                    HStack(
                      spacing: spacing.sm,
                      children: <Widget>[
                        _Swatch(
                          color: colors.primary,
                          label: 'Primary',
                        ),
                        _Swatch(
                          color: colors.secondaryContainer,
                          label: 'Secondary',
                        ),
                        _Swatch(
                          color: colors.surfaceMuted,
                          label: 'Muted',
                        ),
                      ],
                    ),
                    const AppText.body(
                      'Gap, HStack, and VStack keep composition readable.',
                      tone: AppTextTone.muted,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      children: <Widget>[
        const SizedBox(width: 64, height: 64)
            .background(
              color,
              radius: context.appRadius.md,
            )
            .border(
              color: context.appColors.border,
              radius: context.appRadius.md,
            ),
        AppText.label(label, tone: AppTextTone.muted),
      ],
    );
  }
}
