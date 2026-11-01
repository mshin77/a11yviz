# Build an ARIA label string

Generates a semantic `aria-label` value combining an action, element
type, and optional context. Intended for Shiny UI elements (buttons,
inputs).

## Usage

``` r
a11y_aria_label(element_type, action, context = NULL)
```

## Arguments

- element_type:

  Character. Element type, e.g. `"button"`, `"input"`.

- action:

  Character. Action verb, e.g. `"analyze"`, `"download"`.

- context:

  Character or `NULL`. Optional disambiguating context.

## Value

Character scalar suitable for `aria-label`.

## Examples

``` r
a11y_aria_label("button", "analyze", "readability")
#> [1] "Analyze readability button"
a11y_aria_label("input", "search")
#> [1] "Search input"
```
