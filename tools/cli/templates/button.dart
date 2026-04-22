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
