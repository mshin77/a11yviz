# WCAG 2.1 rubric for the success criteria a11yviz addresses

Returns the chart-relevant subset of WCAG 2.1 success criteria, with the
AA / AAA threshold and the `a11yviz` function that addresses it. Joins
to
[`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md)
on the `criterion` column.

## Usage

``` r
a11y_rubric(level = NULL)
```

## Arguments

- level:

  Optional filter: `"AA"` or `"AAA"`. `NULL` (default) returns all rows.

## Value

Data frame with columns `criterion`, `name`, `level`, `threshold_aa`,
`threshold_aaa`, `a11yviz_function`. Pass any `criterion` value to
[`a11y_wcag_url()`](https://mshin77.github.io/a11yviz/reference/a11y_wcag_url.md)
for the spec link.

## Examples

``` r
a11y_rubric()
#>    criterion                      name level
#> 1      1.1.1          Non-text Content     A
#> 2      1.3.1    Info and Relationships     A
#> 3      1.4.1              Use of Color     A
#> 4      1.4.3        Contrast (Minimum)    AA
#> 5      1.4.4               Resize Text    AA
#> 6      1.4.6       Contrast (Enhanced)   AAA
#> 7     1.4.10                    Reflow    AA
#> 8     1.4.11         Non-text Contrast    AA
#> 9     1.4.12              Text Spacing    AA
#> 10    1.4.13 Content on Hover or Focus    AA
#> 11     2.4.6       Headings and Labels    AA
#> 12     2.4.7             Focus Visible    AA
#> 13    2.4.10          Section Headings   AAA
#> 14     3.1.5             Reading Level   AAA
#> 15     4.1.3           Status Messages    AA
#>                                                threshold_aa
#> 1                                         alt text required
#> 2                               headings nest without skips
#> 3                       redundant encoding (shape/linetype)
#> 4                                text 4.5:1; large text 3:1
#> 5                                         resizable to 200%
#> 6                                                        --
#> 7             no 2D scroll at 320 CSS px (vertical content)
#> 8                                              non-text 3:1
#> 9  line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x
#> 10              tooltips dismissable, hoverable, persistent
#> 11              headings + labels describe topic or purpose
#> 12                                   visible keyboard focus
#> 13                                                       --
#> 14                                                       --
#> 15            status updates announced without focus change
#>                                               threshold_aaa
#> 1                                         alt text required
#> 2                               headings nest without skips
#> 3                       redundant encoding (shape/linetype)
#> 4                                                        --
#> 5                                         resizable to 200%
#> 6                                text 7:1; large text 4.5:1
#> 7             no 2D scroll at 320 CSS px (vertical content)
#> 8                                              non-text 3:1
#> 9  line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x
#> 10              tooltips dismissable, hoverable, persistent
#> 11              headings + labels describe topic or purpose
#> 12                                   visible keyboard focus
#> 13                        section headings organize content
#> 14                                Flesch-Kincaid grade <= 9
#> 15            status updates announced without focus change
#>                                                 a11yviz_function
#> 1          a11y_alt_text(), a11y_alt_template(), a11y_describe()
#> 2                                          a11y_check_headings()
#> 3                          scale_color_a11y() + aes(shape = ...)
#> 4              theme_a11y(), a11y_layout(), a11y_check_palette()
#> 5                         theme_a11y() (pt fonts; layout scales)
#> 6       theme_a11y(level='AAA'), a11y_check_palette(level='AAA')
#> 7                               a11y_css() (@media reflow rules)
#> 8                        a11y_layout() (axis + gridline styling)
#> 9                         a11y_css(), a11y_text_spacing_ratios()
#> 10 a11y_layout() (hoverlabel styling); manual Esc/persist verify
#> 11       a11y_check_headings() (skips + empty + non-descriptive)
#> 12                                      a11y_css() (focus rings)
#> 13   a11y_check_headings() (level skips identify weak structure)
#> 14                                      a11y_check_readability()
#> 15         host-app live region (any HTML role='status' element)
a11y_rubric(level = "AAA")
#>    criterion                      name level
#> 1      1.1.1          Non-text Content     A
#> 2      1.3.1    Info and Relationships     A
#> 3      1.4.1              Use of Color     A
#> 4      1.4.3        Contrast (Minimum)    AA
#> 5      1.4.4               Resize Text    AA
#> 6      1.4.6       Contrast (Enhanced)   AAA
#> 7     1.4.10                    Reflow    AA
#> 8     1.4.11         Non-text Contrast    AA
#> 9     1.4.12              Text Spacing    AA
#> 10    1.4.13 Content on Hover or Focus    AA
#> 11     2.4.6       Headings and Labels    AA
#> 12     2.4.7             Focus Visible    AA
#> 13    2.4.10          Section Headings   AAA
#> 14     3.1.5             Reading Level   AAA
#> 15     4.1.3           Status Messages    AA
#>                                                threshold_aa
#> 1                                         alt text required
#> 2                               headings nest without skips
#> 3                       redundant encoding (shape/linetype)
#> 4                                text 4.5:1; large text 3:1
#> 5                                         resizable to 200%
#> 6                                                        --
#> 7             no 2D scroll at 320 CSS px (vertical content)
#> 8                                              non-text 3:1
#> 9  line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x
#> 10              tooltips dismissable, hoverable, persistent
#> 11              headings + labels describe topic or purpose
#> 12                                   visible keyboard focus
#> 13                                                       --
#> 14                                                       --
#> 15            status updates announced without focus change
#>                                               threshold_aaa
#> 1                                         alt text required
#> 2                               headings nest without skips
#> 3                       redundant encoding (shape/linetype)
#> 4                                                        --
#> 5                                         resizable to 200%
#> 6                                text 7:1; large text 4.5:1
#> 7             no 2D scroll at 320 CSS px (vertical content)
#> 8                                              non-text 3:1
#> 9  line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x
#> 10              tooltips dismissable, hoverable, persistent
#> 11              headings + labels describe topic or purpose
#> 12                                   visible keyboard focus
#> 13                        section headings organize content
#> 14                                Flesch-Kincaid grade <= 9
#> 15            status updates announced without focus change
#>                                                 a11yviz_function
#> 1          a11y_alt_text(), a11y_alt_template(), a11y_describe()
#> 2                                          a11y_check_headings()
#> 3                          scale_color_a11y() + aes(shape = ...)
#> 4              theme_a11y(), a11y_layout(), a11y_check_palette()
#> 5                         theme_a11y() (pt fonts; layout scales)
#> 6       theme_a11y(level='AAA'), a11y_check_palette(level='AAA')
#> 7                               a11y_css() (@media reflow rules)
#> 8                        a11y_layout() (axis + gridline styling)
#> 9                         a11y_css(), a11y_text_spacing_ratios()
#> 10 a11y_layout() (hoverlabel styling); manual Esc/persist verify
#> 11       a11y_check_headings() (skips + empty + non-descriptive)
#> 12                                      a11y_css() (focus rings)
#> 13   a11y_check_headings() (level skips identify weak structure)
#> 14                                      a11y_check_readability()
#> 15         host-app live region (any HTML role='status' element)
```
