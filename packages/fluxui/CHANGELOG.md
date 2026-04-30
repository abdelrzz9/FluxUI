# Changelog

## 0.1.0

Initial release of `fluxui_kit`.

### Added

- `AppTheme` — light, dark, and fully custom theme generation built on `AppDesignTokens`.
- `AppThemeTokens` — `ThemeExtension` carrying the full typed token set for use in widget trees.
- **30 production-ready widgets:**
  - `AppButton` (4 variants, 3 sizes, loading state)
  - `AppCard` (surface, outlined, muted)
  - `AppAvatar` (image, initials, icon fallback; 5 sizes)
  - `AppBadge` (label and dot; 5 semantic variants)
  - `AppCarousel` (paginated with controls and indicators)
  - `AppAlert` (info, success, warning, danger, neutral)
  - `AppProgress` (linear and circular)
  - `AppDialog` (with `show` and `confirm` static helpers)
  - `AppBottomSheet` (with `show` static helper and drag handle)
  - `AppToast` (5 variants via `ScaffoldMessenger`)
  - `AppSkeleton` (shimmer animation; text and circular variants)
  - `AppTextField` (outline and filled)
  - `AppCombobox` (searchable bottom-sheet picker)
  - `AppOtpField` (paste support, backspace navigation)
  - `AppSearchBar` (auto-clear button)
  - `AppSlider` (token-driven with live value label)
  - `Gap`, `HStack`, `VStack` (layout primitives)
  - `AppAppBar` (token-driven, `PreferredSizeWidget`)
  - `AppBottomNav` (badge support, safe-area aware)
  - `AppNavigationMenu` (tabbed panel navigation)
  - `AppPagination` (ellipsis, prev/next)
  - `AppTabs` (with optional panel content)
  - `AppRoadmapItem` (planned, active, completed states)
  - `AppCheckbox` (labeled, tristate)
  - `AppChip` (filter and removable variants)
  - `AppRadio` + `AppRadioGroup` (custom drawn, generic)
  - `AppSwitch` (labeled toggle)
  - `AppText` (15 type scale variants, 7 semantic tones)
- Full `AppDesignTokens` re-export (colors, spacing, radius, sizes, motion, typography).
- `BuildContext` extensions: `context.appColors`, `context.appSpacing`, `context.appRadius`, `context.appSizes`, `context.appMotion`, `context.appTypography`.
