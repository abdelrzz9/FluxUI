import 'package:flutter/material.dart';

class ShowcaseController extends ChangeNotifier {
  ShowcaseController({
    String initialEmail = 'design@flutter-ui.dev',
    String initialRegistry = 'core',
    int initialReleasePage = 6,
  })  : emailController = TextEditingController(text: initialEmail),
        searchController = TextEditingController(),
        _selectedRegistry = initialRegistry,
        _selectedPage = initialReleasePage;

  final TextEditingController emailController;
  final TextEditingController searchController;

  int _carouselIndex = 0;
  int _selectedTabIndex = 0;
  int _selectedNavigationIndex = 0;
  int _selectedPage;
  bool _notificationsEnabled = true;
  bool _includeCliTemplates = true;
  String _selectedRegistry;
  String _otpValue = '';

  int get carouselIndex => _carouselIndex;
  int get selectedTabIndex => _selectedTabIndex;
  int get selectedNavigationIndex => _selectedNavigationIndex;
  int get selectedPage => _selectedPage;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get includeCliTemplates => _includeCliTemplates;
  String get selectedRegistry => _selectedRegistry;
  String get otpValue => _otpValue;

  String get otpHelperText => _otpValue.isEmpty
      ? 'Paste a 6-character code to verify your workspace.'
      : 'Current code: $_otpValue';

  String get currentReleasePageLabel => 'Current release page: $_selectedPage';

  void updateCarouselIndex(int value) {
    if (_carouselIndex == value) return;
    _carouselIndex = value;
    notifyListeners();
  }

  void updateSelectedTabIndex(int value) {
    if (_selectedTabIndex == value) return;
    _selectedTabIndex = value;
    notifyListeners();
  }

  void updateSelectedNavigationIndex(int value) {
    if (_selectedNavigationIndex == value) return;
    _selectedNavigationIndex = value;
    notifyListeners();
  }

  void updateSelectedPage(int value) {
    if (_selectedPage == value) return;
    _selectedPage = value;
    notifyListeners();
  }

  void updateNotificationsEnabled(bool value) {
    if (_notificationsEnabled == value) return;
    _notificationsEnabled = value;
    notifyListeners();
  }

  void updateIncludeCliTemplates(bool? value) {
    final nextValue = value ?? false;
    if (_includeCliTemplates == nextValue) return;
    _includeCliTemplates = nextValue;
    notifyListeners();
  }

  void updateSelectedRegistry(String value) {
    if (_selectedRegistry == value) return;
    _selectedRegistry = value;
    notifyListeners();
  }

  void updateOtpValue(String value) {
    if (_otpValue == value) return;
    _otpValue = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
