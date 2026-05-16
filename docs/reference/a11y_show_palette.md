# Visualize a palette with WCAG contrast overlay

Renders the swatches of a built-in palette and overlays each color's
contrast ratio against `bg`, plus a pass/fail label for `level`.

## Usage

``` r
a11y_show_palette(name = "dark2_8", bg = "#ffffff", level = "AA")
```

## Arguments

- name:

  Discrete palette name. See
  [`a11y_palette_list()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_list.md).

- bg:

  Reference background hex (default `"#ffffff"`).

- level:

  `"AA"` or `"AAA"`.

## Value

A ggplot object.

## Examples

``` r
if (requireNamespace("ggplot2", quietly = TRUE)) {
  a11y_show_palette("dark2_8")
}
```
