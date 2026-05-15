# Discrete palette metadata

Returns the source spec, resolved colors, and WCAG metadata for a
discrete palette. For continuous palettes, see
[`a11y_palette_div()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_div.md)
and
[`a11y_palette_seq()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_seq.md).

## Usage

``` r
a11y_palette_info(name = "dark2_8")
```

## Arguments

- name:

  Discrete palette name. Built-in: `"dark2_8"` (default, RColorBrewer
  Dark2), `"set2_8"` (RColorBrewer Set2), `"paired_12"` (RColorBrewer
  Paired), `"aaa_5"` (custom AAA-on-white set).

## Value

Named list with `name`, `colors`, `safe_on`, `purpose`, `notes`, plus
the source spec fields.

## Examples

``` r
a11y_palette_info("aaa_5")
#> $name
#> [1] "aaa_5"
#> 
#> $colors
#> [1] "#154E8A" "#7C2C5E" "#5C5108" "#8A3A1F" "#2D5C53"
#> 
#> $source
#> [1] "literal"
#> 
#> $colors
#> [1] "#154E8A" "#7C2C5E" "#5C5108" "#8A3A1F" "#2D5C53"
#> 
#> $safe_on
#> [1] "white"
#> 
#> $purpose
#> [1] "both"
#> 
#> $notes
#> [1] "Custom AAA-on-white categorical (deep blue / purple / olive / terracotta / teal). All five > 7.5:1 on white. Distinguishability under color-vision differences not formally validated -- pair with shape or linetype for redundant encoding (WCAG 1.4.1)."
#> 
```
