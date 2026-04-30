import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/extensions/app_theme_context_extensions.dart';

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
