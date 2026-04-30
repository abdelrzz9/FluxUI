import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../cards/app_card.dart';
import '../layouts/v_stack.dart';
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
