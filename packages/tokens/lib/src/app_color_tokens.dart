import 'package:flutter/material.dart';

@immutable
final class AppColorTokens {
  const AppColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceInverse,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.border,
    required this.borderStrong,
    required this.focus,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.disabled,
    required this.disabledForeground,
    required this.overlay,
    required this.shadow,
  });

  static const AppColorTokens light = AppColorTokens(
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDCE7FF),
    onPrimaryContainer: Color(0xFF102A66),
    secondary: Color(0xFF334155),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE2E8F0),
    onSecondaryContainer: Color(0xFF0F172A),
    background: Color(0xFFF8FAFC),
    onBackground: Color(0xFF0F172A),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF1F5F9),
    surfaceInverse: Color(0xFF0F172A),
    onSurface: Color(0xFF0F172A),
    onSurfaceMuted: Color(0xFF475569),
    border: Color(0xFFE2E8F0),
    borderStrong: Color(0xFFCBD5E1),
    focus: Color(0xFF2563EB),
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    error: Color(0xFFDC2626),
    info: Color(0xFF0284C7),
    disabled: Color(0xFF94A3B8),
    disabledForeground: Color(0xFFCBD5E1),
    overlay: Color(0x660F172A),
    shadow: Color(0x1A0F172A),
  );

  static const AppColorTokens dark = AppColorTokens(
    primary: Color(0xFF60A5FA),
    onPrimary: Color(0xFF0F172A),
    primaryContainer: Color(0xFF1E3A8A),
    onPrimaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFFCBD5E1),
    onSecondary: Color(0xFF0F172A),
    secondaryContainer: Color(0xFF1E293B),
    onSecondaryContainer: Color(0xFFE2E8F0),
    background: Color(0xFF020617),
    onBackground: Color(0xFFF8FAFC),
    surface: Color(0xFF0F172A),
    surfaceMuted: Color(0xFF111827),
    surfaceInverse: Color(0xFFF8FAFC),
    onSurface: Color(0xFFF8FAFC),
    onSurfaceMuted: Color(0xFF94A3B8),
    border: Color(0xFF1E293B),
    borderStrong: Color(0xFF334155),
    focus: Color(0xFF60A5FA),
    success: Color(0xFF4ADE80),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFF87171),
    info: Color(0xFF38BDF8),
    disabled: Color(0xFF334155),
    disabledForeground: Color(0xFF64748B),
    overlay: Color(0x99020617),
    shadow: Color(0x66000000),
  );

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color surfaceMuted;
  final Color surfaceInverse;
  final Color onSurface;
  final Color onSurfaceMuted;
  final Color border;
  final Color borderStrong;
  final Color focus;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color disabled;
  final Color disabledForeground;
  final Color overlay;
  final Color shadow;

  AppColorTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? surfaceMuted,
    Color? surfaceInverse,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? border,
    Color? borderStrong,
    Color? focus,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? disabled,
    Color? disabledForeground,
    Color? overlay,
    Color? shadow,
  }) {
    return AppColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      surfaceInverse: surfaceInverse ?? this.surfaceInverse,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      focus: focus ?? this.focus,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      overlay: overlay ?? this.overlay,
      shadow: shadow ?? this.shadow,
    );
  }

  static AppColorTokens lerp(AppColorTokens a, AppColorTokens b, double t) {
    return AppColorTokens(
      primary: Color.lerp(a.primary, b.primary, t) ?? a.primary,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t) ?? a.onPrimary,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t) ??
          a.primaryContainer,
      onPrimaryContainer:
          Color.lerp(a.onPrimaryContainer, b.onPrimaryContainer, t) ??
              a.onPrimaryContainer,
      secondary: Color.lerp(a.secondary, b.secondary, t) ?? a.secondary,
      onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t) ?? a.onSecondary,
      secondaryContainer:
          Color.lerp(a.secondaryContainer, b.secondaryContainer, t) ??
              a.secondaryContainer,
      onSecondaryContainer:
          Color.lerp(a.onSecondaryContainer, b.onSecondaryContainer, t) ??
              a.onSecondaryContainer,
      background: Color.lerp(a.background, b.background, t) ?? a.background,
      onBackground:
          Color.lerp(a.onBackground, b.onBackground, t) ?? a.onBackground,
      surface: Color.lerp(a.surface, b.surface, t) ?? a.surface,
      surfaceMuted:
          Color.lerp(a.surfaceMuted, b.surfaceMuted, t) ?? a.surfaceMuted,
      surfaceInverse:
          Color.lerp(a.surfaceInverse, b.surfaceInverse, t) ?? a.surfaceInverse,
      onSurface: Color.lerp(a.onSurface, b.onSurface, t) ?? a.onSurface,
      onSurfaceMuted:
          Color.lerp(a.onSurfaceMuted, b.onSurfaceMuted, t) ?? a.onSurfaceMuted,
      border: Color.lerp(a.border, b.border, t) ?? a.border,
      borderStrong:
          Color.lerp(a.borderStrong, b.borderStrong, t) ?? a.borderStrong,
      focus: Color.lerp(a.focus, b.focus, t) ?? a.focus,
      success: Color.lerp(a.success, b.success, t) ?? a.success,
      warning: Color.lerp(a.warning, b.warning, t) ?? a.warning,
      error: Color.lerp(a.error, b.error, t) ?? a.error,
      info: Color.lerp(a.info, b.info, t) ?? a.info,
      disabled: Color.lerp(a.disabled, b.disabled, t) ?? a.disabled,
      disabledForeground:
          Color.lerp(a.disabledForeground, b.disabledForeground, t) ??
              a.disabledForeground,
      overlay: Color.lerp(a.overlay, b.overlay, t) ?? a.overlay,
      shadow: Color.lerp(a.shadow, b.shadow, t) ?? a.shadow,
    );
  }
}
