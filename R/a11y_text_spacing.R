#' WCAG 1.4.12 text-spacing ratios (reference data)
#'
#' Returns the spacing ratios specified in WCAG Success Criterion 1.4.12 (Text Spacing,
#' Level AA). All values are multiples of the font size.
#'
#' @return Named numeric vector with `line_height`, `paragraph`, `letter`,
#'   `word`.
#' @export
#' @examples
#' a11y_text_spacing_ratios()
#' a11y_text_spacing_ratios()[["line_height"]]
a11y_text_spacing_ratios <- function() {
  c(line_height = 1.5,
    paragraph   = 2.0,
    letter      = 0.12,
    word        = 0.16)
}
