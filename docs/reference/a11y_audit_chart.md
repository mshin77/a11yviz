# Chart-only accessibility audit

Returns the chart-relevant rows from the WCAG 2.1 audit: alt text,
redundant group encoding, text contrast, text size, non-text contrast,
hover/focus, and (at AAA) enhanced text contrast.

## Usage

``` r
a11y_audit_chart(p, level = "AA")
```

## Arguments

- p:

  A `plotly` or `ggplot` object.

- level:

  `"AA"` or `"AAA"`.

## Value

Data frame with columns `criterion`, `check`, `status`, `note`.
