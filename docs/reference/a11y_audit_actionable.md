# Actionable rows from an audit

Filters an audit data frame to rows with status `todo` or `ok` – the
decisions a chart author has to make. Drops rows handled by helpers,
rows that belong to the host document, and rows marked `manual` / `n/a`.

## Usage

``` r
a11y_audit_actionable(audit)
```

## Arguments

- audit:

  Output of
  [`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md),
  [`a11y_audit_chart()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_chart.md),
  or
  [`a11y_audit_doc()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_doc.md).

## Value

Data frame with the same columns as `audit`, filtered.
