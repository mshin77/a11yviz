# Flag categorical palettes above the recommended maximum

Distinguishability drops fast above seven categories even in CVD-safe
palettes; consider faceting, aggregation, or a sequential / ordinal
encoding instead.

## Usage

``` r
a11y_check_palette_size(n, max = 7)
```

## Arguments

- n:

  Integer; number of categories.

- max:

  Integer; recommended maximum. Default `7`.

## Value

Named list with `n`, `max`, `status` (`"ok"` / `"todo"`), `note`.

## Examples

``` r
a11y_check_palette_size(5)
#> $n
#> [1] 5
#> 
#> $max
#> [1] 7
#> 
#> $status
#> [1] "ok"
#> 
#> $note
#> [1] "5 categories within recommended max 7"
#> 
a11y_check_palette_size(12)
#> $n
#> [1] 12
#> 
#> $max
#> [1] 7
#> 
#> $status
#> [1] "todo"
#> 
#> $note
#> [1] "12 categories exceeds recommended max 7; consider faceting or aggregation"
#> 
```
