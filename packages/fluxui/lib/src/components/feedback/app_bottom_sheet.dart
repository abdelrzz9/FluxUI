import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../layouts/v_stack.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.padding,
  });

  final Widget child;
  final String? title;
  final bool showDragHandle;
  final EdgeInsetsGeometry? padding;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppBottomSheet(
        title: title,
        showDragHandle: showDragHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final radius = Radius.circular(context.appRadius.xl);
    final resolvedPadding = padding ??
        EdgeInsets.only(
          left: spacing.x2l,
          right: spacing.x2l,
          bottom: spacing.x2l + MediaQuery.of(context).viewInsets.bottom,
          top: showDragHandle ? spacing.xs : spacing.x2l,
        );

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
          ),
          border: Border(
            top: BorderSide(color: colors.border, width: spacing.xxxs / 2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (showDragHandle)
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: spacing.sm),
                  child: Container(
                    width: spacing.x2l,
                    height: spacing.xxs,
                    decoration: BoxDecoration(
                      color: colors.borderStrong,
                      borderRadius:
                          BorderRadius.circular(context.appRadius.pill),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: resolvedPadding,
              child: VStack(
                spacing: spacing.lg,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (title != null)
                    AppText.title(
                      title!,
                      variant: AppTextVariant.titleMedium,
                    ),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
