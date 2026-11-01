# Accessible diverging color and fill scales

ggplot2 scales for diverging gradients with anchor colors sourced from
[`a11y_palette_div()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_div.md).

## Usage

``` r
scale_color_a11y_div(palette = "rdbu", ...)

scale_fill_a11y_div(palette = "rdbu", ...)
```

## Arguments

- palette:

  One of `"rdbu"` (default), `"puor"`, `"brbg"`, `"coolwarm_aaa"`.

- ...:

  Passed to `ggplot2::scale_*_gradient2()`.

## Value

A ggplot2 scale.
