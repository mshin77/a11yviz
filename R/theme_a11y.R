#' Accessible ggplot2 theme
#'
#' Adds a `ggplot2::theme` that applies WCAG 2.1 contrast settings plus
#' the package's recommended font sizes. Compose with `+` like any other
#' theme. Title, axis title, and legend sit at the body floor (12 pt AA /
#' 14 pt AAA); axis tick text drops 2 pt below.
#'
#' @param level WCAG contrast level: `"AA"` (default) or `"AAA"`. The
#'   level controls contrast targets and the package's default font
#'   sizes; only the contrast targets are WCAG-defined.
#' @param base_family Font family. Defaults to system sans.
#' @param dark Logical; if `TRUE`, use a dark-mode palette appropriate for
#'   `darkly`-style themes.
#' @return A `theme` object.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   ggplot(mtcars, aes(mpg, wt)) + geom_point() + theme_a11y()
#' }
theme_a11y <- function(level = "AA", base_family = "", dark = FALSE) {
  .require_pkg("ggplot2", "theme_a11y")
  level  <- .check_level(level)
  rules  <- .wcag_rules()
  fz     <- rules$font_size[[level]]
  fg     <- if (dark) "#dee2e6" else "#222222"
  bg     <- if (dark) "#2d2d2d" else "#ffffff"
  grid   <- if (dark) "#495057" else "#e5e5e5"
  axis_sz <- fz$axis_text %||% fz$body
  ggplot2::theme_minimal(base_family = base_family, base_size = fz$body) +
    ggplot2::theme(
      text             = ggplot2::element_text(colour = fg, family = base_family),
      plot.title       = ggplot2::element_text(size = fz$body, face = "bold", colour = fg),
      plot.subtitle    = ggplot2::element_text(size = fz$body, colour = fg),
      axis.title       = ggplot2::element_text(size = fz$body, colour = fg),
      axis.text        = ggplot2::element_text(size = axis_sz, colour = fg),
      legend.title     = ggplot2::element_text(size = fz$body, colour = fg),
      legend.text      = ggplot2::element_text(size = fz$body, colour = fg),
      strip.text       = ggplot2::element_text(size = fz$body, colour = fg),
      panel.background = ggplot2::element_rect(fill = bg, colour = NA),
      plot.background  = ggplot2::element_rect(fill = bg, colour = NA),
      panel.grid.major = ggplot2::element_line(colour = grid),
      panel.grid.minor = ggplot2::element_line(colour = grid, linewidth = 0.25)
    )
}
