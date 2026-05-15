# Accessible sequential continuous color and fill scales

ggplot2 scales for sequential viridisLite gradients sourced from
[`a11y_palette_seq()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_seq.md).
The default `"cividis"` remains readable in greyscale and spans the full
lightness range.

## Usage

``` r
scale_color_a11y_seq(palette = "cividis", ...)

scale_fill_a11y_seq(palette = "cividis", ...)
```

## Arguments

- palette:

  One of `"cividis"` (default), `"viridis"`, `"plasma"`.

- ...:

  Passed to `ggplot2::scale_*_viridis_c()`.

## Value

A ggplot2 scale.
