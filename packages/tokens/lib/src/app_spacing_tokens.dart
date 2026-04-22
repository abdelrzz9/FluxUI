import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
final class AppSpacingTokens {
  const AppSpacingTokens({
    required this.none,
    required this.xxxs,
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.x2l,
    required this.x3l,
    required this.x4l,
    required this.x5l,
  });

  static const AppSpacingTokens regular = AppSpacingTokens(
    none: 0,
    xxxs: 2,
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 24,
    x2l: 32,
    x3l: 40,
    x4l: 48,
    x5l: 64,
  );

  final double none;
  final double xxxs;
  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double x2l;
  final double x3l;
  final double x4l;
  final double x5l;

  AppSpacingTokens copyWith({
    double? none,
    double? xxxs,
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? x2l,
    double? x3l,
    double? x4l,
    double? x5l,
  }) {
    return AppSpacingTokens(
      none: none ?? this.none,
      xxxs: xxxs ?? this.xxxs,
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      x2l: x2l ?? this.x2l,
      x3l: x3l ?? this.x3l,
      x4l: x4l ?? this.x4l,
      x5l: x5l ?? this.x5l,
    );
  }

  static AppSpacingTokens lerp(
    AppSpacingTokens a,
    AppSpacingTokens b,
    double t,
  ) {
    return AppSpacingTokens(
      none: lerpDouble(a.none, b.none, t) ?? a.none,
      xxxs: lerpDouble(a.xxxs, b.xxxs, t) ?? a.xxxs,
      xxs: lerpDouble(a.xxs, b.xxs, t) ?? a.xxs,
      xs: lerpDouble(a.xs, b.xs, t) ?? a.xs,
      sm: lerpDouble(a.sm, b.sm, t) ?? a.sm,
      md: lerpDouble(a.md, b.md, t) ?? a.md,
      lg: lerpDouble(a.lg, b.lg, t) ?? a.lg,
      xl: lerpDouble(a.xl, b.xl, t) ?? a.xl,
      x2l: lerpDouble(a.x2l, b.x2l, t) ?? a.x2l,
      x3l: lerpDouble(a.x3l, b.x3l, t) ?? a.x3l,
      x4l: lerpDouble(a.x4l, b.x4l, t) ?? a.x4l,
      x5l: lerpDouble(a.x5l, b.x5l, t) ?? a.x5l,
    );
  }
}
