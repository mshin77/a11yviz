#' Check that a tabindex value follows WCAG 2.1.1
#'
#' Positive tabindex values above the natural document flow create
#' unpredictable keyboard navigation. WCAG 2.1.1 (Keyboard) recommends
#' `tabindex = 0` (natural order) or `tabindex = -1` (focusable but skipped).
#'
#' @param tabindex Numeric scalar.
#' @return `TRUE` if valid; `FALSE` with a warning if non-numeric or > 100.
#' @export
#' @examples
#' a11y_check_tabindex(0)
#' a11y_check_tabindex(-1)
#' suppressWarnings(a11y_check_tabindex(999))
a11y_check_tabindex <- function(tabindex = 0) {
  if (!is.numeric(tabindex)) {
    warning("tabindex must be numeric")
    return(FALSE)
  }
  if (tabindex > 100) {
    warning("tabindex > 100 creates unpredictable tab order (WCAG 2.1.1)")
    return(FALSE)
  }
  TRUE
}
