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
#>              name       type       source  n safe_on  purpose
#> 1    dark2_a11y_8   discrete      literal  8   white     both
#> 2  dark2_strict_5   discrete      literal  5   white     both
#> 3       okabe_ito   discrete      literal  7 labeled     both
#> 4       grayscale   discrete      literal  3   white     both
#> 5         dark2_8   discrete rcolorbrewer  8 labeled     fill
#> 6          set2_8   discrete rcolorbrewer  8 labeled     fill
#> 7       paired_12   discrete rcolorbrewer 12 labeled     fill
#> 8           aaa_5   discrete      literal  5   white     both
#> 9            rdbu  diverging rcolorbrewer NA   white gradient
#> 10           puor  diverging rcolorbrewer NA   white gradient
#> 11           brbg  diverging rcolorbrewer NA   white gradient
#> 12      rdbu_dual  diverging rcolorbrewer NA    both gradient
#> 13      puor_dual  diverging rcolorbrewer NA    both gradient
#> 14      brbg_dual  diverging rcolorbrewer NA    both gradient
#> 15   coolwarm_aaa  diverging      literal NA   white gradient
#> 16        cividis sequential  viridislite NA    both gradient
#> 17        viridis sequential  viridislite NA    both gradient
#> 18         plasma sequential  viridislite NA    both gradient
a11y_palette_list(type = "diverging")
#>            name      type       source  n safe_on  purpose
#> 9          rdbu diverging rcolorbrewer NA   white gradient
#> 10         puor diverging rcolorbrewer NA   white gradient
#> 11         brbg diverging rcolorbrewer NA   white gradient
#> 12    rdbu_dual diverging rcolorbrewer NA    both gradient
#> 13    puor_dual diverging rcolorbrewer NA    both gradient
#> 14    brbg_dual diverging rcolorbrewer NA    both gradient
#> 15 coolwarm_aaa diverging      literal NA   white gradient
```
