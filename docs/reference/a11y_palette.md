# Discrete color palette (categorical)

Returns hex codes for a color-vision-aware categorical palette. Most
palettes are runtime wrappers around
[`RColorBrewer::brewer.pal()`](https://rdrr.io/pkg/RColorBrewer/man/ColorBrewer.html)
so the authoritative colors stay in their source package.

## Usage

``` r
a11y_palette(name = "dark2_8", n = NULL, bg = NULL)
```

## Arguments

- name:

  Discrete palette name. Built-in: `"dark2_8"` (default, RColorBrewer
  Dark2), `"set2_8"` (RColorBrewer Set2), `"paired_12"` (RColorBrewer
  Paired), `"aaa_5"` (custom AAA-on-white set).

- n:

  Optional number of colors. Defaults to the palette's full size
  (truncates from the start when smaller).

- bg:

  Plot background context. One of `NULL` (default – no check),
  `"white"`, or `"dark"`. When set, the function warns if the palette's
  `safe_on` tag does not match.

## Value

Character vector of hex codes (e.g., "#1B9E77"). For sequential
gradients, see
[`a11y_palette_seq()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_seq.md).

## Examples

``` r
a11y_palette("dark2_8")
#> [1] "#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D"
#> [8] "#666666"
a11y_palette("aaa_5")
#> [1] "#154E8A" "#7C2C5E" "#5C5108" "#8A3A1F" "#2D5C53"
a11y_palette("dark2_8", n = 4)
#> [1] "#1B9E77" "#D95F02" "#7570B3" "#E7298A"
```
