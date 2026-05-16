# Launch the local accessibility playground

Opens a Shiny app comparing default `ggplot2` output against the
accessible theme, palette, and alt-text helpers, with a per-criterion
WCAG audit. Requires `shiny`, `bslib`, `ggplot2`, and `DT`; missing
packages are flagged at launch.

## Usage

``` r
run_app(...)
```

## Arguments

- ...:

  Passed to
  [`shiny::runApp()`](https://rdrr.io/pkg/shiny/man/runApp.html).

## Value

Invisibly, the return value of
[`shiny::runApp()`](https://rdrr.io/pkg/shiny/man/runApp.html).

## Examples

``` r
if (interactive()) run_app()
```
