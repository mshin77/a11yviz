# Check that a tabindex value follows WCAG 2.1.1

Positive tabindex values above the natural document flow create
unpredictable keyboard navigation. WCAG 2.1.1 (Keyboard) recommends
`tabindex = 0` (natural order) or `tabindex = -1` (focusable but
skipped).

## Usage

``` r
a11y_check_tabindex(tabindex = 0)
```

## Arguments

- tabindex:

  Numeric scalar.

## Value

`TRUE` if valid; `FALSE` with a warning if non-numeric or \> 100.

## Examples

``` r
a11y_check_tabindex(0)
#> [1] TRUE
a11y_check_tabindex(-1)
#> [1] TRUE
suppressWarnings(a11y_check_tabindex(999))
#> [1] FALSE
```
