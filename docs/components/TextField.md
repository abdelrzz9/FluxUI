# FluxTextField

## Overview

Text input component with outlined and filled variants, validation states, leading/trailing icons, and support for multiline input.

## Flutter API

```dart
FluxTextField(
  label: 'Email',
  hint: 'Enter your email',
  leading: Icon(Icons.email),
  trailing: Icon(Icons.clear),
  validator: (v) => v?.contains('@') == true ? null : 'Invalid email',
  onChanged: (v) => print(v),
)
```

## Variants

| Variant | Visual |
|---------|--------|
| outlined | Border around field |
| filled | Filled background |

## Properties

| Property | Type | Description |
|----------|------|-------------|
| label | String? | Floating label |
| hint | String? | Placeholder text |
| leading | Widget? | Leading icon |
| trailing | Widget? | Trailing icon/widget |
| validator | FormFieldValidator<String>? | Validation |
| obscureText | bool | Password mode |
| maxLines | int? | Multiline (null = single) |
| enabled | bool | Enabled state |
| errorText | String? | Error message |
