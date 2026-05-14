#' WCAG 2.1 rubric for the success criteria a11yviz addresses
#'
#' Returns the chart-relevant subset of WCAG 2.1 success criteria, with the
#' AA / AAA threshold and the `a11yviz` function that addresses it. Joins
#' to [a11y_audit()] on the `criterion` column.
#'
#' @param level Optional filter: `"AA"` or `"AAA"`. `NULL` (default)
#'   returns all rows.
#' @return Data frame with columns `criterion`, `name`, `level`,
#'   `threshold_aa`, `threshold_aaa`, `a11yviz_function`. Pass any
#'   `criterion` value to [a11y_wcag_url()] for the spec link.
#' @export
#' @examples
#' a11y_rubric()
#' a11y_rubric(level = "AAA")
a11y_rubric <- function(level = NULL) {
  out <- data.frame(
    criterion = c("1.1.1", "1.3.1", "1.4.1", "1.4.3", "1.4.4",
                  "1.4.6", "1.4.10", "1.4.11", "1.4.12", "1.4.13",
                  "2.4.6", "2.4.7", "2.4.10", "3.1.5", "4.1.3"),
    name = c("Non-text Content",
             "Info and Relationships",
             "Use of Color",
             "Contrast (Minimum)",
             "Resize Text",
             "Contrast (Enhanced)",
             "Reflow",
             "Non-text Contrast",
             "Text Spacing",
             "Content on Hover or Focus",
             "Headings and Labels",
             "Focus Visible",
             "Section Headings",
             "Reading Level",
             "Status Messages"),
    level = c("A", "A", "A", "AA", "AA", "AAA", "AA", "AA", "AA", "AA",
              "AA", "AA", "AAA", "AAA", "AA"),
    threshold_aa = c("alt text required",
                     "headings nest without skips",
                     "redundant encoding (shape/linetype)",
                     "text 4.5:1; large text 3:1",
                     "resizable to 200%",
                     "--",
                     "no 2D scroll at 320 CSS px (vertical content)",
                     "non-text 3:1",
                     "line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x",
                     "tooltips dismissable, hoverable, persistent",
                     "headings + labels describe topic or purpose",
                     "visible keyboard focus",
                     "--",
                     "--",
                     "status updates announced without focus change"),
    threshold_aaa = c("alt text required",
                      "headings nest without skips",
                      "redundant encoding (shape/linetype)",
                      "--",
                      "resizable to 200%",
                      "text 7:1; large text 4.5:1",
                      "no 2D scroll at 320 CSS px (vertical content)",
                      "non-text 3:1",
                      "line-height 1.5x; paragraph 2x; letter 0.12x; word 0.16x",
                      "tooltips dismissable, hoverable, persistent",
                      "headings + labels describe topic or purpose",
                      "visible keyboard focus",
                      "section headings organize content",
                      "Flesch-Kincaid grade <= 9",
                      "status updates announced without focus change"),
    a11yviz_function = c("a11y_alt_text(), a11y_alt_template(), a11y_describe()",
                         "a11y_check_headings()",
                         "scale_color_a11y() + aes(shape = ...)",
                         "theme_a11y(), a11y_layout(), a11y_check_palette()",
                         "theme_a11y() (pt fonts; layout scales)",
                         "theme_a11y(level='AAA'), a11y_check_palette(level='AAA')",
                         "a11y_css() (@media reflow rules)",
                         "a11y_layout() (axis + gridline styling)",
                         "a11y_css(), a11y_text_spacing_ratios()",
                         "a11y_layout() (hoverlabel styling); manual Esc/persist verify",
                         "a11y_check_headings() (skips + empty + non-descriptive)",
                         "a11y_css() (focus rings)",
                         "a11y_check_headings() (level skips identify weak structure)",
                         "a11y_check_readability()",
                         "host-app live region (any HTML role='status' element)"),
    stringsAsFactors = FALSE
  )
  out <- out[, c("criterion", "name", "level", "threshold_aa",
                 "threshold_aaa", "a11yviz_function")]
  if (is.null(level)) return(out)
  level <- match.arg(level, c("AA", "AAA"))
  keep  <- c("A", "AA", if (level == "AAA") "AAA")
  out[out$level %in% keep, , drop = FALSE]
}
