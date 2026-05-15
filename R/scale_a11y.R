#' Accessible discrete color and fill scales
#'
#' Categorical palettes that meet WCAG 1.4.1 (Use of Color) by being
#' distinguishable to viewers with color vision differences.
#'
#' @param palette One of `"dark2_8"` (default), `"set2_8"`, `"paired_12"`, `"aaa_5"`. See [a11y_palette_list()].
#' @param level WCAG contrast level. `"AAA"` switches the default palette to
#'   `"aaa_5"` (deep, AAA-on-white set). Ignored if `palette` is set explicitly.
#' @param ... Passed to `ggplot2::discrete_scale`.
#' @name scale_a11y
#' @return A ggplot2 scale.
#' @examples
#' if (requireNamespace("ggplot2",        quietly = TRUE) &&
#'     requireNamespace("palmerpenguins", quietly = TRUE)) {
#'   library(ggplot2)
#'   pg <- na.omit(palmerpenguins::penguins)
#'   ggplot(pg, aes(flipper_length_mm, body_mass_g, color = species)) +
#'     geom_point() + scale_color_a11y()
#'   ggplot(pg, aes(species, fill = island)) +
#'     geom_bar() + scale_fill_a11y("set2_8")
#' }
NULL

.scale_a11y_palette <- function(palette, level) {
  if (!missing(palette) && !is.null(palette)) return(palette)
  if (!is.null(level) && toupper(level) == "AAA") "aaa_5" else "dark2_8"
}

#' @rdname scale_a11y
#' @export
scale_color_a11y <- function(palette = NULL, level = "AA", ...) {
  .require_pkg("ggplot2", "scale_color_a11y")
  cols <- a11y_palette(.scale_a11y_palette(palette, level))
  ggplot2::discrete_scale(aesthetics = "colour",
                          palette = function(n) cols[seq_len(n)], ...)
}

#' @rdname scale_a11y
#' @export
scale_fill_a11y <- function(palette = NULL, level = "AA", ...) {
  .require_pkg("ggplot2", "scale_fill_a11y")
  cols <- a11y_palette(.scale_a11y_palette(palette, level))
  ggplot2::discrete_scale(aesthetics = "fill",
                          palette = function(n) cols[seq_len(n)], ...)
}
