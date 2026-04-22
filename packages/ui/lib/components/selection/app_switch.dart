import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.description,
    this.autofocus = false,
    this.contentPadding,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final resolvedPadding = contentPadding ??
        EdgeInsets.symmetric(
          horizontal: spacing.none,
          vertical: spacing.xs,
        );
    final switchControl = Switch(
      value: value,
      autofocus: autofocus,
      onChanged: onChanged,
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return context.appColors.disabledForeground;
        }

        if (states.contains(WidgetState.selected)) {
          return context.appColors.onPrimary;
        }

        return context.appColors.surface;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return context.appColors.disabled;
        }

        if (states.contains(WidgetState.selected)) {
          return context.appColors.primary;
        }

        return context.appColors.borderStrong;
      }),
      trackOutlineColor:
          const WidgetStatePropertyAll<Color>(Colors.transparent),
    );

    if (label == null && description == null) {
      return switchControl;
    }

    return Semantics(
      container: true,
      enabled: _isEnabled,
      toggled: value,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isEnabled ? () => onChanged!(!value) : null,
          borderRadius: BorderRadius.circular(context.appRadius.md),
          child: Padding(
            padding: resolvedPadding,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: VStack(
                    spacing: spacing.xxxs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (label != null)
                        AppText.label(
                          label!,
                          color: _isEnabled
                              ? context.appColors.onSurface
                              : context.appColors.disabledForeground,
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
                SizedBox(width: spacing.md),
                switchControl,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
