import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';

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
