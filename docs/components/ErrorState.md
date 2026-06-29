# FluxErrorState

## Overview

Displayed when an error occurs. Shows error information and a retry action.

## Flutter API

```dart
FluxErrorState(
  title: 'Something went wrong',
  message: 'Unable to load data. Please try again.',
  onRetry: () => loadData(),
  retryLabel: 'Try again',
)
```

## Properties

| Property | Type | Description |
|----------|------|-------------|
| title | String | Error heading |
| message | String? | Error description |
| onRetry | VoidCallback? | Retry action |
| retryLabel | String | Retry button text |
