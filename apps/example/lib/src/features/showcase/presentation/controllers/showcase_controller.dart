import 'package:flutter/material.dart';

import '../state/showcase_state.dart';

class ShowcaseController extends ChangeNotifier {
  ShowcaseController({
    String initialEmail = 'design@flutter-ui.dev',
    ShowcaseState initialState = const ShowcaseState(),
  })  : emailController = TextEditingController(text: initialEmail),
        searchController = TextEditingController(),
        _state = initialState;

  final TextEditingController emailController;
  final TextEditingController searchController;

  ShowcaseState _state;

  ShowcaseState get state => _state;
  int get carouselIndex => _state.carouselIndex;
  int get selectedTabIndex => _state.selectedTabIndex;
  int get selectedNavigationIndex => _state.selectedNavigationIndex;
  int get selectedPage => _state.selectedPage;
  bool get notificationsEnabled => _state.notificationsEnabled;
  bool get includeCliTemplates => _state.includeCliTemplates;
  String get selectedRegistry => _state.selectedRegistry;
  String get otpValue => _state.otpValue;
  String get otpHelperText => _state.otpHelperText;
  String get currentReleasePageLabel => _state.currentReleasePageLabel;

  void updateCarouselIndex(int value) {
    _updateState(_state.copyWith(carouselIndex: value));
  }

  void updateSelectedTabIndex(int value) {
    _updateState(_state.copyWith(selectedTabIndex: value));
  }

  void updateSelectedNavigationIndex(int value) {
    _updateState(_state.copyWith(selectedNavigationIndex: value));
  }

  void updateSelectedPage(int value) {
    _updateState(_state.copyWith(selectedPage: value));
  }

  void updateNotificationsEnabled(bool value) {
    _updateState(_state.copyWith(notificationsEnabled: value));
  }

  void updateIncludeCliTemplates(bool? value) {
    _updateState(_state.copyWith(includeCliTemplates: value ?? false));
  }

  void updateSelectedRegistry(String value) {
    _updateState(_state.copyWith(selectedRegistry: value));
  }

  void updateOtpValue(String value) {
    _updateState(_state.copyWith(otpValue: value));
  }

  void _updateState(ShowcaseState nextState) {
    if (_hasSameValues(nextState, _state)) return;
    _state = nextState;
    notifyListeners();
  }

  bool _hasSameValues(ShowcaseState a, ShowcaseState b) {
    return a.carouselIndex == b.carouselIndex &&
        a.selectedTabIndex == b.selectedTabIndex &&
        a.selectedNavigationIndex == b.selectedNavigationIndex &&
        a.selectedPage == b.selectedPage &&
        a.notificationsEnabled == b.notificationsEnabled &&
        a.includeCliTemplates == b.includeCliTemplates &&
        a.selectedRegistry == b.selectedRegistry &&
        a.otpValue == b.otpValue;
  }

  @override
  void dispose() {
    emailController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
