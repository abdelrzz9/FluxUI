final class ComponentDefinition {
  const ComponentDefinition({
    required this.id,
    required this.outputPath,
    required this.publicSymbols,
    required this.template,
    this.aliases = const <String>[],
    this.dependencies = const <String>[],
    this.description = '',
  });

  final String id;
  final List<String> aliases;
  final String outputPath;
  final List<String> dependencies;
  final List<String> publicSymbols;
  final String description;
  final String template;
}

final class ComponentRegistry {
  ComponentRegistry._();

  static const Map<String, ComponentDefinition> definitions =
      <String, ComponentDefinition>{
    'button': ComponentDefinition(
      id: 'button',
      aliases: <String>['app_button'],
      outputPath: 'buttons/app_button.dart',
      publicSymbols: <String>[
        'AppButton',
        'AppButtonVariant',
        'AppButtonSize',
      ],
      description:
          'Primary action button with variants, sizes, and loading state.',
      template: _buttonTemplate,
    ),
    'card': ComponentDefinition(
      id: 'card',
      aliases: <String>['app_card'],
      outputPath: 'cards/app_card.dart',
      publicSymbols: <String>['AppCard', 'AppCardVariant'],
      description: 'Surface container with outline and muted variants.',
      template: _cardTemplate,
    ),
    'text': ComponentDefinition(
      id: 'text',
      aliases: <String>['app_text', 'typography'],
      outputPath: 'typography/app_text.dart',
      publicSymbols: <String>[
        'AppText',
        'AppTextVariant',
        'AppTextTone',
      ],
      description:
          'Token-driven text widget with semantic tone and type scale.',
      template: _textTemplate,
    ),
    'text-field': ComponentDefinition(
      id: 'text-field',
      aliases: <String>['textfield', 'input', 'app_text_field'],
      outputPath: 'inputs/app_text_field.dart',
      publicSymbols: <String>[
        'AppTextField',
        'AppTextFieldVariant',
        'AppTextFieldSize',
      ],
      description: 'Form field with outline and filled variants.',
      template: _textFieldTemplate,
    ),
    'gap': ComponentDefinition(
      id: 'gap',
      outputPath: 'layouts/gap.dart',
      publicSymbols: <String>['Gap'],
      description: 'Axis-aware spacer primitive.',
      template: _gapTemplate,
    ),
    'h-stack': ComponentDefinition(
      id: 'h-stack',
      aliases: <String>['hstack'],
      outputPath: 'layouts/h_stack.dart',
      dependencies: <String>['gap'],
      publicSymbols: <String>['HStack'],
      description: 'Horizontal stack that inserts gaps between children.',
      template: _hStackTemplate,
    ),
    'v-stack': ComponentDefinition(
      id: 'v-stack',
      aliases: <String>['vstack'],
      outputPath: 'layouts/v_stack.dart',
      dependencies: <String>['gap'],
      publicSymbols: <String>['VStack'],
      description: 'Vertical stack that inserts gaps between children.',
      template: _vStackTemplate,
    ),
  };

  static ComponentDefinition? resolve(String rawName) {
    final normalized = rawName.trim().toLowerCase();

    for (final definition in definitions.values) {
      if (definition.id == normalized ||
          definition.aliases.contains(normalized)) {
        return definition;
      }
    }

    return null;
  }

  static List<ComponentDefinition> available() {
    final items = definitions.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    return items;
  }
}

const String _buttonTemplate = r'''
import 'package:flutter/material.dart';

import '../../core/flutter_ui.dart';

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

enum AppButtonSize {
  sm,
  md,
  lg,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.text,
    this.child,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
    this.borderRadius,
    this.semanticLabel,
  }) : assert(
         (text != null) != (child != null),
         'Provide either text or child.',
       );

  const AppButton.primary({
    super.key,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.text,
    this.child,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
    this.borderRadius,
    this.semanticLabel,
  }) : variant = AppButtonVariant.primary,
       assert(
         (text != null) != (child != null),
         'Provide either text or child.',
       );

  const AppButton.secondary({
    super.key,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.text,
    this.child,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
    this.borderRadius,
    this.semanticLabel,
  }) : variant = AppButtonVariant.secondary,
       assert(
         (text != null) != (child != null),
         'Provide either text or child.',
       );

  const AppButton.outline({
    super.key,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.text,
    this.child,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
    this.borderRadius,
    this.semanticLabel,
  }) : variant = AppButtonVariant.outline,
       assert(
         (text != null) != (child != null),
         'Provide either text or child.',
       );

  const AppButton.ghost({
    super.key,
    this.size = AppButtonSize.md,
    this.onPressed,
    this.text,
    this.child,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.expand = false,
    this.borderRadius,
    this.semanticLabel,
  }) : variant = AppButtonVariant.ghost,
       assert(
         (text != null) != (child != null),
         'Provide either text or child.',
       );

  final AppButtonVariant variant;
  final AppButtonSize size;
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool expand;
  final double? borderRadius;
  final String? semanticLabel;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final shapeRadius = BorderRadius.circular(
      borderRadius ?? context.appRadius.md,
    );
    final visualStyle = _AppButtonVisualStyle.resolve(
      context: context,
      variant: variant,
      enabled: _isEnabled,
    );
    final sizeStyle = _AppButtonSizeStyle.resolve(context, size);
    final borderWidth = spacing.xxxs / 2;
    final content = _AppButtonContent(
      text: text,
      child: child,
      leading: leading,
      trailing: trailing,
      isLoading: isLoading,
      foregroundColor: visualStyle.foregroundColor,
      indicatorStrokeWidth: borderWidth,
      gap: sizeStyle.gap,
      iconSize: sizeStyle.iconSize,
      labelStyle: sizeStyle.labelStyle.copyWith(
        color: visualStyle.foregroundColor,
      ),
    );

    return Semantics(
      button: true,
      enabled: _isEnabled,
      label: semanticLabel ?? text,
      child: SizedBox(
        width: expand ? double.infinity : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: sizeStyle.height,
            minWidth: sizeStyle.height,
          ),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: visualStyle.backgroundColor,
                borderRadius: shapeRadius,
                border:
                    visualStyle.borderColor == null
                        ? null
                        : Border.all(
                          color: visualStyle.borderColor!,
                          width: borderWidth,
                        ),
              ),
              child: InkWell(
                onTap: _isEnabled ? onPressed : null,
                borderRadius: shapeRadius,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizeStyle.horizontalPadding,
                    vertical: sizeStyle.verticalPadding,
                  ),
                  child: content,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppButtonContent extends StatelessWidget {
  const _AppButtonContent({
    required this.text,
    required this.child,
    required this.leading,
    required this.trailing,
    required this.isLoading,
    required this.foregroundColor,
    required this.indicatorStrokeWidth,
    required this.gap,
    required this.iconSize,
    required this.labelStyle,
  });

  final String? text;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final Color foregroundColor;
  final double indicatorStrokeWidth;
  final double gap;
  final double iconSize;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    final pieces = <Widget>[
      if (isLoading) ...[
        SizedBox.square(
          dimension: iconSize,
          child: CircularProgressIndicator(
            strokeWidth: indicatorStrokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        ),
      ] else if (leading != null) ...[
        IconTheme.merge(
          data: IconThemeData(
            color: foregroundColor,
            size: iconSize,
          ),
          child: leading!,
        ),
      ],
      if (isLoading || leading != null) SizedBox(width: gap),
      DefaultTextStyle(
        style: labelStyle,
        child:
            child ??
            Text(
              text!,
              textAlign: TextAlign.center,
            ),
      ),
      if (trailing != null) ...[
        SizedBox(width: gap),
        IconTheme.merge(
          data: IconThemeData(
            color: foregroundColor,
            size: iconSize,
          ),
          child: trailing!,
        ),
      ],
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: pieces,
    );
  }
}

class _AppButtonVisualStyle {
  const _AppButtonVisualStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });

  final Color? backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  static _AppButtonVisualStyle resolve({
    required BuildContext context,
    required AppButtonVariant variant,
    required bool enabled,
  }) {
    final colors = context.appColors;

    if (!enabled) {
      return _AppButtonVisualStyle(
        backgroundColor:
            variant == AppButtonVariant.ghost ? null : colors.disabled,
        foregroundColor: colors.disabledForeground,
        borderColor:
            variant == AppButtonVariant.outline ? colors.disabled : null,
      );
    }

    return switch (variant) {
      AppButtonVariant.primary => _AppButtonVisualStyle(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      AppButtonVariant.secondary => _AppButtonVisualStyle(
        backgroundColor: colors.secondaryContainer,
        foregroundColor: colors.onSecondaryContainer,
      ),
      AppButtonVariant.outline => _AppButtonVisualStyle(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        borderColor: colors.borderStrong,
      ),
      AppButtonVariant.ghost => _AppButtonVisualStyle(
        backgroundColor: null,
        foregroundColor: colors.onSurface,
      ),
    };
  }
}

class _AppButtonSizeStyle {
  const _AppButtonSizeStyle({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.gap,
    required this.iconSize,
    required this.labelStyle,
  });

  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double gap;
  final double iconSize;
  final TextStyle labelStyle;

  static _AppButtonSizeStyle resolve(
    BuildContext context,
    AppButtonSize size,
  ) {
    final spacing = context.appSpacing;
    final sizes = context.appSizes;
    final typography = context.appTypography;

    return switch (size) {
      AppButtonSize.sm => _AppButtonSizeStyle(
        height: sizes.controlSm,
        horizontalPadding: spacing.sm,
        verticalPadding: spacing.xs,
        gap: spacing.xs,
        iconSize: sizes.iconSm,
        labelStyle: typography.labelMedium,
      ),
      AppButtonSize.md => _AppButtonSizeStyle(
        height: sizes.controlMd,
        horizontalPadding: spacing.md,
        verticalPadding: spacing.sm,
        gap: spacing.xs,
        iconSize: sizes.iconMd,
        labelStyle: typography.labelLarge,
      ),
      AppButtonSize.lg => _AppButtonSizeStyle(
        height: sizes.controlLg,
        horizontalPadding: spacing.lg,
        verticalPadding: spacing.md,
        gap: spacing.sm,
        iconSize: sizes.iconLg,
        labelStyle: typography.titleSmall,
      ),
    };
  }
}
''';

const String _cardTemplate = r'''
import 'package:flutter/material.dart';

import '../../core/flutter_ui.dart';

enum AppCardVariant {
  surface,
  outline,
  muted,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.surface,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  });

  const AppCard.outlined({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.outline;

  const AppCard.muted({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
  }) : variant = AppCardVariant.muted;

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final radius = BorderRadius.circular(borderRadius ?? context.appRadius.lg);
    final borderWidth = spacing.xxxs / 2;
    final resolvedPadding = padding ?? EdgeInsets.all(spacing.lg);
    final surfaceColor = switch (variant) {
      AppCardVariant.surface => colors.surface,
      AppCardVariant.outline => colors.surface,
      AppCardVariant.muted => colors.surfaceMuted,
    };
    final borderColor = switch (variant) {
      AppCardVariant.surface => colors.border,
      AppCardVariant.outline => colors.borderStrong,
      AppCardVariant.muted => colors.border,
    };
    final content = Padding(
      padding: resolvedPadding,
      child: child,
    );

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        clipBehavior: clipBehavior,
        shape: RoundedRectangleBorder(borderRadius: radius),
        child: Ink(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: radius,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          child:
              onTap == null
                  ? content
                  : InkWell(
                    onTap: onTap,
                    borderRadius: radius,
                    child: content,
                  ),
        ),
      ),
    );
  }
}
''';

const String _textTemplate = r'''
import 'package:flutter/material.dart';

import '../../core/flutter_ui.dart';

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
''';

const String _textFieldTemplate = r'''
import 'package:flutter/material.dart';

import '../../core/flutter_ui.dart';

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
  }) : variant = AppTextFieldVariant.outline,
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
  }) : variant = AppTextFieldVariant.filled,
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
        fillColor:
            variant == AppTextFieldVariant.filled
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
''';

const String _gapTemplate = r'''
import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  const Gap(
    this.size, {
    super.key,
    this.axis = Axis.vertical,
  });

  const Gap.horizontal(
    this.size, {
    super.key,
  }) : axis = Axis.horizontal;

  const Gap.vertical(
    this.size, {
    super.key,
  }) : axis = Axis.vertical;

  final double size;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: axis == Axis.horizontal ? size : null,
      height: axis == Axis.vertical ? size : null,
    );
  }
}
''';

const String _hStackTemplate = r'''
import 'package:flutter/widgets.dart';

import 'gap.dart';

class HStack extends StatelessWidget {
  const HStack({
    super.key,
    required this.children,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: _withGaps(children, spacing, Axis.horizontal),
    );
  }
}

List<Widget> _withGaps(
  List<Widget> children,
  double spacing,
  Axis axis,
) {
  if (children.length < 2 || spacing <= 0) {
    return children;
  }

  return List<Widget>.generate(
    children.length * 2 - 1,
    (index) {
      if (index.isEven) {
        return children[index ~/ 2];
      }

      return Gap(
        spacing,
        axis: axis,
      );
    },
  );
}
''';

const String _vStackTemplate = r'''
import 'package:flutter/widgets.dart';

import 'gap.dart';

class VStack extends StatelessWidget {
  const VStack({
    super.key,
    required this.children,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: _withGaps(children, spacing),
    );
  }

  List<Widget> _withGaps(List<Widget> children, double spacing) {
    if (children.length < 2 || spacing <= 0) {
      return children;
    }

    return List<Widget>.generate(
      children.length * 2 - 1,
      (index) {
        if (index.isEven) {
          return children[index ~/ 2];
        }

        return Gap.vertical(spacing);
      },
    );
  }
}
''';
