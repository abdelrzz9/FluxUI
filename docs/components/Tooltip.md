# FluxTooltip

## Overview

Rich tooltip with custom content, all placement positions, and hover/focus activation. Extends Material's built-in Tooltip.

## Flutter API

```dart
FluxTooltip(
  message: 'This explains the feature',
  position: TooltipPosition.top,
  rich: true,
  child: Icon(Icons.info),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| message | String | - | Tooltip text |
| position | TooltipPosition | top | Placement |
| rich | bool | false | Enable rich formatting |
| duration | Duration | 2s | Show duration |
| child | Widget | - | Target widget |
