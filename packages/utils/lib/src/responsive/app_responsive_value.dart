import 'package:flutter/widgets.dart';

import 'app_breakpoints.dart';

@immutable
final class AppResponsiveValue<T> {
  const AppResponsiveValue({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
  });

  final T compact;
  final T? medium;
  final T? expanded;
  final T? large;

  T resolve(
    BuildContext context, {
    AppBreakpoints breakpoints = AppBreakpoints.regular,
  }) {
    return resolveForWidth(
      MediaQuery.sizeOf(context).width,
      breakpoints: breakpoints,
    );
  }

  T resolveForWidth(
    double width, {
    AppBreakpoints breakpoints = AppBreakpoints.regular,
  }) {
    return resolveForWindowSize(breakpoints.resolve(width));
  }

  T resolveForWindowSize(AppWindowSize windowSize) {
    return switch (windowSize) {
      AppWindowSize.compact => compact,
      AppWindowSize.medium => medium ?? compact,
      AppWindowSize.expanded => expanded ?? medium ?? compact,
      AppWindowSize.large => large ?? expanded ?? medium ?? compact,
    };
  }
}
