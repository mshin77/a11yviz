#' Layer minimum accessibility onto a chart
#'
#' Adds only the non-destructive moves: attaches alt text, and raises the base
#' text size to the WCAG minimum only when the current size is below it.
#' Palette, theme, legend, and geom aesthetics stay intact. Suitable for
#' retrofitting charts with an existing visual; [theme_a11y()] and
#' [scale_a11y()] are the greenfield path. Pair with [a11y_audit_chart()] to
#' surface remaining gaps (color-only encoding, missing alt, hover styling).
#'
#' @param p A `ggplot` or `plotly` object.
#' @param alt Optional alt text attached via [a11y_alt_text()].
#' @param level `"AA"` (12 pt minimum) or `"AAA"` (14 pt minimum).
#' @return The chart with alt text attached (if supplied) and base text size
#'   raised to the level threshold when it was below.
#' @export
a11y_minimum <- function(p, alt = NULL, level = "AA") {
  if (!inherits(p, c("ggplot", "plotly")))
    stop("a11y_minimum() supports ggplot and plotly objects.", call. = FALSE)
  level     <- .check_level(level)
  threshold <- if (level == "AAA") 14 else 12
  size      <- .extract_base_size(p)
  if (!is.null(alt) && nzchar(alt)) p <- a11y_alt_text(p, alt)
  if (is.numeric(size) && size < threshold)
    p <- if (inherits(p, "ggplot"))
           p + ggplot2::theme(text = ggplot2::element_text(size = threshold))
         else
           plotly::layout(p, font = list(size = threshold))
  p
}
