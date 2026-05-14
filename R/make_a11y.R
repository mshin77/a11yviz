#' One-shot accessibility wrapper
#'
#' Applies the most common transforms in one call: theme plus color and
#' fill palettes for ggplot, or layout plus palette for plotly.
#'
#' @param p A ggplot or plotly object.
#' @param level `"AA"` or `"AAA"`.
#' @param palette Categorical palette name passed to [a11y_palette()].
#' @param alt Optional alt-text string.
#' @return The transformed object.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   p <- ggplot(mpg, aes(class, fill = drv)) + geom_bar()
#'   make_a11y(p, palette = "dark2_8", alt = "Vehicle classes by drivetrain.")
#' }
make_a11y <- function(p, level = "AA", palette = "dark2_8", alt = NULL) {
  if (inherits(p, "ggplot")) {
    .require_pkg("ggplot2", "make_a11y")
    p <- p + theme_a11y(level = level)
    p <- p + scale_color_a11y(palette = palette)
    p <- p + scale_fill_a11y(palette = palette)
    if (!is.null(alt)) p <- a11y_alt_text(p, alt)
    return(p)
  }
  if (inherits(p, "plotly")) {
    p <- a11y_layout(p, level = level, palette = palette)
    if (!is.null(alt)) p <- a11y_alt_text(p, alt)
    return(p)
  }
  stop("make_a11y() supports ggplot and plotly objects.", call. = FALSE)
}
