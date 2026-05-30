import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../data/showcase_catalog.dart';
import '../controllers/showcase_controller.dart';
import '../widgets/buttons_section.dart';
import '../widgets/display_section.dart';
import '../widgets/feedback_section.dart';
import '../widgets/hero_banner.dart';
import '../widgets/inputs_section.dart';
import '../widgets/layouts_section.dart';
import '../widgets/navigation_section.dart';
import '../widgets/roadmap_list.dart';
import '../widgets/selection_section.dart';
import '../widgets/showcase_section.dart';
import '../widgets/typography_section.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    this.catalog = const ShowcaseCatalog(),
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final ShowcaseCatalog catalog;

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  late final ShowcaseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ShowcaseController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return _ShowcaseView(
          controller: _controller,
          catalog: widget.catalog,
          isDarkMode: widget.isDarkMode,
          onToggleTheme: widget.onToggleTheme,
        );
      },
    );
  }
}

class _ShowcaseView extends StatelessWidget {
  const _ShowcaseView({
    required this.controller,
    required this.catalog,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  final ShowcaseController controller;
  final ShowcaseCatalog catalog;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

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
              HeroBanner(
                isDarkMode: isDarkMode,
                onToggleTheme: onToggleTheme,
              ),
              const ShowcaseSection(
                title: 'Typography',
                description:
                    'Semantic text primitives pull size, weight, and color from the theme extension.',
                child: TypographySection(),
              ),
              const ShowcaseSection(
                title: 'Buttons',
                description:
                    'Variants, sizes, and loading states remain fully token-driven.',
                child: ButtonsSection(),
              ),
              ShowcaseSection(
                title: 'Inputs',
                description:
                    'Text fields, comboboxes, and OTP entry all pull spacing, radius, and color from the same token source.',
                child: InputsSection(
                  controller: controller,
                  registryOptions: catalog.registryOptions,
                ),
              ),
              ShowcaseSection(
                title: 'Navigation',
                description:
                    'Tabs, navigation menus, and pagination all stay controlled from app state while sharing the same FluxUI tokens.',
                child: NavigationSection(
                  controller: controller,
                  releaseTabs: catalog.releaseTabs,
                  navigationItems: catalog.navigationItems,
                ),
              ),
              const ShowcaseSection(
                title: 'Feedback',
                description:
                    'Alerts and progress indicators handle product status without dropping down to raw Material styling.',
                child: FeedbackSection(),
              ),
              ShowcaseSection(
                title: 'Display',
                description:
                    'AppCarousel gives FluxUI a reusable hero-style content surface with built-in paging, controls, and indicators.',
                child: DisplaySection(
                  controller: controller,
                  carouselSlides: catalog.carouselSlides,
                ),
              ),
              ShowcaseSection(
                title: 'Selection',
                description:
                    'Switches and checkboxes expose product state cleanly without falling back to raw Material defaults.',
                child: SelectionSection(controller: controller),
              ),
              const ShowcaseSection(
                title: 'Layouts',
                description:
                    'Gap, HStack, and VStack keep page composition readable without hiding Flutter’s underlying widgets.',
                child: LayoutsSection(),
              ),
              ShowcaseSection(
                title: 'Roadmap',
                description:
                    'GitHub-inspired roadmap items keep FluxUI planning views readable while staying fully theme-driven.',
                child: RoadmapList(entries: catalog.roadmapEntries),
              ),
            ],
          ).center(),
        ),
      ),
    );
  }
}
