# FluxEmptyState

## Overview

Displayed when there is no data to show. Includes an icon, title, description, and optional action button.

## Flutter API

```dart
FluxEmptyState(
  icon: Icon(Icons.inbox_outlined, size: 48),
  title: 'No messages',
  description: 'You have no unread messages at this time.',
  action: FluxButton(
    onPressed: () {},
    child: Text('Refresh'),
  ),
)
```

## Properties

| Property | Type | Description |
|----------|------|-------------|
| icon | Widget? | Large icon |
| title | String | Heading text |
| description | String? | Body text |
| action | Widget? | Call-to-action button |
