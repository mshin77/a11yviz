# Alpha presets for chart layers

Returns a named numeric vector of alpha values for common chart roles.
Use them when setting `alpha =` in `ggplot2::geom_*()` or plotly traces.
Alpha lowers the effective contrast a viewer sees, so verify the
composited contrast with
[`a11y_check_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_check_palette.md)
when the choice matters.

## Usage

``` r
a11y_alpha_presets()
```

## Value

Named numeric vector with elements `raw_points`, `overlay_point`,
`labels`, `fill`, `ci_ribbon`, `ci_band`.

## Examples

``` r
a11y_alpha_presets()
#>    raw_points overlay_point        labels          fill     ci_ribbon 
#>          0.40          0.60          0.70          0.90          0.10 
#>       ci_band 
#>          0.15 
a11y_alpha_presets()[["overlay_point"]]
#> [1] 0.6
```
