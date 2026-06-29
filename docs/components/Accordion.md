# FluxAccordion

## Overview

Collapsible content panels for organizing information vertically. Supports single and multiple expansion.

## Flutter API

```dart
FluxAccordion(
  items: [
    FluxAccordionItem(
      title: 'Section 1',
      content: Text('Content 1'),
    ),
    FluxAccordionItem(
      title: 'Section 2',
      content: Text('Content 2'),
    ),
  ],
  multiple: false, // Only one open at a time
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| items | List<FluxAccordionItem> | - | Accordion items |
| multiple | bool | false | Allow multiple open |
| variant | FluxAccordionVariant | outlined | Visual style |

## Animations

- Collapse/expand with animated cross-fade
- Chevron rotation on open/close
- Duration: 200ms ease
