import 'package:flutter/widgets.dart';

@immutable
final class AppTypographyTokens {
  const AppTypographyTokens({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  static const AppTypographyTokens regular = AppTypographyTokens(
    displayLarge: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 56 / 48,
      letterSpacing: -1.2,
    ),
    displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 48 / 40,
      letterSpacing: -0.8,
    ),
    displaySmall: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 40 / 32,
      letterSpacing: -0.4,
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 36 / 28,
      letterSpacing: -0.4,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 32 / 24,
      letterSpacing: -0.2,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 28 / 20,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 26 / 18,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 24 / 16,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 20 / 14,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 20 / 14,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 16 / 11,
      letterSpacing: 0.3,
    ),
  );

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  AppTypographyTokens copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return AppTypographyTokens(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  static AppTypographyTokens lerp(
    AppTypographyTokens a,
    AppTypographyTokens b,
    double t,
  ) {
    return AppTypographyTokens(
      displayLarge:
          TextStyle.lerp(a.displayLarge, b.displayLarge, t) ?? a.displayLarge,
      displayMedium: TextStyle.lerp(a.displayMedium, b.displayMedium, t) ??
          a.displayMedium,
      displaySmall:
          TextStyle.lerp(a.displaySmall, b.displaySmall, t) ?? a.displaySmall,
      headlineLarge: TextStyle.lerp(a.headlineLarge, b.headlineLarge, t) ??
          a.headlineLarge,
      headlineMedium: TextStyle.lerp(a.headlineMedium, b.headlineMedium, t) ??
          a.headlineMedium,
      headlineSmall: TextStyle.lerp(a.headlineSmall, b.headlineSmall, t) ??
          a.headlineSmall,
      titleLarge: TextStyle.lerp(a.titleLarge, b.titleLarge, t) ?? a.titleLarge,
      titleMedium:
          TextStyle.lerp(a.titleMedium, b.titleMedium, t) ?? a.titleMedium,
      titleSmall: TextStyle.lerp(a.titleSmall, b.titleSmall, t) ?? a.titleSmall,
      bodyLarge: TextStyle.lerp(a.bodyLarge, b.bodyLarge, t) ?? a.bodyLarge,
      bodyMedium: TextStyle.lerp(a.bodyMedium, b.bodyMedium, t) ?? a.bodyMedium,
      bodySmall: TextStyle.lerp(a.bodySmall, b.bodySmall, t) ?? a.bodySmall,
      labelLarge: TextStyle.lerp(a.labelLarge, b.labelLarge, t) ?? a.labelLarge,
      labelMedium:
          TextStyle.lerp(a.labelMedium, b.labelMedium, t) ?? a.labelMedium,
      labelSmall: TextStyle.lerp(a.labelSmall, b.labelSmall, t) ?? a.labelSmall,
    );
  }
}
