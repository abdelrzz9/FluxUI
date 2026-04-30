import 'package:flutter/material.dart';

import '../extensions/app_theme_context_extensions.dart';

enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

enum AppTextTone {
  foreground,
  muted,
  primary,
  success,
  warning,
  danger,
  inverse,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  const AppText.display(
    this.data, {
    super.key,
    this.variant = AppTextVariant.displayLarge,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  const AppText.headline(
    this.data, {
    super.key,
    this.variant = AppTextVariant.headlineMedium,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  const AppText.title(
    this.data, {
    super.key,
    this.variant = AppTextVariant.titleLarge,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  const AppText.body(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  const AppText.label(
    this.data, {
    super.key,
    this.variant = AppTextVariant.labelLarge,
    this.tone = AppTextTone.foreground,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textScaler,
    this.style,
    this.color,
    this.semanticsLabel,
  });

  final String data;
  final AppTextVariant variant;
  final AppTextTone tone;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextScaler? textScaler;
  final TextStyle? style;
  final Color? color;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = _resolveBaseStyle(context)
        .copyWith(color: color ?? _resolveToneColor(context))
        .merge(style);

    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textScaler: textScaler,
      semanticsLabel: semanticsLabel,
      style: resolvedStyle,
    );
  }

  TextStyle _resolveBaseStyle(BuildContext context) {
    final typography = context.appTypography;

    return switch (variant) {
      AppTextVariant.displayLarge => typography.displayLarge,
      AppTextVariant.displayMedium => typography.displayMedium,
      AppTextVariant.displaySmall => typography.displaySmall,
      AppTextVariant.headlineLarge => typography.headlineLarge,
      AppTextVariant.headlineMedium => typography.headlineMedium,
      AppTextVariant.headlineSmall => typography.headlineSmall,
      AppTextVariant.titleLarge => typography.titleLarge,
      AppTextVariant.titleMedium => typography.titleMedium,
      AppTextVariant.titleSmall => typography.titleSmall,
      AppTextVariant.bodyLarge => typography.bodyLarge,
      AppTextVariant.bodyMedium => typography.bodyMedium,
      AppTextVariant.bodySmall => typography.bodySmall,
      AppTextVariant.labelLarge => typography.labelLarge,
      AppTextVariant.labelMedium => typography.labelMedium,
      AppTextVariant.labelSmall => typography.labelSmall,
    };
  }

  Color _resolveToneColor(BuildContext context) {
    final colors = context.appColors;

    return switch (tone) {
      AppTextTone.foreground => colors.onSurface,
      AppTextTone.muted => colors.onSurfaceMuted,
      AppTextTone.primary => colors.primary,
      AppTextTone.success => colors.success,
      AppTextTone.warning => colors.warning,
      AppTextTone.danger => colors.error,
      AppTextTone.inverse => colors.surface,
    };
  }
}
