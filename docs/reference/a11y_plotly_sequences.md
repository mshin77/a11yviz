# Audit plotly's built-in discrete color sequences

Plotly ships several discrete categorical sequences (from plotly.js).
This helper computes WCAG contrast statistics for each one against a
reference background so users can pick a sequence that passes their
contrast bar.

## Usage

``` r
a11y_plotly_sequences(bg = "#ffffff", level = "AA")
```

## Arguments

- bg:

  Reference background hex (default `"#ffffff"`).

- level:

  `"AA"` (4.5:1) or `"AAA"` (7:1).

## Value

Data frame with one row per sequence: `name`, `n`, `min_ratio`,
`median_ratio`, `n_pass`, `pct_pass`.

## Examples

``` r
a11y_plotly_sequences()
#>     name  n min_ratio median_ratio n_pass pct_pass
#> 3    G10 10      2.14         4.30      5     50.0
#> 5  Vivid 12      1.95         3.38      4     33.3
#> 6   Bold 12      1.82         3.53      4     33.3
#> 2     D3 10      2.01         3.70      3     30.0
#> 4    T10 10      1.60         2.85      1     10.0
#> 1 Plotly 10      1.41         2.04      0      0.0
#> 7 Pastel 12      1.49         1.99      0      0.0
a11y_plotly_sequences(level = "AAA")
#>     name  n min_ratio median_ratio n_pass pct_pass
#> 6   Bold 12      1.82         3.53      2     16.7
#> 3    G10 10      2.14         4.30      1     10.0
#> 1 Plotly 10      1.41         2.04      0      0.0
#> 2     D3 10      2.01         3.70      0      0.0
#> 4    T10 10      1.60         2.85      0      0.0
#> 5  Vivid 12      1.95         3.38      0      0.0
#> 7 Pastel 12      1.49         1.99      0      0.0
```
