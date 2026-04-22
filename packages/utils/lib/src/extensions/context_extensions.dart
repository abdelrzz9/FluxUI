import 'package:flutter/widgets.dart';

import '../responsive/app_breakpoints.dart';
import '../responsive/app_responsive_value.dart';

extension AppResponsiveContextExtensions on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  AppWindowSize get windowSize => AppBreakpoints.regular.resolve(screenWidth);

  bool get isCompact => windowSize == AppWindowSize.compact;

  bool get isMedium => windowSize == AppWindowSize.medium;

  bool get isExpanded => windowSize == AppWindowSize.expanded;

  bool get isLarge => windowSize == AppWindowSize.large;

  T responsive<T>({
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    AppBreakpoints breakpoints = AppBreakpoints.regular,
  }) {
    return AppResponsiveValue<T>(
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
    ).resolveForWidth(screenWidth, breakpoints: breakpoints);
  }
}
