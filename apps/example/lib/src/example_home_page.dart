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
  var _selectedTabIndex = 0;
  var _selectedNavigationIndex = 0;
  var _selectedPage = 6;
  var _notificationsEnabled = true;
  var _includeCliTemplates = true;
  var _selectedRegistry = 'core';
  var _otpValue = '';

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

    return Scaffold(
      appBar: AppBar(
        title: const AppText.title('FluxUI'),
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
                    'Text fields, comboboxes, and OTP entry all pull spacing, radius, and color from the same token source.',
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
                    AppCombobox(
                      labelText: 'Registry',
                      value: _selectedRegistry,
                      helperText:
                          'Choose where FluxUI components should be generated from.',
                      options: _registryOptions,
                      onChanged: (next) {
                        setState(() {
                          _selectedRegistry = next;
                        });
                      },
                    ),
                    VStack(
                      spacing: spacing.xs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const AppText.label('Verification code'),
                        AppOtpField(
                          length: 6,
                          onChanged: (value) {
                            setState(() {
                              _otpValue = value;
                            });
                          },
                        ),
                        AppText.body(
                          _otpValue.isEmpty
                              ? 'Paste a 6-character code to verify your workspace.'
                              : 'Current code: $_otpValue',
                          variant: AppTextVariant.bodySmall,
                          tone: AppTextTone.muted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _ShowcaseSection(
                title: 'Navigation',
                description:
                    'Tabs, navigation menus, and pagination all stay controlled from app state while sharing the same FluxUI tokens.',
                child: VStack(
                  spacing: spacing.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppTabs(
                      items: _releaseTabs,
                      selectedIndex: _selectedTabIndex,
                      showPanel: true,
                      onChanged: (next) {
                        setState(() {
                          _selectedTabIndex = next;
                        });
                      },
                    ),
                    AppNavigationMenu(
                      items: _navigationMenuItems,
                      selectedIndex: _selectedNavigationIndex,
                      onChanged: (next) {
                        setState(() {
                          _selectedNavigationIndex = next;
                        });
                      },
                    ),
                    VStack(
                      spacing: spacing.xs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppPagination(
                          currentPage: _selectedPage,
                          totalPages: 18,
                          onPageChanged: (next) {
                            setState(() {
                              _selectedPage = next;
                            });
                          },
                        ),
                        AppText.body(
                          'Current release page: $_selectedPage',
                          variant: AppTextVariant.bodySmall,
                          tone: AppTextTone.muted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _ShowcaseSection(
                title: 'Selection',
                description:
                    'Switches and checkboxes expose product state cleanly without falling back to raw Material defaults.',
                child: AppCard.muted(
                  child: VStack(
                    spacing: spacing.sm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppSwitch(
                        value: _notificationsEnabled,
                        label: 'Release notifications',
                        description:
                            'Send a heads-up when FluxUI ships new primitives or breaking changes.',
                        onChanged: (next) {
                          setState(() {
                            _notificationsEnabled = next;
                          });
                        },
                      ),
                      Divider(
                        height: spacing.md,
                        thickness: 1,
                        color: colors.border,
                      ),
                      AppCheckbox(
                        value: _includeCliTemplates,
                        label: 'Include CLI templates',
                        description:
                            'Keep `flux add` templates aligned with the package components you install.',
                        onChanged: (next) {
                          setState(() {
                            _includeCliTemplates = next ?? false;
                          });
                        },
                      ),
                    ],
                  ),
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
                title: 'Roadmap',
                description:
                    'GitHub-inspired roadmap items keep FluxUI planning views readable while staying fully theme-driven.',
                child: const _FluxRoadmapList(),
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
                    AppText.display('FluxUI'),
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

class _FluxRoadmapList extends StatelessWidget {
  const _FluxRoadmapList();

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      padding: EdgeInsets.zero,
      child: Column(
        children: _roadmapEntries
            .map(
              (entry) => AppRoadmapItem(
                title: entry.title,
                kindLabel: 'Task',
                categoryLabel: 'component',
                issueNumber: entry.issueNumber,
                owner: 'abdelrzz9',
                activityLabel: entry.activityLabel,
                state: entry.state,
                isHighlighted: entry.isHighlighted,
                showDivider: entry != _roadmapEntries.last,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _RoadmapEntry {
  const _RoadmapEntry({
    required this.title,
    required this.issueNumber,
    required this.activityLabel,
    required this.state,
    this.isHighlighted = false,
  });

  final String title;
  final int issueNumber;
  final String activityLabel;
  final AppRoadmapItemState state;
  final bool isHighlighted;
}

const List<_RoadmapEntry> _roadmapEntries = <_RoadmapEntry>[
  _RoadmapEntry(
    title: 'Implement AppPagination component',
    issueNumber: 16,
    activityLabel: 'shipped in the component package',
    state: AppRoadmapItemState.completed,
  ),
  _RoadmapEntry(
    title: 'Implement AppTabs component',
    issueNumber: 14,
    activityLabel: 'shipped with controlled panel support',
    state: AppRoadmapItemState.completed,
  ),
  _RoadmapEntry(
    title: 'Implement AppNavigationMenu component',
    issueNumber: 12,
    activityLabel: 'shipped with trigger and panel content',
    state: AppRoadmapItemState.completed,
  ),
  _RoadmapEntry(
    title: 'Implement AppSwitch component',
    issueNumber: 11,
    activityLabel: 'shipped with labeled control rows',
    state: AppRoadmapItemState.completed,
    isHighlighted: true,
  ),
  _RoadmapEntry(
    title: 'Implement AppCombobox component',
    issueNumber: 10,
    activityLabel: 'shipped with searchable option sheets',
    state: AppRoadmapItemState.completed,
  ),
  _RoadmapEntry(
    title: 'Implement AppOtpField and AppCheckbox components',
    issueNumber: 9,
    activityLabel: 'shipped for verification and settings flows',
    state: AppRoadmapItemState.completed,
  ),
];

const List<AppComboboxOption> _registryOptions = <AppComboboxOption>[
  AppComboboxOption(
    value: 'core',
    label: 'Core registry',
    description: 'Stable, production-ready FluxUI components.',
  ),
  AppComboboxOption(
    value: 'labs',
    label: 'Labs registry',
    description: 'Preview components that are still evolving.',
  ),
  AppComboboxOption(
    value: 'internal',
    label: 'Internal registry',
    description: 'Workspace-only components layered on top of FluxUI.',
  ),
];

const List<AppTabItem> _releaseTabs = <AppTabItem>[
  AppTabItem(
    label: 'Overview',
    icon: Icons.dashboard_customize_outlined,
    description:
        'Track the package surface, example coverage, and release status from a single control.',
  ),
  AppTabItem(
    label: 'Components',
    icon: Icons.widgets_outlined,
    badgeLabel: '7',
    description:
        'Pagination, tabs, navigation menu, switch, combobox, OTP, and checkbox now ship together.',
  ),
  AppTabItem(
    label: 'CLI',
    icon: Icons.terminal_rounded,
    description:
        'Keep package APIs and generated templates aligned as the component surface grows.',
  ),
];

const List<AppNavigationMenuItem> _navigationMenuItems =
    <AppNavigationMenuItem>[
  AppNavigationMenuItem(
    label: 'Docs',
    icon: Icons.menu_book_outlined,
    description:
        'Read installation, theming, and package usage guidance before adding components.',
  ),
  AppNavigationMenuItem(
    label: 'Registry',
    icon: Icons.inventory_2_outlined,
    badgeLabel: 'new',
    description:
        'Review package-backed and CLI-backed component entries before generating code.',
  ),
  AppNavigationMenuItem(
    label: 'Releases',
    icon: Icons.rocket_launch_outlined,
    description:
        'Check recent component additions and upcoming migration notes for FluxUI updates.',
  ),
];
