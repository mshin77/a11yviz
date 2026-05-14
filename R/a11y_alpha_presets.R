#' Alpha presets for chart layers
#'
#' Returns a named numeric vector of alpha values for common chart roles.
#' Use them when setting `alpha =` in `ggplot2::geom_*()` or plotly traces.
#' Alpha lowers the effective contrast a viewer sees, so verify the
#' composited contrast with [a11y_check_palette()] when the choice matters.
#'
#' @return Named numeric vector with elements `raw_points`, `overlay_point`,
#'   `labels`, `fill`, `ci_ribbon`, `ci_band`.
#' @export
#' @examples
#' a11y_alpha_presets()
#' a11y_alpha_presets()[["overlay_point"]]
a11y_alpha_presets <- function() {
  presets <- .wcag_rules()$overlay_presets
  presets$draw_order <- NULL
  unlist(presets)
}
