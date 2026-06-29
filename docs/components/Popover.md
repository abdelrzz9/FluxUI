# FluxPopover

## Overview

Anchored popup content triggered by a button or element. Supports all placement positions and dismissible behavior.

## Flutter API

```dart
FluxPopover(
  trigger: FluxButton(child: Text('Open')),
  content: Container(
    padding: EdgeInsets.all(16),
    child: Text('Popover content'),
  ),
  position: PopoverPosition.bottom,
  onOpen: () => print('opened'),
  onClose: () => print('closed'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| trigger | Widget | - | Element that opens popover |
| content | Widget | - | Popover content |
| position | PopoverPosition | bottom | Placement |
| offset | double | 4 | Gap from trigger |
| dismissible | bool | true | Close on outside tap |
