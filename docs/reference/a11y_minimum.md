# Layer minimum accessibility onto a chart

Adds only the non-destructive moves: attaches alt text, and raises the
base text size to the WCAG minimum only when the current size is below
it. Palette, theme, legend, and geom aesthetics stay intact. Suitable
for retrofitting charts with an existing visual;
[`theme_a11y()`](https://mshin77.github.io/a11yviz/reference/theme_a11y.md)
and
[`scale_a11y()`](https://mshin77.github.io/a11yviz/reference/scale_a11y.md)
are the greenfield path. Pair with
[`a11y_audit_chart()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_chart.md)
to surface remaining gaps (color-only encoding, missing alt, hover
styling).

## Usage

``` r
a11y_minimum(p, alt = NULL, level = "AA")
```

## Arguments

- p:

  A `ggplot` or `plotly` object.

- alt:

  Optional alt text attached via
  [`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md).

- level:

  `"AA"` (12 pt minimum) or `"AAA"` (14 pt minimum).

## Value

The chart with alt text attached (if supplied) and base text size raised
to the level threshold when it was below.
