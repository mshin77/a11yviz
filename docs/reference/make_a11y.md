# One-shot accessibility wrapper

Applies the most common transforms in one call: theme plus color and
fill palettes for ggplot, or layout plus palette for plotly.

## Usage

``` r
make_a11y(p, level = "AA", palette = "dark2_8", alt = NULL)
```

## Arguments

- p:

  A ggplot or plotly object.

- level:

  `"AA"` or `"AAA"`.

- palette:

  Categorical palette name passed to
  [`a11y_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_palette.md).

- alt:

  Optional alt-text string.

## Value

The transformed object.

## Examples

``` r
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  p <- ggplot(mpg, aes(class, fill = drv)) + geom_bar()
  make_a11y(p, palette = "dark2_8", alt = "Vehicle classes by drivetrain.")
}
```
