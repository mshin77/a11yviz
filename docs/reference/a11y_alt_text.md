# Add alt text to a plot

For plotly objects, sets the figure-level `aria-label` and a hidden
description div. For ggplot, attaches the alt text as an attribute that
Quarto renders as `<img alt="...">`.

## Usage

``` r
a11y_alt_text(p, text)
```

## Arguments

- p:

  A plotly or ggplot object.

- text:

  Character. Concise description for screen readers.

## Value

The object with alt text attached.

## Examples

``` r
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
  a11y_alt_text(p, "Scatter of car weight against fuel economy.")
}
```
