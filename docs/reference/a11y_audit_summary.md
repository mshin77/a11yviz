# One-line summary of an audit

Returns a sentence counting how many checks need a decision, how many
pass, and how many are already handled.

## Usage

``` r
a11y_audit_summary(audit)
```

## Arguments

- audit:

  Output of
  [`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md),
  [`a11y_audit_chart()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_chart.md),
  or
  [`a11y_audit_doc()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_doc.md).

## Value

Length-1 character vector.
