import '../domain/models/carousel_slide_content.dart';
import '../domain/models/registry_option.dart';
import '../domain/models/release_tab_content.dart';
import '../domain/models/roadmap_entry.dart';
import '../domain/models/showcase_icon.dart';
import '../domain/models/showcase_navigation_item.dart';

class ShowcaseCatalog {
  const ShowcaseCatalog();

  List<RegistryOption> get registryOptions => _registryOptions;
  List<ReleaseTabContent> get releaseTabs => _releaseTabs;
  List<ShowcaseNavigationItem> get navigationItems => _navigationItems;
  List<CarouselSlideContent> get carouselSlides => _carouselSlides;
  List<RoadmapEntry> get roadmapEntries => _roadmapEntries;
}

const List<RegistryOption> _registryOptions = <RegistryOption>[
  RegistryOption(
    value: 'core',
    label: 'Core registry',
    description: 'Stable, production-ready FluxUI components.',
  ),
  RegistryOption(
    value: 'labs',
    label: 'Labs registry',
    description: 'Preview components that are still evolving.',
  ),
  RegistryOption(
    value: 'internal',
    label: 'Internal registry',
    description: 'Workspace-only components layered on top of FluxUI.',
  ),
];

const List<ReleaseTabContent> _releaseTabs = <ReleaseTabContent>[
  ReleaseTabContent(
    label: 'Overview',
    icon: ShowcaseIcon.dashboard,
    description:
        'Track the package surface, example coverage, and release status from a single control.',
  ),
  ReleaseTabContent(
    label: 'Components',
    icon: ShowcaseIcon.widgets,
    badgeLabel: '7',
    description:
        'Pagination, tabs, navigation menu, switch, combobox, OTP, and checkbox now ship together.',
  ),
  ReleaseTabContent(
    label: 'CLI',
    icon: ShowcaseIcon.terminal,
    description:
        'Keep package APIs and generated templates aligned as the component surface grows.',
  ),
];

const List<ShowcaseNavigationItem> _navigationItems = <ShowcaseNavigationItem>[
  ShowcaseNavigationItem(
    label: 'Docs',
    icon: ShowcaseIcon.docs,
    description:
        'Read installation, theming, and package usage guidance before adding components.',
  ),
  ShowcaseNavigationItem(
    label: 'Registry',
    icon: ShowcaseIcon.registry,
    badgeLabel: 'new',
    description:
        'Review package-backed and CLI-backed component entries before generating code.',
  ),
  ShowcaseNavigationItem(
    label: 'Releases',
    icon: ShowcaseIcon.releases,
    description:
        'Check recent component additions and upcoming migration notes for FluxUI updates.',
  ),
];

const List<CarouselSlideContent> _carouselSlides = <CarouselSlideContent>[
  CarouselSlideContent(
    title: 'Ship faster with local ownership',
    description:
        'Use the package directly or generate editable components into product codebases.',
    eyebrow: 'Flux add',
  ),
  CarouselSlideContent(
    title: 'Keep tokens and widgets aligned',
    description:
        'Shared theme extensions keep app surfaces visually consistent as the component set grows.',
    eyebrow: 'Theme layer',
  ),
  CarouselSlideContent(
    title: 'Review changes visually before release',
    description:
        'The example app and golden suite catch styling drift before it reaches production.',
    eyebrow: 'Visual QA',
  ),
];

const List<RoadmapEntry> _roadmapEntries = <RoadmapEntry>[
  RoadmapEntry(
    title: 'Implement AppPagination component',
    issueNumber: 16,
    activityLabel: 'shipped in the component package',
    state: RoadmapEntryState.completed,
  ),
  RoadmapEntry(
    title: 'Implement AppTabs component',
    issueNumber: 14,
    activityLabel: 'shipped with controlled panel support',
    state: RoadmapEntryState.completed,
  ),
  RoadmapEntry(
    title: 'Implement AppNavigationMenu component',
    issueNumber: 12,
    activityLabel: 'shipped with trigger and panel content',
    state: RoadmapEntryState.completed,
  ),
  RoadmapEntry(
    title: 'Implement AppSwitch component',
    issueNumber: 11,
    activityLabel: 'shipped with labeled control rows',
    state: RoadmapEntryState.completed,
    isHighlighted: true,
  ),
  RoadmapEntry(
    title: 'Implement AppCombobox component',
    issueNumber: 10,
    activityLabel: 'shipped with searchable option sheets',
    state: RoadmapEntryState.completed,
  ),
  RoadmapEntry(
    title: 'Implement AppOtpField and AppCheckbox components',
    issueNumber: 9,
    activityLabel: 'shipped for verification and settings flows',
    state: RoadmapEntryState.completed,
  ),
];
