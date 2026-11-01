# Accessible ggplot2 theme

Adds a
[`ggplot2::theme`](https://ggplot2.tidyverse.org/reference/theme.html)
that applies WCAG 2.1 contrast settings plus the package's recommended
font sizes. Compose with `+` like any other theme. Title, axis title,
and legend sit at the body floor (12 pt AA / 14 pt AAA); axis tick text
drops 2 pt below.

## Usage

``` r
theme_a11y(level = "AA", base_family = "", dark = FALSE)
```

## Arguments

- level:

  WCAG contrast level: `"AA"` (default) or `"AAA"`. The level controls
  contrast targets and the package's default font sizes; only the
  contrast targets are WCAG-defined.

- base_family:

  Font family. Defaults to system sans.

- dark:

  Logical; if `TRUE`, use a dark-mode palette appropriate for
  `darkly`-style themes.

## Value

A `theme` object.

## Examples

``` r
if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  ggplot(mtcars, aes(mpg, wt)) + geom_point() + theme_a11y()
}
```
