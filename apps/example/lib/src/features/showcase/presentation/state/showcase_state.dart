class ShowcaseState {
  const ShowcaseState({
    this.carouselIndex = 0,
    this.selectedTabIndex = 0,
    this.selectedNavigationIndex = 0,
    this.selectedPage = 6,
    this.notificationsEnabled = true,
    this.includeCliTemplates = true,
    this.selectedRegistry = 'core',
    this.otpValue = '',
  });

  final int carouselIndex;
  final int selectedTabIndex;
  final int selectedNavigationIndex;
  final int selectedPage;
  final bool notificationsEnabled;
  final bool includeCliTemplates;
  final String selectedRegistry;
  final String otpValue;

  String get otpHelperText => otpValue.isEmpty
      ? 'Paste a 6-character code to verify your workspace.'
      : 'Current code: $otpValue';

  String get currentReleasePageLabel => 'Current release page: $selectedPage';

  ShowcaseState copyWith({
    int? carouselIndex,
    int? selectedTabIndex,
    int? selectedNavigationIndex,
    int? selectedPage,
    bool? notificationsEnabled,
    bool? includeCliTemplates,
    String? selectedRegistry,
    String? otpValue,
  }) {
    return ShowcaseState(
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedNavigationIndex:
          selectedNavigationIndex ?? this.selectedNavigationIndex,
      selectedPage: selectedPage ?? this.selectedPage,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      includeCliTemplates: includeCliTemplates ?? this.includeCliTemplates,
      selectedRegistry: selectedRegistry ?? this.selectedRegistry,
      otpValue: otpValue ?? this.otpValue,
    );
  }
}
