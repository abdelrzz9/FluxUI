import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.description,
    this.tristate = false,
    this.autofocus = false,
    this.contentPadding,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final String? description;
  final bool tristate;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

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
    final checkboxControl = Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(
            color: _isEnabled ? colors.borderStrong : colors.disabled,
            width: spacing.xxxs / 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.appRadius.xs),
          ),
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return colors.disabled;
            }

            if (states.contains(WidgetState.selected)) {
              return colors.primary;
            }

            return colors.surface;
          }),
          checkColor: WidgetStatePropertyAll<Color>(colors.onPrimary),
        ),
      ),
      child: Checkbox(
        value: value,
        tristate: tristate,
        autofocus: autofocus,
        onChanged: onChanged,
      ),
    );

    if (label == null && description == null) {
      return checkboxControl;
    }

    return Semantics(
      container: true,
      enabled: _isEnabled,
      checked: value == true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? () => onChanged!(_nextValue()) : null,
          borderRadius: BorderRadius.circular(context.appRadius.md),
          child: Padding(
            padding: resolvedPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                checkboxControl,
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

  bool? _nextValue() {
    if (!tristate) {
      return !(value ?? false);
    }

    if (value == null) {
      return true;
    }

    if (value == true) {
      return false;
    }

    return null;
  }
}
