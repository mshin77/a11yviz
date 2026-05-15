# Audit a plot against accessibility standards

Returns a tibble of accessibility checks, with a status per check.
Anchored to W3C WCAG 2.1. Each row carries a `criterion`
(success-criterion) number so the result joins cleanly to
[`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md).

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

Data frame with columns `criterion`, `check`, `status`, `note`. Pass any
`criterion` value to
[`a11y_wcag_url()`](https://mshin77.github.io/a11yviz/reference/a11y_wcag_url.md)
for the spec link, or join to
[`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md)
for principle, guideline, and threshold.
