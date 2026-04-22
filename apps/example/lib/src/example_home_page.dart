import 'package:flutter/material.dart';
import 'package:flutter_ui/index.dart';

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  late final TextEditingController _emailController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'design@flutter-ui.dev');
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final responsiveColumns = context.responsive<int>(
      compact: 1,
      medium: 2,
      expanded: 2,
      large: 3,
    );

    return Scaffold(
      appBar: AppBar(
        title: const AppText.title('flutter_ui'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.lg),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.appSizes.containerXl),
          child: VStack(
            spacing: spacing.xl,
            children: <Widget>[
              _HeroBanner(
                isDarkMode: widget.isDarkMode,
                onToggleTheme: widget.onToggleTheme,
              ),
              _ShowcaseSection(
                title: 'Typography',
                description:
                    'Semantic text primitives pull size, weight, and color from the theme extension.',
                child: AppCard(
                  child: VStack(
                    spacing: spacing.md,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      AppText.display('Design system'),
                      AppText.headline('Reusable primitives'),
                      AppText.title('Production-grade Flutter UI'),
                      AppText.body(
                        'Use the package directly or copy generated files into your app with the CLI.',
                      ),
                      AppText.label(
                        'Muted helper copy',
                        tone: AppTextTone.muted,
                      ),
                    ],
                  ),
                ),
              ),
              _ShowcaseSection(
                title: 'Buttons',
                description:
                    'Variants, sizes, and loading states remain fully token-driven.',
                child: Wrap(
                  spacing: spacing.sm,
                  runSpacing: spacing.sm,
                  children: const <Widget>[
                    AppButton.primary(text: 'Primary'),
                    AppButton.secondary(text: 'Secondary'),
                    AppButton.outline(text: 'Outline'),
                    AppButton.ghost(text: 'Ghost'),
                    AppButton.primary(
                      text: 'Loading',
                      isLoading: true,
                    ),
                  ],
                ),
              ),
              _ShowcaseSection(
                title: 'Inputs',
                description:
                    'AppTextField is theme-backed and stays minimal enough to copy into product apps.',
                child: VStack(
                  spacing: spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppTextField.outline(
                      controller: _searchController,
                      labelText: 'Search',
                      hintText: 'Search components',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    AppTextField.filled(
                      controller: _emailController,
                      labelText: 'Team email',
                      helperText: 'Synced from your design system settings',
                      prefixIcon: const Icon(Icons.mail_outline),
                    ),
                  ],
                ),
              ),
              _ShowcaseSection(
                title: 'Layouts',
                description:
                    'Gap, HStack, and VStack keep page composition readable without hiding Flutter’s underlying widgets.',
                child: AppCard.muted(
                  child: VStack(
                    spacing: spacing.md,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HStack(
                        spacing: spacing.sm,
                        children: <Widget>[
                          _ColorSwatch(color: colors.primary, label: 'Primary'),
                          _ColorSwatch(
                            color: colors.secondaryContainer,
                            label: 'Secondary',
                          ),
                          _ColorSwatch(
                            color: colors.surfaceMuted,
                            label: 'Muted',
                          ),
                        ],
                      ),
                      HStack(
                        spacing: spacing.sm,
                        children: <Widget>[
                          const AppText.body('Breakpoint'),
                          AppText.label(
                            context.windowSize.name,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _ShowcaseSection(
                title: 'Responsive cards',
                description:
                    'The example app uses the responsive helpers to shift from a single column to a denser grid.',
                child: _ResponsiveCardGrid(columns: responsiveColumns),
              ),
            ],
          ).center(),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;

    return AppCard(
      child: VStack(
        spacing: spacing.lg,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HStack(
            spacing: spacing.md,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: VStack(
                  spacing: spacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    AppText.display('Composable Flutter UI'),
                    AppText.body(
                      'Package-driven theme, copy-pasteable components, and a CLI that turns primitives into local code.',
                      tone: AppTextTone.muted,
                    ),
                  ],
                ),
              ),
              AppButton.outline(
                text: isDarkMode ? 'Light mode' : 'Dark mode',
                onPressed: onToggleTheme,
              ),
            ],
          ),
          HStack(
            spacing: spacing.sm,
            children: <Widget>[
              const AppButton.primary(text: 'Install package'),
              AppButton.ghost(
                text: 'Generate locally',
                onPressed: onToggleTheme,
              ),
            ],
          ),
          AppText.label(
            'Tokens • ThemeExtensions • Fluent extensions • CLI',
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
        ],
      ),
    ).shadow(color: colors.shadow, blurRadius: 24, offset: const Offset(0, 12));
  }
}

class _ShowcaseSection extends StatelessWidget {
  const _ShowcaseSection({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText.title(title),
        AppText.body(description, tone: AppTextTone.muted),
        child,
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
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
        const SizedBox(width: 56, height: 56)
            .background(color, radius: context.appRadius.md)
            .border(
              color: context.appColors.border,
              radius: context.appRadius.md,
            ),
        AppText.label(label, tone: AppTextTone.muted),
      ],
    );
  }
}

class _ResponsiveCardGrid extends StatelessWidget {
  const _ResponsiveCardGrid({
    required this.columns,
  });

  final int columns;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final items = List<int>.generate(6, (index) => index);

    return Wrap(
      spacing: spacing.md,
      runSpacing: spacing.md,
      children: items.map((index) {
        final width = (context.screenWidth -
                (spacing.lg * 2) -
                (spacing.md * (columns - 1))) /
            columns;

        return AppCard.outlined(
          width: width.clamp(220, 360),
          child: VStack(
            spacing: spacing.sm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText.title('Component ${index + 1}'),
              const AppText.body(
                'Local generation keeps this code editable inside the consuming app.',
                tone: AppTextTone.muted,
              ),
              AppButton.ghost(
                text: 'Inspect',
                onPressed: () {},
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
