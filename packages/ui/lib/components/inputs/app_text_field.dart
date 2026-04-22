import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

enum AppTextFieldVariant {
  outline,
  filled,
}

enum AppTextFieldSize {
  sm,
  md,
  lg,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.variant = AppTextFieldVariant.outline,
    this.size = AppTextFieldSize.md,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.style,
  }) : assert(
          controller == null || initialValue == null,
          'Provide either controller or initialValue.',
        );

  const AppTextField.outline({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.size = AppTextFieldSize.md,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.style,
  })  : variant = AppTextFieldVariant.outline,
        assert(
          controller == null || initialValue == null,
          'Provide either controller or initialValue.',
        );

  const AppTextField.filled({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.size = AppTextFieldSize.md,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.expands = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.style,
  })  : variant = AppTextFieldVariant.filled,
        assert(
          controller == null || initialValue == null,
          'Provide either controller or initialValue.',
        );

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final AppTextFieldVariant variant;
  final AppTextFieldSize size;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool expands;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double? borderRadius;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final sizeStyle = _AppTextFieldSizeStyle.resolve(context, size);
    final radius = BorderRadius.circular(borderRadius ?? context.appRadius.md);
    final borderWidth = spacing.xxxs / 2;
    final resolvedStyle = sizeStyle.textStyle
        .copyWith(color: enabled ? colors.onSurface : colors.disabledForeground)
        .merge(style);
    final outline = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: colors.border,
        width: borderWidth,
      ),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      autofocus: autofocus,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      expands: expands,
      minLines: expands ? null : minLines,
      maxLines: expands ? null : maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: resolvedStyle,
      cursorColor: colors.primary,
      decoration: InputDecoration(
        isDense: true,
        filled: variant == AppTextFieldVariant.filled,
        fillColor: variant == AppTextFieldVariant.filled
            ? colors.surfaceMuted
            : colors.surface,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: prefix,
        suffix: suffix,
        contentPadding: EdgeInsets.symmetric(
          horizontal: sizeStyle.horizontalPadding,
          vertical: sizeStyle.verticalPadding,
        ),
        labelStyle: typography.labelLarge.copyWith(
          color: colors.onSurfaceMuted,
        ),
        hintStyle: typography.bodyMedium.copyWith(
          color: colors.onSurfaceMuted,
        ),
        helperStyle: typography.bodySmall.copyWith(
          color: colors.onSurfaceMuted,
        ),
        errorStyle: typography.bodySmall.copyWith(
          color: colors.error,
        ),
        border: outline,
        enabledBorder: outline,
        disabledBorder: outline.copyWith(
          borderSide: BorderSide(
            color: colors.disabled,
            width: borderWidth,
          ),
        ),
        focusedBorder: outline.copyWith(
          borderSide: BorderSide(
            color: colors.focus,
            width: borderWidth,
          ),
        ),
        errorBorder: outline.copyWith(
          borderSide: BorderSide(
            color: colors.error,
            width: borderWidth,
          ),
        ),
        focusedErrorBorder: outline.copyWith(
          borderSide: BorderSide(
            color: colors.error,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}

class _AppTextFieldSizeStyle {
  const _AppTextFieldSizeStyle({
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.textStyle,
  });

  final double horizontalPadding;
  final double verticalPadding;
  final TextStyle textStyle;

  static _AppTextFieldSizeStyle resolve(
    BuildContext context,
    AppTextFieldSize size,
  ) {
    final spacing = context.appSpacing;
    final typography = context.appTypography;

    return switch (size) {
      AppTextFieldSize.sm => _AppTextFieldSizeStyle(
          horizontalPadding: spacing.sm,
          verticalPadding: spacing.xs,
          textStyle: typography.bodySmall,
        ),
      AppTextFieldSize.md => _AppTextFieldSizeStyle(
          horizontalPadding: spacing.md,
          verticalPadding: spacing.sm,
          textStyle: typography.bodyMedium,
        ),
      AppTextFieldSize.lg => _AppTextFieldSizeStyle(
          horizontalPadding: spacing.lg,
          verticalPadding: spacing.md,
          textStyle: typography.bodyLarge,
        ),
    };
  }
}
