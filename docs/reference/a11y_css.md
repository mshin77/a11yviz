# Path to the accessible CSS

Returns the filesystem path to `a11yviz.css`, an accessible stylesheet
that makes plotly, DT, DiagrammeR, and static plot images theme-aware
and applies WCAG-aligned defaults for contrast, focus, and text spacing.
Use it in Quarto via `css:`, in Shiny via `tags$link()`, or copy it into
a project's `www/`.

## Usage

``` r
a11y_css(mode = c("default", "shiny"))
```

## Arguments

- mode:

  `"default"` returns the base CSS path; `"shiny"` also appends
  `a11yviz-shiny.css` (skip-link, screen-reader-only text,
  reduced-motion, high-contrast rules) in load order.

## Value

Character path (default) or character vector of paths (shiny).

## Examples

``` r
a11y_css()
#> [1] "redacted"
a11y_css("shiny")
#> [1] "redacted"      
#> [2] "redacted"
```
