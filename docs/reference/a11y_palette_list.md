# List available palettes

Lists discrete, diverging, and sequential palettes in one data frame.

## Usage

``` r
a11y_palette_list(type = NULL)
```

## Arguments

- type:

  Optional filter: `"discrete"`, `"diverging"`, or `"sequential"`.
  `NULL` (default) returns all.

## Value

Data frame with columns `name`, `type`, `source`, `n`, `safe_on`,
`purpose`. `n` is `NA` for continuous palettes. For the `notes` field of
a single palette, call
[`a11y_palette_info()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_info.md).

## Examples

``` r
a11y_palette_list()
#>            name       type       source  n safe_on  purpose
#> 1       dark2_8   discrete rcolorbrewer  8 labeled     fill
#> 2        set2_8   discrete rcolorbrewer  8 labeled     fill
#> 3     paired_12   discrete rcolorbrewer 12 labeled     fill
#> 4         aaa_5   discrete      literal  5   white     both
#> 5          rdbu  diverging rcolorbrewer NA   white gradient
#> 6          puor  diverging rcolorbrewer NA   white gradient
#> 7          brbg  diverging rcolorbrewer NA   white gradient
#> 8     rdbu_dual  diverging rcolorbrewer NA    both gradient
#> 9     puor_dual  diverging rcolorbrewer NA    both gradient
#> 10    brbg_dual  diverging rcolorbrewer NA    both gradient
#> 11 coolwarm_aaa  diverging      literal NA   white gradient
#> 12      cividis sequential  viridislite NA    both gradient
#> 13      viridis sequential  viridislite NA    both gradient
#> 14       plasma sequential  viridislite NA    both gradient
a11y_palette_list(type = "diverging")
#>            name      type       source  n safe_on  purpose
#> 5          rdbu diverging rcolorbrewer NA   white gradient
#> 6          puor diverging rcolorbrewer NA   white gradient
#> 7          brbg diverging rcolorbrewer NA   white gradient
#> 8     rdbu_dual diverging rcolorbrewer NA    both gradient
#> 9     puor_dual diverging rcolorbrewer NA    both gradient
#> 10    brbg_dual diverging rcolorbrewer NA    both gradient
#> 11 coolwarm_aaa diverging      literal NA   white gradient
```
