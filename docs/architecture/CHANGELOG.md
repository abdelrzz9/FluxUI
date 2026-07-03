# Changelog

## [0.1.0] — 2026-06-29 — Repository Audit & Architecture Design

### Added
- Complete audit of MColi UI repository (MicroClub-USTHB/mcoli-ui v0.2.1)
- Extracted 100+ color tokens from `registry/themes/common/colors.ts`
- Documented 5 brand themes: Primary, Secondary, GameDev, Robotics, IT
- Designed Flux UI architecture with clean package structure
- Created component inventory with 50+ widgets for porting

### Analyzed
- `McButton` — 4 variants, 4 sizes, 5 icon modes, loading, destructive
- `McCheckbox` — 2 sizes, label/support text, indeterminate state
- `McInputOtp` — Slot-based OTP with caret animation and separators
- `DropdownMenu` — Full menu system with submenus, checkbox/radio items
- `Button` — 6 variant base button from docs site

### Design Tokens Extracted
- **Colors**: 100+ raw palette colors across 15 families
- **Typography**: 5 header sizes (72px→24px) + 5 paragraph sizes (20px→12px)
- **Fonts**: DM Sans (body), Plus Jakarta Sans (headings)
- **Radius**: 5-step scale (0.125rem→1rem)
- **Shadows**: 7-level elevation system (xs→3xl)
- **Blur**: 4-level blur system
- **Spacing**: Implicit 4px base unit throughout

### Architecture
- `packages/flux_ui/` monorepo package
- 7-layer architecture: Core → Tokens → Theme → Components → Layouts → Utils → Effects
- Theme extension pattern for M3 compatibility
- Responsive breakpoint system for mobile/tablet/desktop/web
