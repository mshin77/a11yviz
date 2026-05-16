# Chart + document accessibility audit

Union of
[`a11y_audit_chart()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_chart.md)
and
[`a11y_audit_doc()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_doc.md).
Prefer the split functions when one scope is enough.

## Usage

``` r
a11y_audit(p, level = "AA")
```

## Arguments

- p:

  A `plotly` or `ggplot` object.

- level:

  `"AA"` or `"AAA"`.

## Value

Data frame with columns `criterion`, `check`, `status`, `note`. Join to
[`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md)
for principle, guideline, and threshold.
