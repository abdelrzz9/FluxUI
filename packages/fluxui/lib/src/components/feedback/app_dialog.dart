import 'package:flutter/material.dart';

import '../../core/extensions/app_theme_context_extensions.dart';
import '../../core/widgets/app_text.dart';
import '../buttons/app_button.dart';
import '../layouts/v_stack.dart';

@immutable
class AppDialogAction {
  const AppDialogAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isDefault;
}

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.description,
    this.child,
    this.actions = const <AppDialogAction>[],
  });

  final String title;
  final String? description;
  final Widget? child;
  final List<AppDialogAction> actions;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    Widget? child,
    List<AppDialogAction> actions = const <AppDialogAction>[],
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AppDialog(
        title: title,
        description: description,
        child: child,
        actions: actions,
      ),
    );
  }

  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    String? description,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: title,
        description: description,
        actions: <AppDialogAction>[
          AppDialogAction(
            label: cancelLabel,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          AppDialogAction(
            label: confirmLabel,
            isDestructive: isDestructive,
            isDefault: !isDestructive,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final radius = BorderRadius.circular(context.appRadius.xl);

    return Dialog(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.appSizes.containerXs),
        child: Padding(
          padding: EdgeInsets.all(spacing.x2l),
          child: VStack(
            spacing: spacing.lg,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VStack(
                spacing: spacing.xs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText.title(title, variant: AppTextVariant.titleMedium),
                  if (description != null)
                    AppText.body(description!, tone: AppTextTone.muted),
                ],
              ),
              if (child != null) child!,
              if (actions.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    for (int i = 0; i < actions.length; i++) ...<Widget>[
                      if (i > 0) SizedBox(width: spacing.xs),
                      if (actions[i].isDefault)
                        AppButton.primary(
                          text: actions[i].label,
                          size: AppButtonSize.sm,
                          onPressed: actions[i].onPressed,
                        )
                      else
                        AppButton.ghost(
                          text: actions[i].label,
                          size: AppButtonSize.sm,
                          onPressed: actions[i].onPressed,
                        ),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
