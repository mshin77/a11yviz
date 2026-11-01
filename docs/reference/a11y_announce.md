# Announce a status message to assistive technology

Pair with a CSS rule that defines `.screen-reader-only` (see
[`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md)).

## Usage

``` r
a11y_announce(text)
```

## Arguments

- text:

  Character. Message to announce.

## Value

Character scalar containing HTML.

## See also

[`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md)

## Examples

``` r
a11y_announce("Loading results, please wait")
#> [1] "<span class=\"screen-reader-only\" role=\"status\" aria-live=\"polite\">Loading results, please wait</span>"
```
