# FluxTable

## Overview

Data table component with sortable columns, row selection, and responsive behavior.

## Flutter API

```dart
FluxTable(
  columns: [
    FluxColumn(label: 'Name', field: 'name', sortable: true),
    FluxColumn(label: 'Email', field: 'email'),
    FluxColumn(label: 'Role', field: 'role'),
  ],
  rows: users.map((u) => FluxRow(cells: [u.name, u.email, u.role])).toList(),
  onRowTap: (row) => editUser(row),
)
```

## Properties

| Property | Type | Description |
|----------|------|-------------|
| columns | List<FluxColumn> | Column definitions |
| rows | List<FluxRow> | Row data |
| selectable | bool | Enable row selection |
| sortable | bool | Enable column sorting |
| onRowTap | ValueChanged<int>? | Row tap callback |
