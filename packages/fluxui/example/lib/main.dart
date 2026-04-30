import 'package:flutter/material.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

void main() => runApp(const FluxUIExampleApp());

class FluxUIExampleApp extends StatefulWidget {
  const FluxUIExampleApp({super.key});

  @override
  State<FluxUIExampleApp> createState() => _FluxUIExampleAppState();
}

class _FluxUIExampleAppState extends State<FluxUIExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluxUI Example',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: ExamplePage(onToggleTheme: _toggleTheme),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key, required this.onToggleTheme});

  final VoidCallback onToggleTheme;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _checkboxValue = false;
  bool _switchValue = true;
  bool _chipSelected = false;
  String? _radioValue = 'a';
  double _sliderValue = 0.4;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return Scaffold(
      appBar: AppAppBar(
        title: 'FluxUI',
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_rounded),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(spacing.x2l),
        children: [
          _Section(
            title: 'Buttons',
            child: Wrap(
              spacing: spacing.sm,
              runSpacing: spacing.sm,
              children: [
                AppButton(text: 'Primary', onPressed: () {}),
                AppButton.secondary(text: 'Secondary', onPressed: () {}),
                AppButton.outline(text: 'Outline', onPressed: () {}),
                AppButton.ghost(text: 'Ghost', onPressed: () {}),
                AppButton(text: 'Loading', isLoading: true, onPressed: () {}),
                AppButton(text: 'Disabled', onPressed: null),
              ],
            ),
          ),
          _Section(
            title: 'Typography',
            child: VStack(
              spacing: spacing.xs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Display', variant: AppTextVariant.displaySmall),
                AppText('Headline', variant: AppTextVariant.headlineMedium),
                AppText('Title', variant: AppTextVariant.titleLarge),
                AppText('Body — default text style used across all components.',
                    variant: AppTextVariant.bodyMedium),
                AppText('Label', variant: AppTextVariant.labelLarge),
                AppText('Muted text', tone: AppTextTone.muted),
                AppText('Primary accent', tone: AppTextTone.primary),
              ],
            ),
          ),
          _Section(
            title: 'Inputs',
            child: VStack(
              spacing: spacing.md,
              children: [
                const AppTextField(
                  labelText: 'Email',
                  hintText: 'you@example.com',
                ),
                const AppSearchBar(hintText: 'Search components…'),
                AppSlider(
                  value: _sliderValue,
                  label: 'Opacity',
                  onChanged: (v) => setState(() => _sliderValue = v),
                ),
              ],
            ),
          ),
          _Section(
            title: 'Selection',
            child: VStack(
              spacing: spacing.none,
              children: [
                AppCheckbox(
                  value: _checkboxValue,
                  label: 'Remember me',
                  description: 'Stay signed in on this device.',
                  onChanged: (v) => setState(() => _checkboxValue = v ?? false),
                ),
                AppSwitch(
                  value: _switchValue,
                  label: 'Notifications',
                  description: 'Receive push notifications.',
                  onChanged: (v) => setState(() => _switchValue = v),
                ),
                AppChip(
                  label: 'Flutter',
                  selected: _chipSelected,
                  leading: const Icon(Icons.flutter_dash),
                  onSelected: (v) => setState(() => _chipSelected = v),
                ),
                AppRadioGroup<String>(
                  value: _radioValue,
                  onChanged: (v) => setState(() => _radioValue = v),
                  items: const [
                    AppRadioItem(value: 'a', label: 'Option A'),
                    AppRadioItem(value: 'b', label: 'Option B'),
                    AppRadioItem(value: 'c', label: 'Option C'),
                  ],
                ),
              ],
            ),
          ),
          _Section(
            title: 'Feedback',
            child: VStack(
              spacing: spacing.sm,
              children: [
                const AppAlert.info(
                  title: 'Info',
                  description: 'This is an informational alert.',
                ),
                const AppAlert.success(
                  title: 'Success',
                  description: 'Your changes have been saved.',
                ),
                const AppAlert.warning(
                  title: 'Warning',
                  description: 'Review before continuing.',
                ),
                const AppAlert.danger(
                  title: 'Error',
                  description: 'Something went wrong.',
                ),
                AppButton.outline(
                  text: 'Show Toast',
                  onPressed: () => AppToast.show(
                    context,
                    message: 'Component installed!',
                    variant: AppToastVariant.success,
                  ),
                ),
                AppButton.outline(
                  text: 'Show Dialog',
                  onPressed: () => AppDialog.confirm(
                    context: context,
                    title: 'Confirm action',
                    description: 'Are you sure you want to continue?',
                    confirmLabel: 'Yes, continue',
                  ),
                ),
                AppProgress(value: 0.65, label: 'Upload progress'),
                const AppProgress(label: 'Indeterminate'),
              ],
            ),
          ),
          _Section(
            title: 'Display',
            child: VStack(
              spacing: spacing.md,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: spacing.sm,
                  runSpacing: spacing.sm,
                  children: [
                    AppAvatar(initials: 'AB', size: AppAvatarSize.xl),
                    AppAvatar(initials: 'CD', size: AppAvatarSize.lg),
                    AppAvatar(size: AppAvatarSize.md),
                    AppAvatar(icon: Icons.star_rounded, size: AppAvatarSize.sm),
                    AppAvatar(initials: 'XS', size: AppAvatarSize.xs),
                  ],
                ),
                Wrap(
                  spacing: spacing.sm,
                  runSpacing: spacing.sm,
                  children: const [
                    AppBadge(label: 'Primary'),
                    AppBadge(
                        label: 'Success', variant: AppBadgeVariant.success),
                    AppBadge(
                        label: 'Warning', variant: AppBadgeVariant.warning),
                    AppBadge(label: 'Danger', variant: AppBadgeVariant.danger),
                    AppBadge(
                        label: 'Neutral', variant: AppBadgeVariant.neutral),
                  ],
                ),
              ],
            ),
          ),
          _Section(
            title: 'Skeleton',
            child: VStack(
              spacing: spacing.sm,
              children: [
                AppSkeleton(width: double.infinity, height: 20),
                AppSkeleton(width: 200, height: 20),
                AppSkeleton(width: 140, height: 20),
                Row(
                  children: [
                    AppSkeleton.circular(size: 44),
                    SizedBox(width: spacing.md),
                    Expanded(
                      child: VStack(
                        spacing: spacing.xs,
                        children: [
                          AppSkeleton(width: double.infinity, height: 16),
                          AppSkeleton(width: 120, height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spacing.x4l),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final colors = context.appColors;
    final typography = context.appTypography;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.x2l),
      child: VStack(
        spacing: spacing.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: typography.titleMedium),
              SizedBox(height: spacing.xxs),
              Container(
                width: spacing.x2l,
                height: spacing.xxxs,
                color: colors.primary,
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
