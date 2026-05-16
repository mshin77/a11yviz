# Sequential continuous palette

Returns a viridisLite spec (option, begin, end, direction) for a
sequential gradient. Use directly with `ggplot2::scale_*_viridis_c()` or
via
[`scale_fill_a11y_seq()`](https://mshin77.github.io/a11yviz/reference/scale_a11y_seq.md).
Pass `n =` to materialize hex codes.

## Usage

``` r
a11y_palette_seq(name = "cividis", n = NULL)
```

## Arguments

- name:

  One of `"cividis"` (default), `"viridis"`, `"plasma"`.

- n:

  Optional integer. If supplied, returns `n` hex codes from the gradient
  instead of the spec.

## Value

Named list with elements `option`, `begin`, `end`, `direction` – a
viridisLite specification, NOT a color vector. Pass `n =` to materialize
hex codes.

## Examples

``` r
a11y_palette_seq("cividis")
#> $option
#> [1] "cividis"
#> 
#> $begin
#> [1] 0
#> 
#> $end
#> [1] 1
#> 
#> $direction
#> [1] 1
#> 
a11y_palette_seq("viridis", n = 7)
#> [1] "#440154FF" "#443A83FF" "#31688EFF" "#21908CFF" "#35B779FF" "#8FD744FF"
#> [7] "#FDE725FF"
```
