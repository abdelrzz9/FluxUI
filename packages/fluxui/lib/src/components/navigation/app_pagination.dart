import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';

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
