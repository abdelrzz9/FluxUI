import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
final class AppRadiusTokens {
  const AppRadiusTokens({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.pill,
  });

  static const AppRadiusTokens regular = AppRadiusTokens(
    none: 0,
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    pill: 999,
  );

  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double pill;

  AppRadiusTokens copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? pill,
  }) {
    return AppRadiusTokens(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      pill: pill ?? this.pill,
    );
  }

  static AppRadiusTokens lerp(AppRadiusTokens a, AppRadiusTokens b, double t) {
    return AppRadiusTokens(
      none: lerpDouble(a.none, b.none, t) ?? a.none,
      xs: lerpDouble(a.xs, b.xs, t) ?? a.xs,
      sm: lerpDouble(a.sm, b.sm, t) ?? a.sm,
      md: lerpDouble(a.md, b.md, t) ?? a.md,
      lg: lerpDouble(a.lg, b.lg, t) ?? a.lg,
      xl: lerpDouble(a.xl, b.xl, t) ?? a.xl,
      pill: lerpDouble(a.pill, b.pill, t) ?? a.pill,
    );
  }
}
