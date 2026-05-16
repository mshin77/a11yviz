# Diverging palette

Returns the low/mid/high anchor colors for a diverging gradient. Most
palettes resolve at runtime from `RColorBrewer`. `*_dual` variants pick
mid-saturation Brewer positions whose endpoints clear non-text 3:1 on
both white and `#1a1a1a` dark backgrounds. `coolwarm_aaa` is a custom
built-in whose endpoints both clear AAA on white only.

## Usage

``` r
a11y_palette_div(name = "rdbu")
```

## Arguments

- name:

  One of `"rdbu"` (default), `"puor"`, `"brbg"`, `"rdbu_dual"`,
  `"puor_dual"`, `"brbg_dual"`, `"coolwarm_aaa"`.

## Value

Named list with elements `low`, `mid`, `high` (hex codes for the
diverging anchors). To materialize an N-step gradient, pass the list to
a color interpolator (e.g.,
[`grDevices::colorRampPalette()`](https://rdrr.io/r/grDevices/colorRamp.html)).

## Examples

``` r
a11y_palette_div("rdbu")
#> $low
#> [1] "#2166AC"
#> 
#> $mid
#> [1] "#F7F7F7"
#> 
#> $high
#> [1] "#B2182B"
#> 
a11y_palette_div("rdbu_dual")
#> $low
#> [1] "#4393C3"
#> 
#> $mid
#> [1] "#F7F7F7"
#> 
#> $high
#> [1] "#D6604D"
#> 
```
