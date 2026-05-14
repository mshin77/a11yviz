#' Build an ARIA label string
#'
#' Generates a semantic `aria-label` value combining an action, element type,
#' and optional context. Intended for Shiny UI elements (buttons, inputs).
#'
#' @param element_type Character. Element type, e.g. `"button"`, `"input"`.
#' @param action Character. Action verb, e.g. `"analyze"`, `"download"`.
#' @param context Character or `NULL`. Optional disambiguating context.
#' @return Character scalar suitable for `aria-label`.
#' @export
#' @examples
#' a11y_aria_label("button", "analyze", "readability")
#' a11y_aria_label("input", "search")
a11y_aria_label <- function(element_type, action, context = NULL) {
  if (is.null(context)) {
    paste(tools::toTitleCase(action), element_type)
  } else {
    paste(tools::toTitleCase(action), context, element_type)
  }
}
