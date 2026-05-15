# WCAG 1.4.12 text-spacing ratios (reference data)

Returns the spacing ratios specified in WCAG Success Criterion 1.4.12
(Text Spacing, Level AA). All values are multiples of the font size.

## Usage

``` r
a11y_text_spacing_ratios()
```

## Value

Named numeric vector with `line_height`, `paragraph`, `letter`, `word`.

## Examples

``` r
a11y_text_spacing_ratios()
#> line_height   paragraph      letter        word 
#>        1.50        2.00        0.12        0.16 
a11y_text_spacing_ratios()[["line_height"]]
#> [1] 1.5
```
