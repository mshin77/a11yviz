#' Check alt-text presence and length (WCAG 1.1.1)
#'
#' Validates a candidate alt-text string for informative content. Decorative
#' elements should pass `decorative = TRUE` and use `alt=""` in markup.
#' Companion to [a11y_alt_text()], which *attaches* alt text to a plot object;
#' this function *validates* a string before attaching.
#'
#' @param alt_text Character or `NULL`. Candidate alt text.
#' @param element_type Character. Element type for the warning, e.g. `"plot"`.
#' @param decorative Logical. If `TRUE`, empty alt text is allowed.
#' @param min_length Integer. Minimum length for informative alt text (default 10).
#' @return `TRUE` if valid; `FALSE` with a warning otherwise.
#' @seealso [a11y_alt_text()]
#' @export
#' @examples
#' a11y_check_alt_text("Bar chart showing word frequency", "plot")
#' suppressWarnings(a11y_check_alt_text("", "plot"))
#' a11y_check_alt_text("", "icon", decorative = TRUE)
a11y_check_alt_text <- function(alt_text,
                                element_type = "image",
                                decorative = FALSE,
                                min_length = 10) {
  if (decorative) return(TRUE)
  if (is.null(alt_text) || !nzchar(alt_text)) {
    warning("Missing alt text for ", element_type, " (WCAG 1.1.1)")
    return(FALSE)
  }
  if (nchar(alt_text) < min_length) {
    warning("Alt text too short for ", element_type,
            " (< ", min_length, " chars; consider more descriptive text)")
    return(FALSE)
  }
  TRUE
}
