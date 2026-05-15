# Check a palette against WCAG contrast thresholds

Computes the contrast ratio of every color against a reference
background and reports whether each meets the WCAG threshold (4.5:1 for
AA, 7:1 for AAA). When `alpha < 1`, contrast is computed against the
alpha-composited rendered color – the color the viewer actually sees.
Works on any palette – `viridis`, `RColorBrewer`, plotly's discrete
sequences, or a custom hex vector.

## Usage

``` r
a11y_check_palette(colors, bg = "#ffffff", level = "AA", alpha = 1)
```

## Arguments

- colors:

  Character vector of hex codes.

- bg:

  Reference background hex(es). Pass a single value (e.g. `"#ffffff"`)
  or a vector (e.g. `c("#ffffff", "#1a1a1a")`) to verify against
  multiple backgrounds. Returns one row per (color, bg) pair.

- level:

  `"AA"` (4.5:1) or `"AAA"` (7:1). Use `"AA-large"` (3:1) for non-text
  elements such as data marks, axis lines, and focus rings.

- alpha:

  Opacity in `[0, 1]`. `1` (default) checks the raw color. Values below
  1 composite each color over `bg` first, then check the rendered result
  – useful when chart geoms use `alpha < 1`.

## Value

Data frame with columns `color`, `bg`, `alpha`, `rendered`, `ratio`,
`status`.

## Examples

``` r
a11y_check_palette(c("#000000", "#cccccc", "#ff0000"))
#>     color      bg alpha rendered ratio status
#> 1 #000000 #ffffff     1  #000000 21.00     ok
#> 2 #cccccc #ffffff     1  #cccccc  1.61   todo
#> 3 #ff0000 #ffffff     1  #ff0000  4.00   todo
a11y_check_palette(c("#0072B2"), bg = c("#ffffff", "#1a1a1a"), level = "AA-large")
#>     color      bg alpha rendered ratio status
#> 1 #0072B2 #ffffff     1  #0072B2  5.19     ok
#> 2 #0072B2 #1a1a1a     1  #0072B2  3.36     ok
a11y_check_palette(c("#0072B2", "#D55E00"), alpha = 0.7, level = "AA-large")
#>     color      bg alpha rendered ratio status
#> 1 #0072B2 #ffffff   0.7  #4C9CC9  3.04     ok
#> 2 #D55E00 #ffffff   0.7  #E18E4C  2.57   todo
```
