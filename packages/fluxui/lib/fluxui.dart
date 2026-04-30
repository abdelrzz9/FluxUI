/// FluxUI — A token-driven Flutter UI system.
///
/// FluxUI provides 30+ production-ready widgets built on typed design tokens.
/// Every color, spacing value, and typography style resolves through
/// [AppDesignTokens] — zero hardcoded values.
///
/// ## Quick start
///
/// ```dart
/// import 'package:fluxui/fluxui.dart';
///
/// void main() => runApp(const MyApp());
///
/// class MyApp extends StatelessWidget {
///   const MyApp({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       theme: AppTheme.light(),
///       darkTheme: AppTheme.dark(),
///       home: Scaffold(
///         body: Center(
///           child: AppButton(text: 'Hello FluxUI', onPressed: () {}),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// ## Custom branding
///
/// ```dart
/// final myTokens = AppDesignTokens.light.copyWith(
///   colors: AppColorTokens.light.copyWith(primary: Color(0xFF6366F1)),
/// );
///
/// MaterialApp(
///   theme: AppTheme.custom(tokens: myTokens, brightness: Brightness.light),
/// );
/// ```
library fluxui;

// ── Design system foundation ───────────────────────────────────────────────
export 'src/tokens/index.dart';
export 'src/core/theme/app_theme.dart';
export 'src/core/theme/app_theme_tokens.dart';
export 'src/core/extensions/app_theme_context_extensions.dart';

// ── Utilities (re-exported from flutter_ui_utils) ─────────────────────────
export 'package:flutter_ui_utils/index.dart';

// ── Typography ────────────────────────────────────────────────────────────
export 'src/core/widgets/app_text.dart';

// ── Buttons ───────────────────────────────────────────────────────────────
export 'src/components/buttons/app_button.dart';

// ── Cards ─────────────────────────────────────────────────────────────────
export 'src/components/cards/app_card.dart';

// ── Display ───────────────────────────────────────────────────────────────
export 'src/components/display/app_avatar.dart';
export 'src/components/display/app_badge.dart';
export 'src/components/display/app_carousel.dart';

// ── Feedback ──────────────────────────────────────────────────────────────
export 'src/components/feedback/app_alert.dart';
export 'src/components/feedback/app_bottom_sheet.dart';
export 'src/components/feedback/app_dialog.dart';
export 'src/components/feedback/app_progress.dart';
export 'src/components/feedback/app_skeleton.dart';
export 'src/components/feedback/app_toast.dart';

// ── Inputs ────────────────────────────────────────────────────────────────
export 'src/components/inputs/app_combobox.dart';
export 'src/components/inputs/app_otp_field.dart';
export 'src/components/inputs/app_search_bar.dart';
export 'src/components/inputs/app_slider.dart';
export 'src/components/inputs/app_text_field.dart';

// ── Layouts ───────────────────────────────────────────────────────────────
export 'src/components/layouts/gap.dart';
export 'src/components/layouts/h_stack.dart';
export 'src/components/layouts/v_stack.dart';

// ── Navigation ────────────────────────────────────────────────────────────
export 'src/components/navigation/app_app_bar.dart';
export 'src/components/navigation/app_bottom_nav.dart';
export 'src/components/navigation/app_navigation_menu.dart';
export 'src/components/navigation/app_pagination.dart';
export 'src/components/navigation/app_tabs.dart';

// ── Roadmap ───────────────────────────────────────────────────────────────
export 'src/components/roadmap/app_roadmap_item.dart';

// ── Selection ─────────────────────────────────────────────────────────────
export 'src/components/selection/app_checkbox.dart';
export 'src/components/selection/app_chip.dart';
export 'src/components/selection/app_radio.dart';
export 'src/components/selection/app_switch.dart';
