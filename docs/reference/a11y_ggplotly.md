# Convert ggplot to accessible plotly for supplemental online output

Wraps
[`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html)
with
[`a11y_layout()`](https://mshin77.github.io/a11yviz/reference/a11y_layout.md)
and forwards alt text attached via
[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md).
Strips redundant chart titles. Reserve for the interactive supplement; a
static ggplot with alt text is the more accessible default.

## Usage

``` r
a11y_ggplotly(
  gg,
  level = "AA",
  palette = NULL,
  alt = NULL,
  tooltip = c("x", "y"),
  strip_title = TRUE,
  ...
)
```

## Arguments

- gg:

  A `ggplot` object.

- level:

  WCAG contrast level: `"AA"` (default) or `"AAA"`.

- palette:

  Optional palette name applied as plotly's `colorway`. `NULL` (default)
  keeps the ggplot's existing scale.

- alt:

  Alt-text override. When `NULL`, inherited from `attr(gg, "a11y_alt")`.

- tooltip:

  Aesthetic(s) shown in hover. Default `c("x", "y")`.

- strip_title:

  Logical; when `TRUE` (default) drops `title` and `subtitle` so the
  host page heading is authoritative.

- ...:

  Forwarded to
  [`plotly::ggplotly()`](https://rdrr.io/pkg/plotly/man/ggplotly.html).

## Value

A plotly object.

## Examples

``` r
# \donttest{
if (requireNamespace("ggplot2",        quietly = TRUE) &&
    requireNamespace("plotly",         quietly = TRUE) &&
    requireNamespace("palmerpenguins", quietly = TRUE)) {
  library(ggplot2)
  p <- ggplot(na.omit(palmerpenguins::penguins),
              aes(flipper_length_mm, body_mass_g,
                  color = species, shape = species)) +
    geom_point() +
    scale_color_a11y("dark2_8") +
    theme_a11y("AA")
  p <- a11y_alt_text(p, "Penguin body mass vs flipper length by species.")
  pl <- a11y_ggplotly(p)
  inherits(pl, "plotly")
}
#> [1] TRUE
# }
```
