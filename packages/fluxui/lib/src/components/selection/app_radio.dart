import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
    this.description,
    this.contentPadding,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? description;
  final EdgeInsetsGeometry? contentPadding;

  bool get _isSelected => value == groupValue;
  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final resolvedPadding = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: spacing.none,
          vertical: spacing.xs,
        );

    final radioControl = _AppRadioControl(
      selected: _isSelected,
      enabled: _isEnabled,
    );

    if (label == null && description == null) return radioControl;

    return Semantics(
      container: true,
      enabled: _isEnabled,
      checked: _isSelected,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? () => onChanged!(value) : null,
          borderRadius: BorderRadius.circular(context.appRadius.md),
          child: Padding(
            padding: resolvedPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: spacing.xxs),
                  child: radioControl,
                ),
                SizedBox(width: spacing.sm),
                Expanded(
                  child: VStack(
                    spacing: spacing.xxxs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (label != null)
                        AppText.label(
                          label!,
                          color: _isEnabled
                              ? colors.onSurface
                              : colors.disabledForeground,
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
          ),
        ),
      ),
    );
  }
}

class _AppRadioControl extends StatelessWidget {
  const _AppRadioControl({
    required this.selected,
    required this.enabled,
  });

  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    const size = 20.0;
    final borderWidth = spacing.xxxs;

    final Color borderColor;
    final Color? fillColor;

    if (!enabled) {
      borderColor = colors.disabled;
      fillColor = null;
    } else if (selected) {
      borderColor = colors.primary;
      fillColor = colors.primary;
    } else {
      borderColor = colors.borderStrong;
      fillColor = null;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
        color: Colors.transparent,
      ),
      child: fillColor != null
          ? Center(
              child: Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: fillColor,
                ),
              ),
            )
          : null,
    );
  }
}

@immutable
class AppRadioItem<T> {
  const AppRadioItem({
    required this.value,
    required this.label,
    this.description,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? description;
  final bool enabled;
}

class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.direction = Axis.vertical,
  }) : assert(items.length > 0, 'items must not be empty.');

  final List<AppRadioItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final children = items
        .map(
          (item) => AppRadio<T>(
            value: item.value,
            groupValue: value,
            onChanged: item.enabled ? onChanged : null,
            label: item.label,
            description: item.description,
          ),
        )
        .toList();

    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: context.appSpacing.md,
        runSpacing: context.appSpacing.none,
        children: children,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
