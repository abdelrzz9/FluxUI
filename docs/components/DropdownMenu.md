# FluxDropdownMenu

## Overview

A complete dropdown menu system with items, submenus, checkbox items, radio items, labels, separators, and keyboard navigation. Ported from `DropdownMenu` (MColi UI, based on `@base-ui/react/menu`).

## React Source

`components/ui/dropdown-menu.tsx` — Full DropdownMenu subsystem

## Design Inspiration

Uses `@base-ui/react/menu` for accessible menu behavior. The menu supports submenus with arrow indicators, checkbox/radio items, item grouping with labels, and keyboard navigation. Animations include fade, zoom, and slide-in effects.

## Flutter API

### Root

```dart
FluxDropdownMenu(
  child: ...,
  menuBuilder: (context) => FluxDropdownMenuContent(
    children: [
      FluxDropdownMenuItem(
        leading: Icon(Icons.user),
        onPressed: () {},
        child: Text('Profile'),
      ),
    ],
  ),
)
```

### Sub-widgets

| Widget | Purpose |
|--------|---------|
| `FluxDropdownMenu` | Root controller |
| `FluxDropdownMenuTrigger` | Trigger button |
| `FluxDropdownMenuContent` | Popup content container |
| `FluxDropdownMenuItem` | Clickable menu item |
| `FluxDropdownMenuLabel` | Section label |
| `FluxDropdownMenuGroup` | Group container |
| `FluxDropdownMenuSeparator` | Divider line |
| `FluxDropdownMenuCheckboxItem` | Checkable item |
| `FluxDropdownMenuRadioItem` | Radio item |
| `FluxDropdownMenuRadioGroup` | Radio group |
| `FluxDropdownMenuSub` | Submenu root |
| `FluxDropdownMenuSubTrigger` | Submenu trigger item |
| `FluxDropdownMenuSubContent` | Submenu content |
| `FluxDropdownMenuShortcut` | Keyboard shortcut display |
| `FluxDropdownMenuPortal` | Portal support |

### Properties (FluxDropdownMenuItem)

| Property | Type | Description |
|----------|------|-------------|
| leading | Widget? | Leading icon/avatar |
| trailing | Widget? | Trailing widget |
| shortcut | String? | Keyboard shortcut text |
| onPressed | VoidCallback? | Tap callback |
| inset | bool? | Indented item |
| variant | MenuItemVariant | `default` or `destructive` |
| disabled | bool | Disabled state |
| child | Widget | Item label |

### Variants

- `default`: Normal menu item
- `destructive`: Red-colored dangerous action

### Identifiers

| Variant | Visual |
|---------|--------|
| default | Normal text/icon colors |
| destructive | Red text, red hover background |

### Animations

- Open: `animate-in`, `fade-in-0`, `zoom-in-95`, `slide-in-from-top-2`
- Close: `animate-out`, `fade-out-0`, `zoom-out-95`
- Duration: `100ms`
- Submenu: `slide-in-from-left/right-2`

### Accessibility

- ARIA `menu`, `menuitem` roles
- Keyboard: Arrow keys to navigate
- Enter/Space to select
- Escape to close
- Type-ahead to find items
- Focus management

## Examples

```dart
// Simple dropdown
FluxDropdownMenu(
  trigger: FluxButton(child: Text('Open')),
  children: [
    FluxDropdownMenuItem(
      leading: Icon(Icons.edit),
      onPressed: () {},
      child: Text('Edit'),
    ),
    FluxDropdownMenuItem(
      leading: Icon(Icons.copy),
      onPressed: () {},
      child: Text('Duplicate'),
    ),
    FluxDropdownMenuSeparator(),
    FluxDropdownMenuItem(
      variant: MenuItemVariant.destructive,
      leading: Icon(Icons.delete),
      onPressed: () {},
      child: Text('Delete'),
    ),
  ],
)

// With submenus
FluxDropdownMenu(...items: [
  FluxDropdownMenuItem(child: Text('New Tab'), shortcut: 'Ctrl+T'),
  FluxDropdownMenuItem(child: Text('New Window'), shortcut: 'Ctrl+N'),
  FluxDropdownMenuSub(
    label: 'Open Recent',
    children: [
      FluxDropdownMenuItem(child: Text('file1.txt')),
      FluxDropdownMenuItem(child: Text('file2.txt')),
    ],
  ),
])

// With checkable items
FluxDropdownMenuCheckboxItem(
  checked: showToolbar,
  onCheckedChange: (v) => setState(() => showToolbar = v),
  child: Text('Toolbar'),
)
```

## Best Practices

**Do:**
- Group related items with `FluxDropdownMenuGroup` and `FluxDropdownMenuLabel`
- Use separator between logical sections
- Show shortcuts for keyboard actions
- Use destructive variant for dangerous actions

**Don't:**
- Nest submenus more than 2 levels deep
- Mix radio and checkbox items in the same group
- Use overly long labels

## Implementation Notes

- Flutter uses `PopupMenuEntry` system or custom overlay with `CompositedTransformFollower`
- Content positioning uses alignment and offset parameters
- Submenus open on hover or arrow-right
- Portal support for overflow scenarios
- React's `@base-ui/react/menu` maps to Flutter's `showMenu` or custom `OverlayEntry`

## Future Improvements

- Cascading submenu positioning
- Scrollable long menus
- Animated item icons
