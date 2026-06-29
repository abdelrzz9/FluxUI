# FluxBottomSheet

## Overview

A modal bottom sheet for presenting additional content without leaving the current context. Supports standard and expanded modes.

## Flutter API

```dart
// Show bottom sheet
FluxBottomSheet.show(
  context: context,
  child: Container(
    padding: EdgeInsets.all(24),
    child: Text('Bottom sheet content'),
  ),
  draggable: true,
  useSafeArea: true,
)

// Expanded mode
FluxBottomSheet.show(
  context: context,
  child: FormContent(),
  expanded: true,
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| child | Widget | - | Sheet content |
| draggable | bool | true | Enable drag to dismiss |
| expanded | bool | false | Full-height sheet |
| useSafeArea | bool | true | Respect safe area |
