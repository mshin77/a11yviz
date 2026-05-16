# Contents of the accessible CSS

Reads the bundled CSS file(s) returned by
[`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md)
and concatenates them as a single string. Useful for embedding inline in
Quarto via `<style>` tags or in Shiny via `tags$style()`.

## Usage

``` r
a11y_css_contents(mode = c("default", "shiny"))
```

## Arguments

- mode:

  `"default"` returns the base CSS path; `"shiny"` also appends
  `a11yviz-shiny.css` (skip-link, screen-reader-only text,
  reduced-motion, high-contrast rules) in load order.

## Value

Character scalar of CSS source.

## Examples

``` r
nchar(a11y_css_contents())
#> [1] 6284
```
