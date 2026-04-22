import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
final class AppSizeTokens {
  const AppSizeTokens({
    required this.iconXs,
    required this.iconSm,
    required this.iconMd,
    required this.iconLg,
    required this.iconXl,
    required this.controlXs,
    required this.controlSm,
    required this.controlMd,
    required this.controlLg,
    required this.controlXl,
    required this.containerXs,
    required this.containerSm,
    required this.containerMd,
    required this.containerLg,
    required this.containerXl,
  });

  static const AppSizeTokens regular = AppSizeTokens(
    iconXs: 12,
    iconSm: 16,
    iconMd: 20,
    iconLg: 24,
    iconXl: 32,
    controlXs: 32,
    controlSm: 36,
    controlMd: 44,
    controlLg: 52,
    controlXl: 60,
    containerXs: 280,
    containerSm: 360,
    containerMd: 480,
    containerLg: 720,
    containerXl: 960,
  );

  final double iconXs;
  final double iconSm;
  final double iconMd;
  final double iconLg;
  final double iconXl;
  final double controlXs;
  final double controlSm;
  final double controlMd;
  final double controlLg;
  final double controlXl;
  final double containerXs;
  final double containerSm;
  final double containerMd;
  final double containerLg;
  final double containerXl;

  AppSizeTokens copyWith({
    double? iconXs,
    double? iconSm,
    double? iconMd,
    double? iconLg,
    double? iconXl,
    double? controlXs,
    double? controlSm,
    double? controlMd,
    double? controlLg,
    double? controlXl,
    double? containerXs,
    double? containerSm,
    double? containerMd,
    double? containerLg,
    double? containerXl,
  }) {
    return AppSizeTokens(
      iconXs: iconXs ?? this.iconXs,
      iconSm: iconSm ?? this.iconSm,
      iconMd: iconMd ?? this.iconMd,
      iconLg: iconLg ?? this.iconLg,
      iconXl: iconXl ?? this.iconXl,
      controlXs: controlXs ?? this.controlXs,
      controlSm: controlSm ?? this.controlSm,
      controlMd: controlMd ?? this.controlMd,
      controlLg: controlLg ?? this.controlLg,
      controlXl: controlXl ?? this.controlXl,
      containerXs: containerXs ?? this.containerXs,
      containerSm: containerSm ?? this.containerSm,
      containerMd: containerMd ?? this.containerMd,
      containerLg: containerLg ?? this.containerLg,
      containerXl: containerXl ?? this.containerXl,
    );
  }

  static AppSizeTokens lerp(AppSizeTokens a, AppSizeTokens b, double t) {
    return AppSizeTokens(
      iconXs: lerpDouble(a.iconXs, b.iconXs, t) ?? a.iconXs,
      iconSm: lerpDouble(a.iconSm, b.iconSm, t) ?? a.iconSm,
      iconMd: lerpDouble(a.iconMd, b.iconMd, t) ?? a.iconMd,
      iconLg: lerpDouble(a.iconLg, b.iconLg, t) ?? a.iconLg,
      iconXl: lerpDouble(a.iconXl, b.iconXl, t) ?? a.iconXl,
      controlXs: lerpDouble(a.controlXs, b.controlXs, t) ?? a.controlXs,
      controlSm: lerpDouble(a.controlSm, b.controlSm, t) ?? a.controlSm,
      controlMd: lerpDouble(a.controlMd, b.controlMd, t) ?? a.controlMd,
      controlLg: lerpDouble(a.controlLg, b.controlLg, t) ?? a.controlLg,
      controlXl: lerpDouble(a.controlXl, b.controlXl, t) ?? a.controlXl,
      containerXs: lerpDouble(a.containerXs, b.containerXs, t) ?? a.containerXs,
      containerSm: lerpDouble(a.containerSm, b.containerSm, t) ?? a.containerSm,
      containerMd: lerpDouble(a.containerMd, b.containerMd, t) ?? a.containerMd,
      containerLg: lerpDouble(a.containerLg, b.containerLg, t) ?? a.containerLg,
      containerXl: lerpDouble(a.containerXl, b.containerXl, t) ?? a.containerXl,
    );
  }
}
