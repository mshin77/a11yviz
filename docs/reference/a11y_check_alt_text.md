# Check alt-text presence and length (WCAG 1.1.1)

Validates a candidate alt-text string for informative content.
Decorative elements should pass `decorative = TRUE` and use `alt=""` in
markup. Companion to
[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md),
which *attaches* alt text to a plot object; this function *validates* a
string before attaching.

## Usage

``` r
a11y_check_alt_text(
  alt_text,
  element_type = "image",
  decorative = FALSE,
  min_length = 10
)
```

## Arguments

- alt_text:

  Character or `NULL`. Candidate alt text.

- element_type:

  Character. Element type for the warning, e.g. `"plot"`.

- decorative:

  Logical. If `TRUE`, empty alt text is allowed.

- min_length:

  Integer. Minimum length for informative alt text (default 10).

## Value

`TRUE` if valid; `FALSE` with a warning otherwise.

## See also

[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md)

## Examples

``` r
a11y_check_alt_text("Bar chart showing word frequency", "plot")
#> [1] TRUE
suppressWarnings(a11y_check_alt_text("", "plot"))
#> [1] FALSE
a11y_check_alt_text("", "icon", decorative = TRUE)
#> [1] TRUE
```
