# Generate a deterministic alt-text template for a plot

Introspects a `ggplot` or `plotly` object and emits a sentence scaffold
with chart type, axis labels, ranges, and group counts pre-filled. A
bracketed placeholder marks where the substantive trend description
belongs. Pass the edited string to
[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md)
to attach it.

## Usage

``` r
a11y_alt_template(p)
```

## Arguments

- p:

  A `ggplot` or `plotly` object.

## Value

Character scalar.

## Examples

``` r
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  p <- ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) + geom_point()
  a11y_alt_template(p)
}
#> [1] "Scatter plot of mpg versus wt, 32 data points. X axis: wt, range 1.51 to 5.42. Y axis: mpg, range 10.4 to 33.9. Colored by factor(cyl) (3 groups: 6, 4, 8). [REPLACE - describe the substantive trend, e.g., direction, clusters, outliers.]"
```
