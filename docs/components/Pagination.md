# FluxPagination

## Overview

Page navigation control with previous/next buttons, page numbers, and ellipsis for large page counts.

## Flutter API

```dart
FluxPagination(
  currentPage: 1,
  totalPages: 20,
  onPageChanged: (page) => loadPage(page),
  variant: FluxPaginationVariant.numbered,
)
```

## Variants

| Variant | Description |
|---------|-------------|
| numbered | Show page numbers with ellipsis |
| simple | Only prev/next with page text |
| compact | Show a subset of pages |
