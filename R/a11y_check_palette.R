#' Check a palette against WCAG contrast thresholds
#'
#' Computes the contrast ratio of every color against a reference background
#' and reports whether each meets the WCAG threshold (4.5:1 for AA, 7:1 for
#' AAA). When `alpha < 1`, contrast is computed against the alpha-composited
#' rendered color -- the color the viewer actually sees.
#' Works on any palette -- `viridis`, `RColorBrewer`, plotly's discrete
#' sequences, or a custom hex vector.
#'
#' @param colors Character vector of hex codes.
#' @param bg Reference background hex(es). Pass a single value (e.g.
#'   `"#ffffff"`) or a vector (e.g. `c("#ffffff", "#1a1a1a")`) to verify
#'   against multiple backgrounds. Returns one row per (color, bg) pair.
#' @param level `"AA"` (4.5:1) or `"AAA"` (7:1). Use `"AA-large"` (3:1) for
#'   non-text elements such as data marks, axis lines, and focus rings.
#' @param alpha Opacity in `[0, 1]`. `1` (default) checks the raw color.
#'   Values below 1 composite each color over `bg` first, then check the
#'   rendered result -- useful when chart geoms use `alpha < 1`.
#' @return Data frame with columns `color`, `bg`, `alpha`, `rendered`,
#'   `ratio`, `status`.
#' @export
#' @examples
#' a11y_check_palette(c("#000000", "#cccccc", "#ff0000"))
#' a11y_check_palette(c("#0072B2"), bg = c("#ffffff", "#1a1a1a"), level = "AA-large")
#' a11y_check_palette(c("#0072B2", "#D55E00"), alpha = 0.7, level = "AA-large")
a11y_check_palette <- function(colors, bg = "#ffffff", level = "AA", alpha = 1) {
  threshold <- switch(level,
    "AA"       = 4.5,
    "AAA"      = 7.0,
    "AA-large" = 3.0
  )
  grid     <- expand.grid(color = colors, bg = bg, stringsAsFactors = FALSE)
  rendered <- if (alpha == 1) grid$color else {
    rgb_mat <- alpha * grDevices::col2rgb(grid$color) +
               (1 - alpha) * grDevices::col2rgb(grid$bg)
    grDevices::rgb(rgb_mat[1, ], rgb_mat[2, ], rgb_mat[3, ], maxColorValue = 255)
  }
  ratios <- .contrast_ratio(rendered, grid$bg)
  data.frame(
    color    = grid$color,
    bg       = grid$bg,
    alpha    = alpha,
    rendered = rendered,
    ratio    = round(ratios, 2),
    status   = ifelse(ratios >= threshold, "ok", "todo"),
    stringsAsFactors = FALSE,
    row.names = NULL
  )
}
