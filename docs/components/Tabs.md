# FluxTabs

## Overview

Tab navigation component for switching between content panels. Supports horizontal and vertical orientations.

## Flutter API

```dart
FluxTabs(
  tabs: [
    FluxTab(label: 'Tab 1', icon: Icon(Icons.home)),
    FluxTab(label: 'Tab 2', icon: Icon(Icons.settings)),
  ],
  children: [
    TabContent1(),
    TabContent2(),
  ],
  variant: FluxTabsVariant.underlined,
);
```

## Variants

| Variant | Visual |
|---------|--------|
| underlined | Active tab has bottom border |
| pill | Active tab is a filled pill |
| contained | Tabs inside a container |
| segmented | Segmented control style |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| tabs | List<FluxTab> | - | Tab definitions |
| children | List<Widget> | - | Content panels |
| variant | FluxTabsVariant | underlined | Visual style |
| orientation | Axis | horizontal | Tab bar orientation |
| onChanged | ValueChanged<int>? | null | Tab change callback |
