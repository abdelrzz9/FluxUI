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
  tester.view.physicalSize = const Size(1000, 1960);
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
              width: 960,
              height: 1900,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: const _GoldenShowcase(),
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
  const _GoldenShowcase();

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppCard(
          child: VStack(
            spacing: spacing.md,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppText.display('FluxUI'),
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
                    AppCombobox(
                      labelText: 'Registry',
                      value: 'core',
                      options: const <AppComboboxOption>[
                        AppComboboxOption(
                          value: 'core',
                          label: 'Core registry',
                        ),
                        AppComboboxOption(
                          value: 'labs',
                          label: 'Labs registry',
                        ),
                      ],
                      onChanged: (_) {},
                    ),
                    const AppOtpField(
                      length: 4,
                      initialValue: '4827',
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
                    const AppText.title('Navigation'),
                    AppTabs(
                      selectedIndex: 1,
                      showPanel: true,
                      onChanged: (_) {},
                      items: const <AppTabItem>[
                        AppTabItem(
                          label: 'Overview',
                          description: 'Release dashboard and package health.',
                        ),
                        AppTabItem(
                          label: 'Components',
                          badgeLabel: '7',
                          description:
                              'New FluxUI primitives shipping together.',
                        ),
                      ],
                    ),
                    AppNavigationMenu(
                      selectedIndex: 0,
                      onChanged: (_) {},
                      items: const <AppNavigationMenuItem>[
                        AppNavigationMenuItem(
                          label: 'Docs',
                          description: 'Install and theme the package quickly.',
                        ),
                        AppNavigationMenuItem(
                          label: 'Registry',
                          badgeLabel: 'new',
                          description:
                              'Inspect package and CLI component entries.',
                        ),
                      ],
                    ),
                    AppPagination(
                      currentPage: 6,
                      totalPages: 12,
                      onPageChanged: (_) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
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
                    const AppText.title('Feedback'),
                    AppAlert.info(
                      title: 'Registry sync ready',
                      description:
                          'FluxUI can generate package-backed components into your workspace.',
                      action: AppButton.ghost(
                        text: 'Review',
                        onPressed: () {},
                      ),
                    ),
                    const AppProgress(
                      value: 0.72,
                      label: 'Component rollout',
                      description:
                          'The next release is bundling feedback and display primitives.',
                    ),
                    const AppProgress.circular(
                      value: 0.88,
                      label: 'Docs sync',
                      description:
                          'API examples and showcase content are almost aligned.',
                      size: AppProgressSize.sm,
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
                    const AppText.title('Display'),
                    AppCarousel(
                      height: 240,
                      onChanged: (_) {},
                      children: const <Widget>[
                        _GoldenCarouselSlide(
                          title: 'Local ownership',
                          description:
                              'Generate editable FluxUI components into product codebases.',
                        ),
                        _GoldenCarouselSlide(
                          title: 'Token alignment',
                          description:
                              'Keep package widgets and generated code visually consistent.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        HStack(
          spacing: spacing.lg,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AppCard.outlined(
                child: VStack(
                  spacing: spacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppText.title('Selection'),
                    AppSwitch(
                      value: true,
                      label: 'Release notifications',
                      description: 'Notify the team when FluxUI ships updates.',
                      onChanged: (_) {},
                    ),
                    Divider(
                      height: spacing.md,
                      thickness: 1,
                      color: context.appColors.border,
                    ),
                    AppCheckbox(
                      value: true,
                      label: 'Include CLI templates',
                      description:
                          'Keep generated templates aligned with the package.',
                      onChanged: (_) {},
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
                    const AppText.title('Roadmap'),
                    AppCard.outlined(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: const <Widget>[
                          AppRoadmapItem(
                            title: 'Implement AppPagination component',
                            categoryLabel: 'component',
                            issueNumber: 16,
                            owner: 'abdelrzz9',
                            activityLabel: 'shipped in the component package',
                            state: AppRoadmapItemState.completed,
                          ),
                          AppRoadmapItem(
                            title: 'Implement AppTabs component',
                            categoryLabel: 'component',
                            issueNumber: 14,
                            owner: 'abdelrzz9',
                            activityLabel:
                                'shipped with controlled panel support',
                            state: AppRoadmapItemState.completed,
                            isHighlighted: true,
                          ),
                          AppRoadmapItem(
                            title: 'Implement AppNavigationMenu component',
                            categoryLabel: 'component',
                            issueNumber: 12,
                            owner: 'abdelrzz9',
                            activityLabel:
                                'shipped with trigger and panel content',
                            state: AppRoadmapItemState.completed,
                            showDivider: false,
                          ),
                        ],
                      ),
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

class _GoldenCarouselSlide extends StatelessWidget {
  const _GoldenCarouselSlide({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.lerp(colors.primaryContainer, colors.surface, 0.2)!,
            Color.lerp(colors.secondaryContainer, colors.surface, 0.08)!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.xl),
        child: VStack(
          spacing: spacing.md,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText.label(
              'Release preview',
              tone: AppTextTone.primary,
            )
                .paddingSymmetric(
                  horizontal: spacing.sm,
                  vertical: spacing.xs,
                )
                .background(
                  colors.primaryContainer,
                  radius: context.appRadius.pill,
                ),
            AppText.title(
              title,
              variant: AppTextVariant.titleLarge,
            ),
            AppText.body(
              description,
              tone: AppTextTone.muted,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.rocket_launch_outlined,
                  size: context.appSizes.iconSm,
                  color: colors.primary,
                ),
                SizedBox(width: spacing.xs),
                const AppText.label(
                  'FluxUI ship flow',
                  tone: AppTextTone.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
