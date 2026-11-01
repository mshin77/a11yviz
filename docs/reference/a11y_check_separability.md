# Flag color pairs below the WCAG 2.1 Success Criterion 1.4.11 contrast threshold

For every pair of colors in the palette, computes the WCAG
relative-luminance contrast ratio – the same formula used by
[`a11y_check_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_check_palette.md).
Pairs below `min_ratio` (default `3.0`, the WCAG 2.1 Success Criterion
1.4.11 "Non-text Contrast / Graphical Objects" threshold) are flagged.
Two data marks of similar colors may fail this – viewers cannot tell
them apart.

## Usage

``` r
a11y_check_separability(colors, min_ratio = 3)
```

## Arguments

- colors:

  Character vector of hex codes.

- min_ratio:

  Numeric threshold; default `3.0` per WCAG Success Criterion 1.4.11.

## Value

Data frame with columns `from`, `to`, `ratio`, `status`.

## Examples

``` r
a11y_check_separability(c("#1B9E77", "#D95F02", "#7570B3"))
#>      from      to ratio status
#> 1 #1B9E77 #D95F02  1.11   todo
#> 2 #1B9E77 #7570B3  1.31   todo
#> 3 #D95F02 #7570B3  1.18   todo
```
