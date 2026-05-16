# WCAG 2.1 specification URL for a success criterion

Returns a deep link to the W3C WCAG 2.1 specification entry for one or
more success criteria.

## Usage

``` r
a11y_wcag_url(criterion)
```

## Arguments

- criterion:

  Character vector of success-criterion numbers (e.g., `"1.4.3"`).
  Recognised values are the chart-relevant subset returned by
  [`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md).

## Value

Character vector of URLs the same length as `criterion`. Returns the
spec root URL for unrecognised values.

## Examples

``` r
a11y_wcag_url("1.4.3")
#> [1] "https://www.w3.org/TR/WCAG21/#contrast-minimum"
a11y_wcag_url(c("1.1.1", "2.4.7", "4.1.3"))
#> [1] "https://www.w3.org/TR/WCAG21/#non-text-content"
#> [2] "https://www.w3.org/TR/WCAG21/#focus-visible"   
#> [3] "https://www.w3.org/TR/WCAG21/#status-messages" 
```
