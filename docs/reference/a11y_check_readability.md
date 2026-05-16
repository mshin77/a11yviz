# Estimate reading level of prose

Computes Flesch-Kincaid Grade Level and Flesch Reading Ease for the
supplied text. Pure base R with a syllable-count heuristic; no external
dependencies. Maps to WCAG 2.1 Success Criterion 3.1.5 (Reading Level,
AAA).

## Usage

``` r
a11y_check_readability(text)
```

## Arguments

- text:

  Character vector, single string, or path to a `.md`, `.qmd`, `.Rmd`,
  or `.txt` file.

## Value

Data frame with one row and columns `sentences`, `words`, `syllables`,
`flesch_kincaid_grade`, `flesch_reading_ease`.

## Examples

``` r
a11y_check_readability("The cat sat on the mat. The dog ran away.")
#>   sentences words syllables flesch_kincaid_grade flesch_reading_ease
#> 1         2    10        11                -0.66               108.7
```
