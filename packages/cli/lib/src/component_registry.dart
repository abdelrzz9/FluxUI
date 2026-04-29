import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;

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

  static final Map<String, ComponentDefinition> definitions =
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
      template: _buttonTemplate(),
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
    'alert': ComponentDefinition(
      id: 'alert',
      aliases: <String>['app_alert'],
      outputPath: 'feedback/app_alert.dart',
      dependencies: <String>['text', 'v-stack'],
      publicSymbols: <String>['AppAlert', 'AppAlertVariant'],
      description:
          'Alert banner with info, success, warning, danger, and neutral variants.',
      template: _alertTemplate,
    ),
    'carousel': ComponentDefinition(
      id: 'carousel',
      aliases: <String>['app_carousel', 'slider'],
      outputPath: 'display/app_carousel.dart',
      dependencies: <String>['card'],
      publicSymbols: <String>['AppCarousel'],
      description: 'Paginated carousel with optional controls and indicators.',
      template: _carouselTemplate,
    ),
    'checkbox': ComponentDefinition(
      id: 'checkbox',
      aliases: <String>['app_checkbox'],
      outputPath: 'selection/app_checkbox.dart',
      dependencies: <String>['text', 'v-stack'],
      publicSymbols: <String>['AppCheckbox'],
      description: 'Checkbox control with optional label and description.',
      template: _checkboxTemplate,
    ),
    'combobox': ComponentDefinition(
      id: 'combobox',
      aliases: <String>['app_combobox', 'select', 'dropdown'],
      outputPath: 'inputs/app_combobox.dart',
      dependencies: <String>['card', 'text', 'text-field', 'v-stack'],
      publicSymbols: <String>['AppCombobox', 'AppComboboxOption'],
      description: 'Searchable bottom-sheet select with typed options.',
      template: _comboboxTemplate,
    ),
    'navigation-menu': ComponentDefinition(
      id: 'navigation-menu',
      aliases: <String>['nav-menu', 'app_navigation_menu'],
      outputPath: 'navigation/app_navigation_menu.dart',
      dependencies: <String>['card', 'text', 'v-stack'],
      publicSymbols: <String>['AppNavigationMenu', 'AppNavigationMenuItem'],
      description: 'Horizontal tab-style navigation menu with panel content.',
      template: _navigationMenuTemplate,
    ),
    'otp-field': ComponentDefinition(
      id: 'otp-field',
      aliases: <String>['otp', 'app_otp_field'],
      outputPath: 'inputs/app_otp_field.dart',
      dependencies: <String>[],
      publicSymbols: <String>['AppOtpField'],
      description:
          'One-time-password input with per-digit cells and paste support.',
      template: _otpFieldTemplate,
    ),
    'pagination': ComponentDefinition(
      id: 'pagination',
      aliases: <String>['app_pagination', 'pages'],
      outputPath: 'navigation/app_pagination.dart',
      dependencies: <String>['text'],
      publicSymbols: <String>['AppPagination'],
      description: 'Numeric page controls with ellipsis and sibling range.',
      template: _paginationTemplate,
    ),
    'progress': ComponentDefinition(
      id: 'progress',
      aliases: <String>['app_progress', 'progressbar'],
      outputPath: 'feedback/app_progress.dart',
      dependencies: <String>['text', 'v-stack'],
      publicSymbols: <String>[
        'AppProgress',
        'AppProgressVariant',
        'AppProgressSize'
      ],
      description:
          'Linear and circular progress indicators with label and size variants.',
      template: _progressTemplate,
    ),
    'roadmap-item': ComponentDefinition(
      id: 'roadmap-item',
      aliases: <String>['roadmap', 'app_roadmap_item'],
      outputPath: 'roadmap/app_roadmap_item.dart',
      dependencies: <String>['text'],
      publicSymbols: <String>['AppRoadmapItem', 'AppRoadmapItemState'],
      description: 'Roadmap row with state icon, kind badge, and metadata.',
      template: _roadmapItemTemplate,
    ),
    'switch': ComponentDefinition(
      id: 'switch',
      aliases: <String>['app_switch', 'toggle'],
      outputPath: 'selection/app_switch.dart',
      dependencies: <String>['text', 'v-stack'],
      publicSymbols: <String>['AppSwitch'],
      description: 'Toggle switch with optional label and description.',
      template: _switchTemplate,
    ),
    'tabs': ComponentDefinition(
      id: 'tabs',
      aliases: <String>['app_tabs'],
      outputPath: 'navigation/app_tabs.dart',
      dependencies: <String>['card', 'text', 'v-stack'],
      publicSymbols: <String>['AppTabs', 'AppTabItem'],
      description: 'Tab bar with optional panel content and badge support.',
      template: _tabsTemplate,
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

String _buttonTemplate() => _loadTemplate(
      'button.dart',
      fallback: _buttonTemplateFallback,
    );

String _loadTemplate(
  String fileName, {
  required String fallback,
}) {
  final templateFile = io.File(
    p.join(_packageRootDirectory.path, 'templates', fileName),
  );

  if (templateFile.existsSync()) {
    return templateFile.readAsStringSync();
  }

  return fallback;
}

io.Directory _resolvePackageRootDirectory() {
  final packageConfigPath = io.Platform.packageConfig;
  if (packageConfigPath == null || packageConfigPath.isEmpty) {
    return io.Directory.current;
  }

  final packageConfigUri = Uri.parse(packageConfigPath);
  final packageConfigFile = packageConfigUri.scheme.isEmpty
      ? io.File(packageConfigPath)
      : io.File.fromUri(packageConfigUri);
  final packageConfig = jsonDecode(
    packageConfigFile.readAsStringSync(),
  ) as Map<String, dynamic>;
  final packages =
      (packageConfig['packages'] as List<dynamic>? ?? const <dynamic>[])
          .cast<Map<String, dynamic>>();
  final package = packages.firstWhere(
    (entry) => entry['name'] == 'flutter_ui_cli',
    orElse: () => <String, dynamic>{},
  );

  final rootUriValue = package['rootUri'] as String? ?? '.';
  final rootUri = Uri.parse(rootUriValue);
  return io.Directory.fromUri(packageConfigFile.uri.resolveUri(rootUri));
}

final io.Directory _packageRootDirectory = _resolvePackageRootDirectory();

const String _buttonTemplateFallback = r'''
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

const String _alertTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

enum AppAlertVariant {
  info,
  success,
  warning,
  danger,
  neutral,
}

class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
    this.variant = AppAlertVariant.info,
  });

  const AppAlert.info({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.info;

  const AppAlert.success({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.success;

  const AppAlert.warning({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.warning;

  const AppAlert.danger({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.danger;

  const AppAlert.neutral({
    super.key,
    required this.title,
    this.description,
    this.action,
    this.child,
    this.icon,
  }) : variant = AppAlertVariant.neutral;

  final String title;
  final String? description;
  final Widget? action;
  final Widget? child;
  final IconData? icon;
  final AppAlertVariant variant;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final style = _AppAlertStyle.resolve(colors, variant);
    final radius = BorderRadius.circular(context.appRadius.lg);
    final borderWidth = spacing.xxxs / 2;
    final resolvedIcon = icon ?? style.icon;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: style.background,
          borderRadius: radius,
          border: Border.all(
            color: style.border,
            width: borderWidth,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(spacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: style.iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spacing.xs),
                  child: Icon(
                    resolvedIcon,
                    size: context.appSizes.iconSm,
                    color: style.foreground,
                  ),
                ),
              ),
              SizedBox(width: spacing.md),
              Expanded(
                child: VStack(
                  spacing: spacing.xs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText.title(
                      title,
                      variant: AppTextVariant.titleMedium,
                      color: colors.onSurface,
                    ),
                    if (description != null)
                      AppText.body(
                        description!,
                        tone: AppTextTone.muted,
                      ),
                    if (child != null) child!,
                  ],
                ),
              ),
              if (action != null) ...[
                SizedBox(width: spacing.md),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AppAlertStyle {
  const _AppAlertStyle({
    required this.foreground,
    required this.background,
    required this.iconBackground,
    required this.border,
    required this.icon,
  });

  final Color foreground;
  final Color background;
  final Color iconBackground;
  final Color border;
  final IconData icon;

  static _AppAlertStyle resolve(
    AppColorTokens colors,
    AppAlertVariant variant,
  ) {
    return switch (variant) {
      AppAlertVariant.info => _AppAlertStyle(
          foreground: colors.info,
          background: Color.lerp(colors.surface, colors.info, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.info, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.info, 0.32)!,
          icon: Icons.info_outline_rounded,
        ),
      AppAlertVariant.success => _AppAlertStyle(
          foreground: colors.success,
          background: Color.lerp(colors.surface, colors.success, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.success, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.success, 0.32)!,
          icon: Icons.check_circle_outline_rounded,
        ),
      AppAlertVariant.warning => _AppAlertStyle(
          foreground: colors.warning,
          background: Color.lerp(colors.surface, colors.warning, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.warning, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.warning, 0.32)!,
          icon: Icons.warning_amber_rounded,
        ),
      AppAlertVariant.danger => _AppAlertStyle(
          foreground: colors.error,
          background: Color.lerp(colors.surface, colors.error, 0.08)!,
          iconBackground: Color.lerp(colors.surface, colors.error, 0.16)!,
          border: Color.lerp(colors.borderStrong, colors.error, 0.32)!,
          icon: Icons.error_outline_rounded,
        ),
      AppAlertVariant.neutral => _AppAlertStyle(
          foreground: colors.secondary,
          background: colors.surfaceMuted,
          iconBackground:
              Color.lerp(colors.surface, colors.secondaryContainer, 0.72)!,
          border: colors.borderStrong,
          icon: Icons.notifications_none_rounded,
        ),
    };
  }
}
''';

const String _carouselTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../cards/app_card.dart';

class AppCarousel extends StatefulWidget {
  const AppCarousel({
    super.key,
    required this.children,
    this.height = 280,
    this.initialIndex = 0,
    this.onChanged,
    this.showControls = true,
    this.showIndicators = true,
    this.viewportFraction = 1,
  })  : assert(children.length > 0, 'children must not be empty.'),
        assert(
          initialIndex >= 0 && initialIndex < children.length,
          'initialIndex must stay within the child range.',
        ),
        assert(viewportFraction > 0,
            'viewportFraction must be greater than zero.');

  final List<Widget> children;
  final double height;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final bool showControls;
  final bool showIndicators;
  final double viewportFraction;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: widget.viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return AppCard.outlined(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              itemCount: widget.children.length,
              onPageChanged: _handlePageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(
                      widget.viewportFraction < 1 ? spacing.xs : 0),
                  child: widget.children[index],
                );
              },
            ),
            if (widget.showControls && widget.children.length > 1) ...[
              Positioned(
                left: spacing.sm,
                top: 0,
                bottom: 0,
                child: _AppCarouselControl(
                  icon: Icons.chevron_left_rounded,
                  semanticLabel: 'Previous slide',
                  enabled: _currentIndex > 0,
                  onTap: _currentIndex > 0
                      ? () => _animateTo(_currentIndex - 1)
                      : null,
                ),
              ),
              Positioned(
                right: spacing.sm,
                top: 0,
                bottom: 0,
                child: _AppCarouselControl(
                  icon: Icons.chevron_right_rounded,
                  semanticLabel: 'Next slide',
                  enabled: _currentIndex < widget.children.length - 1,
                  onTap: _currentIndex < widget.children.length - 1
                      ? () => _animateTo(_currentIndex + 1)
                      : null,
                ),
              ),
            ],
            if (widget.showIndicators && widget.children.length > 1)
              Positioned(
                left: spacing.md,
                right: spacing.md,
                bottom: spacing.sm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List<Widget>.generate(widget.children.length, (index) {
                    final isActive = index == _currentIndex;
                    final colors = context.appColors;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: EdgeInsets.symmetric(horizontal: spacing.xxxs),
                      width: isActive ? spacing.lg : spacing.xs,
                      height: spacing.xs,
                      decoration: BoxDecoration(
                        color: isActive ? colors.primary : colors.surface,
                        borderRadius:
                            BorderRadius.circular(context.appRadius.pill),
                        border: Border.all(
                          color:
                              isActive ? colors.primary : colors.borderStrong,
                          width: spacing.xxxs / 2,
                        ),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _animateTo(int index) {
    return _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onChanged?.call(index);
  }
}

class _AppCarouselControl extends StatelessWidget {
  const _AppCarouselControl({
    required this.icon,
    required this.semanticLabel,
    required this.enabled,
    this.onTap,
  });

  final IconData icon;
  final String semanticLabel;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;

    return Center(
      child: Semantics(
        button: true,
        enabled: enabled,
        label: semanticLabel,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            width: context.appSizes.controlSm,
            height: context.appSizes.controlSm,
            decoration: BoxDecoration(
              color: enabled ? colors.surface : colors.surfaceMuted,
              shape: BoxShape.circle,
              border: Border.all(
                color: enabled ? colors.borderStrong : colors.disabled,
                width: spacing.xxxs / 2,
              ),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: enabled ? onTap : null,
              child: Icon(
                icon,
                size: context.appSizes.iconMd,
                color: enabled ? colors.onSurface : colors.disabledForeground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';

const String _checkboxTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

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
''';

const String _comboboxTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';
import 'app_text_field.dart';

@immutable
class AppComboboxOption {
  const AppComboboxOption({
    required this.value,
    required this.label,
    this.description,
    this.enabled = true,
  });

  final String value;
  final String label;
  final String? description;
  final bool enabled;
}

class AppCombobox extends StatelessWidget {
  const AppCombobox({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText = 'Select an option',
    this.helperText,
    this.searchHintText = 'Search options',
    this.emptyStateText = 'No results found.',
    this.enabled = true,
  });

  final List<AppComboboxOption> options;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String hintText;
  final String? helperText;
  final String searchHintText;
  final String emptyStateText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    AppComboboxOption? selectedOption;
    for (final option in options) {
      if (option.value == value) {
        selectedOption = option;
        break;
      }
    }
    final isInteractive = enabled && onChanged != null;
    final foreground = isInteractive
        ? (selectedOption == null ? colors.onSurfaceMuted : colors.onSurface)
        : colors.disabledForeground;
    final background = isInteractive ? colors.surface : colors.surfaceMuted;
    final borderColor = isInteractive ? colors.border : colors.disabled;

    return VStack(
      spacing: spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelText != null) AppText.label(labelText!),
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(context.appRadius.md),
              border: Border.all(
                color: borderColor,
                width: spacing.xxxs / 2,
              ),
            ),
            child: InkWell(
              onTap: isInteractive ? () => _openSheet(context) : null,
              borderRadius: BorderRadius.circular(context.appRadius.md),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.md,
                  vertical: spacing.sm,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AppText.body(
                        selectedOption?.label ?? hintText,
                        color: foreground,
                      ),
                    ),
                    SizedBox(width: spacing.sm),
                    Icon(
                      Icons.unfold_more_rounded,
                      size: context.appSizes.iconMd,
                      color: foreground,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (helperText != null)
          AppText.body(
            helperText!,
            variant: AppTextVariant.bodySmall,
            tone: AppTextTone.muted,
          ),
      ],
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    final nextValue = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _AppComboboxSheet(
          options: options,
          selectedValue: value,
          title: labelText ?? hintText,
          searchHintText: searchHintText,
          emptyStateText: emptyStateText,
        );
      },
    );

    if (nextValue != null && nextValue != value) {
      onChanged?.call(nextValue);
    }
  }
}

class _AppComboboxSheet extends StatefulWidget {
  const _AppComboboxSheet({
    required this.options,
    required this.selectedValue,
    required this.title,
    required this.searchHintText,
    required this.emptyStateText,
  });

  final List<AppComboboxOption> options;
  final String? selectedValue;
  final String title;
  final String searchHintText;
  final String emptyStateText;

  @override
  State<_AppComboboxSheet> createState() => _AppComboboxSheetState();
}

class _AppComboboxSheetState extends State<_AppComboboxSheet> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_handleSearch);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_handleSearch)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final filteredOptions = _filteredOptions();

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: spacing.md,
          right: spacing.md,
          bottom: spacing.md,
        ),
        child: FractionallySizedBox(
          heightFactor: 0.78,
          child: AppCard(
            child: VStack(
              spacing: spacing.md,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText.title(
                  widget.title,
                  variant: AppTextVariant.titleMedium,
                ),
                AppTextField.outline(
                  controller: _searchController,
                  hintText: widget.searchHintText,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                Expanded(
                  child: filteredOptions.isEmpty
                      ? Center(
                          child: AppText.body(
                            widget.emptyStateText,
                            tone: AppTextTone.muted,
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredOptions.length,
                          separatorBuilder: (_, __) => Divider(
                            height: spacing.sm,
                            thickness: 1,
                            color: context.appColors.border,
                          ),
                          itemBuilder: (context, index) {
                            final option = filteredOptions[index];

                            return _AppComboboxOptionTile(
                              option: option,
                              isSelected: option.value == widget.selectedValue,
                              onTap: option.enabled
                                  ? () =>
                                      Navigator.of(context).pop(option.value)
                                  : null,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<AppComboboxOption> _filteredOptions() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return widget.options;
    }

    return widget.options.where((option) {
      final haystack =
          '${option.label} ${option.description ?? ''}'.toLowerCase();
      return haystack.contains(query);
    }).toList();
  }

  void _handleSearch() {
    setState(() {});
  }
}

class _AppComboboxOptionTile extends StatelessWidget {
  const _AppComboboxOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final AppComboboxOption option;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = option.enabled
        ? (isSelected ? colors.primary : colors.onSurface)
        : colors.disabledForeground;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceMuted : colors.surface,
          borderRadius: BorderRadius.circular(context.appRadius.md),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.appRadius.md),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.sm,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: VStack(
                    spacing: spacing.xxxs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText.body(
                        option.label,
                        color: foreground,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (option.description != null)
                        AppText.body(
                          option.description!,
                          variant: AppTextVariant.bodySmall,
                          tone: AppTextTone.muted,
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    size: context.appSizes.iconSm,
                    color: colors.primary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
''';

const String _navigationMenuTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

@immutable
class AppNavigationMenuItem {
  const AppNavigationMenuItem({
    required this.label,
    this.icon,
    this.description,
    this.badgeLabel,
    this.child,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final String? description;
  final String? badgeLabel;
  final Widget? child;
  final bool enabled;
}

class AppNavigationMenu extends StatelessWidget {
  const AppNavigationMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
  })  : assert(items.length > 0, 'items must not be empty.'),
        assert(
          selectedIndex >= 0 && selectedIndex < items.length,
          'selectedIndex must stay within the item range.',
        );

  final List<AppNavigationMenuItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final selectedItem = items[selectedIndex];

    return AppCard.outlined(
      padding: EdgeInsets.zero,
      child: VStack(
        spacing: spacing.none,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(items.length, (index) {
                final item = items[index];

                return _AppNavigationMenuTrigger(
                  item: item,
                  isSelected: index == selectedIndex,
                  showDivider: index != items.length - 1,
                  onTap: item.enabled && onChanged != null
                      ? () => onChanged!(index)
                      : null,
                );
              }),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: context.appColors.border,
          ),
          Padding(
            padding: EdgeInsets.all(spacing.lg),
            child: selectedItem.child ??
                _AppNavigationMenuPanel(item: selectedItem),
          ),
        ],
      ),
    );
  }
}

class _AppNavigationMenuTrigger extends StatelessWidget {
  const _AppNavigationMenuTrigger({
    required this.item,
    required this.isSelected,
    required this.showDivider,
    required this.onTap,
  });

  final AppNavigationMenuItem item;
  final bool isSelected;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = item.enabled
        ? (isSelected ? colors.primary : colors.onSurface)
        : colors.disabledForeground;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceMuted : colors.surface,
          border: showDivider
              ? Border(
                  right: BorderSide(
                    color: colors.border,
                    width: spacing.xxxs / 2,
                  ),
                )
              : null,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.md,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (item.icon != null) ...[
                  Icon(item.icon,
                      size: context.appSizes.iconSm, color: foreground),
                  SizedBox(width: spacing.xs),
                ],
                AppText.label(
                  item.label,
                  color: foreground,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                if (item.badgeLabel case final String badge) ...[
                  SizedBox(width: spacing.xs),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors.primaryContainer
                          : colors.surfaceMuted,
                      borderRadius:
                          BorderRadius.circular(context.appRadius.pill),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.xs,
                        vertical: spacing.xxxs,
                      ),
                      child: AppText.label(
                        badge,
                        variant: AppTextVariant.labelSmall,
                        color: foreground,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppNavigationMenuPanel extends StatelessWidget {
  const _AppNavigationMenuPanel({
    required this.item,
  });

  final AppNavigationMenuItem item;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText.title(
          item.label,
          variant: AppTextVariant.titleMedium,
        ),
        if (item.description != null)
          AppText.body(
            item.description!,
            tone: AppTextTone.muted,
          ),
      ],
    );
  }
}
''';

const String _otpFieldTemplate = r'''
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/flutter_ui.dart';

class AppOtpField extends StatefulWidget {
  const AppOtpField({
    super.key,
    this.length = 6,
    this.initialValue,
    this.onChanged,
    this.onCompleted,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
  }) : assert(length > 0, 'length must be greater than zero.');

  final int length;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool enabled;
  final bool autofocus;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List<TextEditingController>.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List<FocusNode>.generate(widget.length, (_) => FocusNode());
    _populateFromValue(widget.initialValue ?? '');
  }

  @override
  void didUpdateWidget(covariant AppOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      _populateFromValue(widget.initialValue ?? '');
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final borderRadius = BorderRadius.circular(context.appRadius.md);
    final borderWidth = spacing.xxxs / 2;
    final inputFormatters = <TextInputFormatter>[
      LengthLimitingTextInputFormatter(widget.length),
      FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
    ];

    return Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      children: List<Widget>.generate(widget.length, (index) {
        return Focus(
          onKeyEvent: (_, event) => _handleKeyEvent(event, index),
          child: SizedBox(
            width: context.appSizes.controlLg,
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              enabled: widget.enabled,
              autofocus: widget.autofocus && index == 0,
              keyboardType: widget.keyboardType,
              textAlign: TextAlign.center,
              obscureText: widget.obscureText,
              inputFormatters: inputFormatters,
              style: context.appTypography.titleLarge.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
              cursorColor: colors.primary,
              decoration: InputDecoration(
                counterText: '',
                isDense: true,
                filled: true,
                fillColor: colors.surface,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: spacing.none,
                  vertical: spacing.md,
                ),
                border: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.border,
                    width: borderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.border,
                    width: borderWidth,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.disabled,
                    width: borderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius,
                  borderSide: BorderSide(
                    color: colors.focus,
                    width: borderWidth,
                  ),
                ),
              ),
              onChanged: (value) => _handleChanged(value, index),
            ),
          ),
        );
      }),
    );
  }

  KeyEventResult _handleKeyEvent(KeyEvent event, int index) {
    if (event is! KeyDownEvent ||
        event.logicalKey != LogicalKeyboardKey.backspace ||
        _controllers[index].text.isNotEmpty ||
        index == 0) {
      return KeyEventResult.ignored;
    }

    _controllers[index - 1].clear();
    _focusNodes[index - 1].requestFocus();
    _emitValue();
    return KeyEventResult.handled;
  }

  void _handleChanged(String rawValue, int index) {
    final sanitized = rawValue.replaceAll(RegExp(r'\s+'), '');

    if (sanitized.length > 1) {
      _applyPastedValue(sanitized, index);
      return;
    }

    final nextValue =
        sanitized.isEmpty ? '' : sanitized.substring(sanitized.length - 1);
    _setControllerValue(index, nextValue);

    if (nextValue.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }

    _emitValue();
  }

  void _applyPastedValue(String rawValue, int startIndex) {
    final characters = rawValue.split('');

    for (var index = 0; index < widget.length; index += 1) {
      final targetIndex = startIndex + index;
      if (targetIndex >= widget.length) {
        break;
      }

      final character = index < characters.length ? characters[index] : '';
      _setControllerValue(targetIndex, character);
    }

    final filledCount = math.min(characters.length, widget.length - startIndex);
    final nextIndex = startIndex + filledCount - 1;
    if (_isComplete) {
      _focusNodes.last.unfocus();
    } else if (nextIndex >= 0 && nextIndex < widget.length - 1) {
      _focusNodes[nextIndex + 1].requestFocus();
    }

    _emitValue();
  }

  void _populateFromValue(String value) {
    final characters = value.split('');

    for (var index = 0; index < widget.length; index += 1) {
      _setControllerValue(
        index,
        index < characters.length ? characters[index] : '',
      );
    }
  }

  void _setControllerValue(int index, String value) {
    _controllers[index].value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  void _emitValue() {
    final value = _controllers.map((controller) => controller.text).join();
    widget.onChanged?.call(value);

    if (_isComplete) {
      widget.onCompleted?.call(value);
    }
  }

  bool get _isComplete =>
      _controllers.every((controller) => controller.text.isNotEmpty);
}
''';

const String _paginationTemplate = r'''
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../typography/app_text.dart';

class AppPagination extends StatelessWidget {
  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPageChanged,
    this.siblingCount = 1,
  })  : assert(totalPages > 0, 'totalPages must be greater than zero.'),
        assert(
          currentPage > 0 && currentPage <= totalPages,
          'currentPage must stay within the page range.',
        ),
        assert(siblingCount >= 0, 'siblingCount must not be negative.');

  final int currentPage;
  final int totalPages;
  final ValueChanged<int>? onPageChanged;
  final int siblingCount;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final entries = _buildEntries();

    return Wrap(
      spacing: spacing.xs,
      runSpacing: spacing.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        _AppPaginationControl(
          label: 'Previous',
          icon: Icons.chevron_left_rounded,
          enabled: currentPage > 1 && onPageChanged != null,
          onTap: () => onPageChanged?.call(currentPage - 1),
        ),
        ...entries.map((entry) {
          if (entry.isEllipsis) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing.xs),
              child: AppText.body(
                '…',
                variant: AppTextVariant.bodySmall,
                tone: AppTextTone.muted,
              ),
            );
          }

          final page = entry.page!;

          return _AppPaginationControl(
            label: '$page',
            isCurrent: page == currentPage,
            enabled: onPageChanged != null && page != currentPage,
            onTap: () => onPageChanged?.call(page),
          );
        }),
        _AppPaginationControl(
          label: 'Next',
          trailingIcon: Icons.chevron_right_rounded,
          enabled: currentPage < totalPages && onPageChanged != null,
          onTap: () => onPageChanged?.call(currentPage + 1),
        ),
      ],
    );
  }

  List<_AppPaginationEntry> _buildEntries() {
    if (totalPages <= 5 + (siblingCount * 2)) {
      return List<_AppPaginationEntry>.generate(
        totalPages,
        (index) => _AppPaginationEntry.page(index + 1),
      );
    }

    final left = math.max(2, currentPage - siblingCount);
    final right = math.min(totalPages - 1, currentPage + siblingCount);
    final entries = <_AppPaginationEntry>[
      const _AppPaginationEntry.page(1),
    ];

    if (left > 2) {
      entries.add(const _AppPaginationEntry.ellipsis());
    }

    for (var page = left; page <= right; page += 1) {
      entries.add(_AppPaginationEntry.page(page));
    }

    if (right < totalPages - 1) {
      entries.add(const _AppPaginationEntry.ellipsis());
    }

    entries.add(_AppPaginationEntry.page(totalPages));
    return entries;
  }
}

class _AppPaginationEntry {
  const _AppPaginationEntry.page(this.page) : isEllipsis = false;

  const _AppPaginationEntry.ellipsis()
      : page = null,
        isEllipsis = true;

  final int? page;
  final bool isEllipsis;
}

class _AppPaginationControl extends StatelessWidget {
  const _AppPaginationControl({
    required this.label,
    this.icon,
    this.trailingIcon,
    this.onTap,
    this.enabled = true,
    this.isCurrent = false,
  });

  final String label;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final bool enabled;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final typography = context.appTypography;
    final radius = BorderRadius.circular(context.appRadius.md);
    final borderWidth = spacing.xxxs / 2;
    final resolvedBackground =
        isCurrent ? colors.primaryContainer : colors.surface;
    final resolvedForeground = !enabled
        ? colors.disabledForeground
        : isCurrent
            ? colors.primary
            : colors.onSurface;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color:
              enabled || isCurrent ? resolvedBackground : colors.surfaceMuted,
          borderRadius: radius,
          border: Border.all(
            color: isCurrent ? colors.primary : colors.borderStrong,
            width: borderWidth,
          ),
        ),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.sm,
              vertical: spacing.xs,
            ),
            child: DefaultTextStyle(
              style: typography.labelMedium.copyWith(
                color: resolvedForeground,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (icon != null) ...[
                    Icon(icon,
                        size: context.appSizes.iconSm,
                        color: resolvedForeground),
                    SizedBox(width: spacing.xxxs),
                  ],
                  Text(label),
                  if (trailingIcon != null) ...[
                    SizedBox(width: spacing.xxxs),
                    Icon(
                      trailingIcon,
                      size: context.appSizes.iconSm,
                      color: resolvedForeground,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';

const String _progressTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

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
''';

const String _roadmapItemTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../typography/app_text.dart';

enum AppRoadmapItemState {
  planned,
  active,
  completed,
}

class AppRoadmapItem extends StatelessWidget {
  const AppRoadmapItem({
    super.key,
    required this.title,
    this.kindLabel = 'Task',
    this.categoryLabel,
    this.issueNumber,
    this.owner,
    this.activityLabel,
    this.state = AppRoadmapItemState.planned,
    this.isHighlighted = false,
    this.showDivider = true,
    this.onTap,
    this.padding,
  });

  final String title;
  final String kindLabel;
  final String? categoryLabel;
  final int? issueNumber;
  final String? owner;
  final String? activityLabel;
  final AppRoadmapItemState state;
  final bool isHighlighted;
  final bool showDivider;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final resolvedPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.md,
        );
    final dividerWidth = spacing.xxxs / 2;
    final metadata = _buildMetadata();

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isHighlighted ? colors.surfaceMuted : colors.surface,
          border: Border(
            bottom: showDivider
                ? BorderSide(
                    color: colors.border,
                    width: dividerWidth,
                  )
                : BorderSide.none,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: resolvedPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: spacing.xxs),
                  child: _AppRoadmapStatusIcon(state: state),
                ),
                SizedBox(width: spacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: AppText.title(
                              title,
                              variant: AppTextVariant.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (categoryLabel case final String category) ...[
                            SizedBox(width: spacing.xs),
                            _AppRoadmapBadge(
                              label: category,
                              tone: _AppRoadmapBadgeTone.info,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spacing.xs),
                      Wrap(
                        spacing: spacing.xs,
                        runSpacing: spacing.xxs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          _AppRoadmapBadge(
                            label: kindLabel,
                            tone: _AppRoadmapBadgeTone.warning,
                          ),
                          if (metadata != null)
                            AppText.body(
                              metadata,
                              variant: AppTextVariant.bodySmall,
                              tone: AppTextTone.muted,
                            ),
                        ],
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

  String? _buildMetadata() {
    final fragments = <String>[
      if (issueNumber != null) '#$issueNumber',
      if (owner != null && owner!.isNotEmpty) 'by $owner',
      if (activityLabel != null && activityLabel!.isNotEmpty) activityLabel!,
    ];

    if (fragments.isEmpty) {
      return null;
    }

    return fragments.join(' • ');
  }
}

class _AppRoadmapStatusIcon extends StatelessWidget {
  const _AppRoadmapStatusIcon({
    required this.state,
  });

  final AppRoadmapItemState state;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final sizes = context.appSizes;
    final spacing = context.appSpacing;
    final visualStyle = switch (state) {
      AppRoadmapItemState.planned => (
          icon: Icons.circle_outlined,
          color: colors.onSurfaceMuted,
          background: colors.surface,
        ),
      AppRoadmapItemState.active => (
          icon: Icons.autorenew_rounded,
          color: colors.info,
          background: Color.lerp(colors.surface, colors.info, 0.14)!,
        ),
      AppRoadmapItemState.completed => (
          icon: Icons.check_rounded,
          color: colors.primary,
          background:
              Color.lerp(colors.surface, colors.primaryContainer, 0.82)!,
        ),
    };

    return Container(
      width: sizes.iconMd,
      height: sizes.iconMd,
      decoration: BoxDecoration(
        color: visualStyle.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: visualStyle.color,
          width: spacing.xxxs / 2,
        ),
      ),
      child: Icon(
        visualStyle.icon,
        size: sizes.iconXs,
        color: visualStyle.color,
      ),
    );
  }
}

enum _AppRoadmapBadgeTone {
  info,
  warning,
}

class _AppRoadmapBadge extends StatelessWidget {
  const _AppRoadmapBadge({
    required this.label,
    required this.tone,
  });

  final String label;
  final _AppRoadmapBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final radius = context.appRadius.pill;
    final colors = context.appColors;
    final visualStyle = switch (tone) {
      _AppRoadmapBadgeTone.info => (
          foreground: colors.primary,
          background:
              Color.lerp(colors.surface, colors.primaryContainer, 0.78)!,
          border: Color.lerp(colors.borderStrong, colors.primary, 0.32)!,
        ),
      _AppRoadmapBadgeTone.warning => (
          foreground: colors.warning,
          background: Color.lerp(colors.surface, colors.warning, 0.14)!,
          border: Color.lerp(colors.borderStrong, colors.warning, 0.3)!,
        ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: visualStyle.background,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: visualStyle.border,
          width: spacing.xxxs / 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xs,
          vertical: spacing.xxxs,
        ),
        child: AppText.label(
          label,
          variant: AppTextVariant.labelSmall,
          color: visualStyle.foreground,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
''';

const String _switchTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

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
''';

const String _tabsTemplate = r'''
import 'package:flutter/material.dart';
import '../../core/flutter_ui.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';
import '../typography/app_text.dart';

@immutable
class AppTabItem {
  const AppTabItem({
    required this.label,
    this.icon,
    this.description,
    this.badgeLabel,
    this.panel,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final String? description;
  final String? badgeLabel;
  final Widget? panel;
  final bool enabled;
}

class AppTabs extends StatelessWidget {
  const AppTabs({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showPanel = false,
  })  : assert(items.length > 0, 'items must not be empty.'),
        assert(
          selectedIndex >= 0 && selectedIndex < items.length,
          'selectedIndex must stay within the item range.',
        );

  final List<AppTabItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final bool showPanel;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final selectedItem = items[selectedIndex];
    final shouldShowPanel = showPanel ||
        items.any((item) => item.panel != null || item.description != null);

    return VStack(
      spacing: spacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppCard.outlined(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(items.length, (index) {
                final item = items[index];

                return _AppTabTrigger(
                  item: item,
                  isSelected: index == selectedIndex,
                  showDivider: index != items.length - 1,
                  onTap: item.enabled && onChanged != null
                      ? () => onChanged!(index)
                      : null,
                );
              }),
            ),
          ),
        ),
        if (shouldShowPanel)
          AppCard.muted(
            child: selectedItem.panel ?? _AppTabPanel(item: selectedItem),
          ),
      ],
    );
  }
}

class _AppTabTrigger extends StatelessWidget {
  const _AppTabTrigger({
    required this.item,
    required this.isSelected,
    required this.showDivider,
    required this.onTap,
  });

  final AppTabItem item;
  final bool isSelected;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = item.enabled
        ? (isSelected ? colors.primary : colors.onSurface)
        : colors.disabledForeground;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceMuted : colors.surface,
          border: showDivider
              ? Border(
                  right: BorderSide(
                    color: colors.border,
                    width: spacing.xxxs / 2,
                  ),
                )
              : null,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (item.icon != null) ...[
                  Icon(item.icon,
                      size: context.appSizes.iconSm, color: foreground),
                  SizedBox(width: spacing.xs),
                ],
                AppText.label(
                  item.label,
                  color: foreground,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                if (item.badgeLabel case final String badge) ...[
                  SizedBox(width: spacing.xs),
                  _AppTabsBadge(
                    label: badge,
                    isSelected: isSelected,
                    enabled: item.enabled,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppTabPanel extends StatelessWidget {
  const _AppTabPanel({
    required this.item,
  });

  final AppTabItem item;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return VStack(
      spacing: spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText.title(
          item.label,
          variant: AppTextVariant.titleMedium,
        ),
        if (item.description != null)
          AppText.body(
            item.description!,
            tone: AppTextTone.muted,
          ),
      ],
    );
  }
}

class _AppTabsBadge extends StatelessWidget {
  const _AppTabsBadge({
    required this.label,
    required this.isSelected,
    required this.enabled,
  });

  final String label;
  final bool isSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final foreground = !enabled
        ? colors.disabledForeground
        : isSelected
            ? colors.primary
            : colors.onSurfaceMuted;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? colors.primaryContainer : colors.surfaceMuted,
        borderRadius: BorderRadius.circular(context.appRadius.pill),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xs,
          vertical: spacing.xxxs,
        ),
        child: AppText.label(
          label,
          variant: AppTextVariant.labelSmall,
          color: foreground,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
''';
