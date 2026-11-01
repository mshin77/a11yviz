# Check Markdown / Quarto / HTML heading hierarchy and labels

Scans a file for three heading defects: (a) skipped heading levels
(e.g., `##` followed by `####`), (b) empty headings, (c) non-descriptive
headings (text shorter than `min_chars`). These violate WCAG 2.1 Success
Criteria 1.3.1 (Info and Relationships), 2.4.6 (Headings and Labels),
and 2.4.10 (Section Headings).

## Usage

``` r
a11y_check_headings(path, min_chars = 3)
```

## Arguments

- path:

  Path to a `.md`, `.qmd`, `.Rmd`, or `.html` file.

- min_chars:

  Minimum heading text length (after trimming) considered descriptive.
  Default `3`.

## Value

Data frame with one row per issue, columns `line`, `level`, `text`,
`issue`. Empty data frame if no issues.

## Examples

``` r
if (FALSE) { # \dontrun{
  a11y_check_headings("paper.qmd")
} # }
```
