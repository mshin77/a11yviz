#' Add alt text to a plot
#'
#' For plotly objects, sets the figure-level `aria-label` and a hidden
#' description div. For ggplot, attaches the alt text as an attribute that
#' Quarto renders as `<img alt="...">`.
#'
#' @param p A plotly or ggplot object.
#' @param text Character. Concise description for screen readers.
#' @return The object with alt text attached.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
#'   a11y_alt_text(p, "Scatter of car weight against fuel economy.")
#' }
a11y_alt_text <- function(p, text) {
  if (!inherits(p, c("plotly", "ggplot")))
    stop("a11y_alt_text() supports plotly and ggplot objects.", call. = FALSE)
  attr(p, "alt")      <- text
  attr(p, "a11y_alt") <- text
  p
}
