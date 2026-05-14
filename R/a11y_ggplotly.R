#' Convert ggplot to accessible plotly for supplemental online output
#'
#' Wraps [plotly::ggplotly()] with [a11y_layout()] and forwards alt text
#' attached via [a11y_alt_text()]. Strips redundant chart titles. Reserve
#' for the interactive supplement; a static ggplot with alt text is the
#' more accessible default.
#'
#' @param gg A `ggplot` object.
#' @param level WCAG contrast level: `"AA"` (default) or `"AAA"`.
#' @param palette Optional palette name applied as plotly's `colorway`.
#'   `NULL` (default) keeps the ggplot's existing scale.
#' @param alt Alt-text override. When `NULL`, inherited from
#'   `attr(gg, "a11y_alt")`.
#' @param tooltip Aesthetic(s) shown in hover. Default `c("x", "y")`.
#' @param strip_title Logical; when `TRUE` (default) drops `title` and
#'   `subtitle` so the host page heading is authoritative.
#' @param ... Forwarded to [plotly::ggplotly()].
#' @return A plotly object.
#' @export
#' @examples
#' \donttest{
#' if (requireNamespace("ggplot2",        quietly = TRUE) &&
#'     requireNamespace("plotly",         quietly = TRUE) &&
#'     requireNamespace("palmerpenguins", quietly = TRUE)) {
#'   library(ggplot2)
#'   p <- ggplot(na.omit(palmerpenguins::penguins),
#'               aes(flipper_length_mm, body_mass_g,
#'                   color = species, shape = species)) +
#'     geom_point() +
#'     scale_color_a11y("dark2_8") +
#'     theme_a11y("AA")
#'   p <- a11y_alt_text(p, "Penguin body mass vs flipper length by species.")
#'   pl <- a11y_ggplotly(p)
#'   inherits(pl, "plotly")
#' }
#' }
a11y_ggplotly <- function(gg, level = "AA", palette = NULL, alt = NULL,
                          tooltip = c("x", "y"), strip_title = TRUE, ...) {
  .require_pkg("plotly",  "a11y_ggplotly")
  .require_pkg("ggplot2", "a11y_ggplotly")
  if (!inherits(gg, "ggplot"))
    stop("a11y_ggplotly() requires a ggplot object.", call. = FALSE)

  carried_alt <- alt %||% attr(gg, "a11y_alt")
  if (isTRUE(strip_title))
    gg <- gg + ggplot2::labs(title = NULL, subtitle = NULL)

  pl <- plotly::ggplotly(gg, tooltip = tooltip, ...)
  pl <- a11y_layout(pl, level = level, palette = palette)
  if (!is.null(carried_alt) && nzchar(carried_alt))
    pl <- a11y_alt_text(pl, carried_alt)
  pl
}
