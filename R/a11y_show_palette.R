#' Visualize a palette with WCAG contrast overlay
#'
#' Renders the swatches of a built-in palette and overlays each color's
#' contrast ratio against `bg`, plus a pass/fail label for `level`.
#'
#' @param name Discrete palette name. See [a11y_palette_list()].
#' @param bg Reference background hex (default `"#ffffff"`).
#' @param level `"AA"` or `"AAA"`.
#' @return A ggplot object.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   a11y_show_palette("dark2_8")
#' }
a11y_show_palette <- function(name = "dark2_8", bg = "#ffffff", level = "AA") {
  .require_pkg("ggplot2", "a11y_show_palette")
  level     <- .check_level(level)
  cols      <- a11y_palette(name)
  ratios    <- vapply(cols, function(c) .contrast_ratio(c, bg), numeric(1))
  threshold <- if (level == "AA") 4.5 else 7
  status    <- ifelse(ratios >= threshold, level, "todo")

  text_col <- ifelse(.relative_luminance(cols) > 0.179, "#000000", "#ffffff")

  df <- data.frame(
    idx      = seq_along(cols),
    hex      = cols,
    label    = sprintf("%s\n%.1f:1\n%s", cols, ratios, status),
    text_col = text_col,
    stringsAsFactors = FALSE
  )

  ggplot2::ggplot(df, ggplot2::aes(idx, 1, fill = hex)) +
    ggplot2::geom_tile(color = "white", linewidth = 1) +
    ggplot2::geom_text(ggplot2::aes(label = label, color = text_col),
                       size = 3, lineheight = 0.9) +
    ggplot2::scale_fill_identity() +
    ggplot2::scale_color_identity() +
    ggplot2::scale_x_continuous(breaks = NULL) +
    ggplot2::scale_y_continuous(breaks = NULL) +
    ggplot2::theme_void(base_size = 11) +
    ggplot2::labs(title = sprintf("%s palette  (vs %s, %s)", name, bg, level))
}
