import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

enum AppProgressVariant {
  linear,
  circular,
}

enum AppProgressSize {
  sm,
  md,
  lg,
}

class AppProgress extends StatelessWidget {
  const AppProgress({
    super.key,
    this.value,
    this.label,
    this.description,
    this.showValueLabel = true,
    this.size = AppProgressSize.md,
  }) : variant = AppProgressVariant.linear;

  const AppProgress.circular({
    super.key,
    this.value,
    this.label,
    this.description,
    this.showValueLabel = true,
    this.size = AppProgressSize.md,
  }) : variant = AppProgressVariant.circular;

  final AppProgressVariant variant;
  final double? value;
  final String? label;
  final String? description;
  final bool showValueLabel;
  final AppProgressSize size;

  @override
  Widget build(BuildContext context) {
    final clampedValue =
        value == null ? null : value!.clamp(0.0, 1.0).toDouble();

    return switch (variant) {
      AppProgressVariant.linear => _AppLinearProgress(
          value: clampedValue,
          label: label,
          description: description,
          showValueLabel: showValueLabel,
          size: size,
        ),
      AppProgressVariant.circular => _AppCircularProgress(
          value: clampedValue,
          label: label,
          description: description,
          showValueLabel: showValueLabel,
          size: size,
        ),
    };
  }
}

class _AppLinearProgress extends StatelessWidget {
  const _AppLinearProgress({
    required this.value,
    required this.label,
    required this.description,
    required this.showValueLabel,
    required this.size,
  });

  final double? value;
  final String? label;
  final String? description;
  final bool showValueLabel;
  final AppProgressSize size;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final style = _AppProgressSizeStyle.resolve(context, size);
    final percentageLabel = _formatPercent(value);

    return Semantics(
      label: label,
      value: percentageLabel ?? 'In progress',
      child: VStack(
        spacing: spacing.xs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null || (showValueLabel && percentageLabel != null))
            Row(
              children: <Widget>[
                if (label != null)
                  Expanded(
                    child: AppText.label(label!),
                  ),
                if (showValueLabel && percentageLabel != null)
                  AppText.label(
                    percentageLabel,
                    tone: AppTextTone.primary,
                  ),
              ],
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(context.appRadius.pill),
            child: LinearProgressIndicator(
              value: value,
              minHeight: style.linearHeight,
              backgroundColor: colors.surfaceMuted,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
          if (description != null)
            AppText.body(
              description!,
              variant: AppTextVariant.bodySmall,
              tone: AppTextTone.muted,
            ),
        ],
      ),
    );
  }
}

class _AppCircularProgress extends StatelessWidget {
  const _AppCircularProgress({
    required this.value,
    required this.label,
    required this.description,
    required this.showValueLabel,
    required this.size,
  });

  final double? value;
  final String? label;
  final String? description;
  final bool showValueLabel;
  final AppProgressSize size;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final style = _AppProgressSizeStyle.resolve(context, size);
    final percentageLabel = _formatPercent(value);

    final indicator = SizedBox.square(
      dimension: style.circularSize,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: style.strokeWidth,
        backgroundColor: colors.surfaceMuted,
        valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
      ),
    );

    if (label == null && description == null && !showValueLabel) {
      return indicator;
    }

    return Semantics(
      label: label,
      value: percentageLabel ?? 'In progress',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          indicator,
          SizedBox(width: spacing.md),
          Expanded(
            child: VStack(
              spacing: spacing.xxxs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (label != null ||
                    (showValueLabel && percentageLabel != null))
                  Row(
                    children: <Widget>[
                      if (label != null)
                        Expanded(
                          child: AppText.label(label!),
                        ),
                      if (showValueLabel && percentageLabel != null)
                        AppText.label(
                          percentageLabel,
                          tone: AppTextTone.primary,
                        ),
                    ],
                  ),
                if (description != null)
                  AppText.body(
                    description!,
                    variant: AppTextVariant.bodySmall,
                    tone: AppTextTone.muted,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppProgressSizeStyle {
  const _AppProgressSizeStyle({
    required this.linearHeight,
    required this.circularSize,
    required this.strokeWidth,
  });

  final double linearHeight;
  final double circularSize;
  final double strokeWidth;

  static _AppProgressSizeStyle resolve(
    BuildContext context,
    AppProgressSize size,
  ) {
    final spacing = context.appSpacing;
    final sizes = context.appSizes;

    return switch (size) {
      AppProgressSize.sm => _AppProgressSizeStyle(
          linearHeight: spacing.xxs + spacing.xxxs,
          circularSize: sizes.controlSm,
          strokeWidth: spacing.xxs,
        ),
      AppProgressSize.md => _AppProgressSizeStyle(
          linearHeight: spacing.xs,
          circularSize: sizes.controlMd,
          strokeWidth: spacing.xs / 2,
        ),
      AppProgressSize.lg => _AppProgressSizeStyle(
          linearHeight: spacing.sm,
          circularSize: sizes.controlLg,
          strokeWidth: spacing.xs,
        ),
    };
  }
}

String? _formatPercent(double? value) {
  if (value == null) {
    return null;
  }

  return '${(value * 100).round()}%';
}
