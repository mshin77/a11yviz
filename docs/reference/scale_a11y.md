# Accessible discrete color and fill scales

Categorical palettes that meet WCAG 1.4.1 (Use of Color) by being
distinguishable to viewers with color vision differences.

## Usage

``` r
scale_color_a11y(palette = NULL, level = "AA", ...)

scale_fill_a11y(palette = NULL, level = "AA", ...)
```

## Arguments

- palette:

  One of `"dark2_8"` (default), `"set2_8"`, `"paired_12"`, `"aaa_5"`.
  See
  [`a11y_palette_list()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_list.md).

- level:

  WCAG contrast level. `"AAA"` switches the default palette to `"aaa_5"`
  (deep, AAA-on-white set). Ignored if `palette` is set explicitly.

- ...:

  Passed to
  [`ggplot2::discrete_scale`](https://ggplot2.tidyverse.org/reference/discrete_scale.html).

## Value

A ggplot2 scale.

## Examples

``` r
if (requireNamespace("ggplot2",        quietly = TRUE) &&
    requireNamespace("palmerpenguins", quietly = TRUE)) {
  library(ggplot2)
  pg <- na.omit(palmerpenguins::penguins)
  ggplot(pg, aes(flipper_length_mm, body_mass_g, color = species)) +
    geom_point() + scale_color_a11y()
  ggplot(pg, aes(species, fill = island)) +
    geom_bar() + scale_fill_a11y("set2_8")
}
```
