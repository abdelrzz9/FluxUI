import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.valueLabel,
    this.showValueLabel = true,
    this.enabled = true,
  }) : assert(min < max, 'min must be less than max.');

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String? valueLabel;
  final bool showValueLabel;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;

    final resolvedValueLabel = valueLabel ??
        (divisions != null
            ? value.toStringAsFixed(0)
            : value.toStringAsFixed(1));

    final slider = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: enabled ? colors.primary : colors.disabled,
        inactiveTrackColor: colors.surfaceMuted,
        thumbColor: enabled ? colors.primary : colors.disabled,
        overlayColor: Color.lerp(colors.primary, Colors.transparent, 0.88),
        valueIndicatorColor: colors.primary,
        valueIndicatorTextStyle: context.appTypography.labelSmall.copyWith(
          color: colors.onPrimary,
        ),
        trackHeight: spacing.xxs,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        label: showValueLabel ? resolvedValueLabel : null,
        onChanged: enabled ? onChanged : null,
      ),
    );

    if (label == null && !showValueLabel) return slider;

    return VStack(
      spacing: spacing.xxxs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null || showValueLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (label != null) AppText.label(label!),
              if (showValueLabel)
                AppText.label(
                  resolvedValueLabel,
                  tone: AppTextTone.primary,
                ),
            ],
          ),
        slider,
      ],
    );
  }
}
