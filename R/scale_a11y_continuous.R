#' Accessible diverging color and fill scales
#'
#' ggplot2 scales for diverging gradients with anchor colors sourced from
#' [a11y_palette_div()].
#'
#' @param palette One of `"rdbu"` (default), `"puor"`, `"brbg"`,
#'   `"coolwarm_aaa"`.
#' @param ... Passed to `ggplot2::scale_*_gradient2()`.
#' @name scale_a11y_div
#' @return A ggplot2 scale.
NULL

#' @rdname scale_a11y_div
#' @export
scale_color_a11y_div <- function(palette = "rdbu", ...) {
  .require_pkg("ggplot2", "scale_color_a11y_div")
  d <- a11y_palette_div(palette)
  ggplot2::scale_color_gradient2(low = d$low, mid = d$mid, high = d$high, ...)
}

#' @rdname scale_a11y_div
#' @export
scale_fill_a11y_div <- function(palette = "rdbu", ...) {
  .require_pkg("ggplot2", "scale_fill_a11y_div")
  d <- a11y_palette_div(palette)
  ggplot2::scale_fill_gradient2(low = d$low, mid = d$mid, high = d$high, ...)
}

#' Accessible sequential continuous color and fill scales
#'
#' ggplot2 scales for sequential viridisLite gradients sourced from
#' [a11y_palette_seq()]. The default `"cividis"` remains readable in
#' greyscale and spans the full lightness range.
#'
#' @param palette One of `"cividis"` (default), `"viridis"`, `"plasma"`.
#' @param ... Passed to `ggplot2::scale_*_viridis_c()`.
#' @name scale_a11y_seq
#' @return A ggplot2 scale.
NULL

#' @rdname scale_a11y_seq
#' @export
scale_color_a11y_seq <- function(palette = "cividis", ...) {
  .require_pkg("ggplot2", "scale_color_a11y_seq")
  s <- a11y_palette_seq(palette)
  ggplot2::scale_color_viridis_c(option = s$option, begin = s$begin,
                                 end = s$end, direction = s$direction, ...)
}

#' @rdname scale_a11y_seq
#' @export
scale_fill_a11y_seq <- function(palette = "cividis", ...) {
  .require_pkg("ggplot2", "scale_fill_a11y_seq")
  s <- a11y_palette_seq(palette)
  ggplot2::scale_fill_viridis_c(option = s$option, begin = s$begin,
                                end = s$end, direction = s$direction, ...)
}
