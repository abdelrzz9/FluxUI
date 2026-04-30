import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.enabled = true,
    this.autofocus = false,
    this.borderRadius,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool enabled;
  final bool autofocus;
  final double? borderRadius;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
    widget.onChanged?.call(_controller.text);
  }

  void _handleClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final radius = BorderRadius.circular(
      widget.borderRadius ?? context.appRadius.md,
    );
    final borderWidth = spacing.xxxs / 2;

    final outline = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: colors.border, width: borderWidth),
    );

    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: widget.onSubmitted,
      style: typography.bodyMedium.copyWith(
        color: widget.enabled ? colors.onSurface : colors.disabledForeground,
      ),
      cursorColor: colors.primary,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: widget.enabled ? colors.surface : colors.surfaceMuted,
        hintText: widget.hintText,
        hintStyle: typography.bodyMedium.copyWith(color: colors.onSurfaceMuted),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: context.appSizes.iconMd,
          color: colors.onSurfaceMuted,
        ),
        suffixIcon: _hasText && widget.enabled
            ? IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: context.appSizes.iconSm,
                  color: colors.onSurfaceMuted,
                ),
                onPressed: _handleClear,
                splashRadius: context.appSizes.iconMd,
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.md,
          vertical: spacing.sm,
        ),
        border: outline,
        enabledBorder: outline,
        disabledBorder: outline.copyWith(
          borderSide: BorderSide(color: colors.disabled, width: borderWidth),
        ),
        focusedBorder: outline.copyWith(
          borderSide: BorderSide(color: colors.focus, width: borderWidth),
        ),
      ),
    );
  }
}
