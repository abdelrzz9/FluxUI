import 'package:flutter/foundation.dart';

enum AppWindowSize {
  compact,
  medium,
  expanded,
  large,
}

@immutable
final class AppBreakpoints {
  const AppBreakpoints({
    this.medium = 600,
    this.expanded = 1024,
    this.large = 1440,
  })  : assert(medium > 0),
        assert(expanded > medium),
        assert(large > expanded);

  static const AppBreakpoints regular = AppBreakpoints();

  final double medium;
  final double expanded;
  final double large;

  AppBreakpoints copyWith({
    double? medium,
    double? expanded,
    double? large,
  }) {
    return AppBreakpoints(
      medium: medium ?? this.medium,
      expanded: expanded ?? this.expanded,
      large: large ?? this.large,
    );
  }

  AppWindowSize resolve(double width) {
    if (width < medium) {
      return AppWindowSize.compact;
    }
    if (width < expanded) {
      return AppWindowSize.medium;
    }
    if (width < large) {
      return AppWindowSize.expanded;
    }
    return AppWindowSize.large;
  }
}
