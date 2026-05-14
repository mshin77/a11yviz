#' Scatter overlap check (WCAG Success Criterion 1.3.1)
#'
#' Bins point coordinates from `geom_point` layers to a `bins` x `bins`
#' grid in data space and reports the fraction of points that share a
#' cell with another point. Treat as a render-resolution proxy for
#' Success Criterion 1.3.1 (information must remain perceivable). When
#' overlap is non-zero, alpha may be considered, but composited contrast
#' must clear 3:1 per Success Criterion 1.4.11.
#'
#' @param p A `ggplot` object with at least one `geom_point` layer.
#' @param bins Grid resolution per axis (default 100).
#' @return List with `total`, `obscured`, `fraction`, `recommendation`.
#' @export
a11y_check_overlap <- function(p, bins = 100) {
  .require_pkg("ggplot2", "a11y_check_overlap")
  layers <- ggplot2::ggplot_build(p)$data
  is_point <- vapply(seq_along(p$layers),
                     function(i) inherits(p$layers[[i]]$geom, "GeomPoint"),
                     logical(1))
  point_data <- layers[is_point]
  if (length(point_data) == 0L) {
    return(list(total = 0L, obscured = 0L, fraction = 0,
                recommendation = "no scatter points to evaluate"))
  }
  coords <- do.call(rbind, lapply(point_data, function(d) d[, c("x", "y")]))
  xb <- seq(min(coords$x), max(coords$x) + 1e-9, length.out = bins + 1L)
  yb <- seq(min(coords$y), max(coords$y) + 1e-9, length.out = bins + 1L)
  keys <- findInterval(coords$x, xb) * (bins + 1L) +
          findInterval(coords$y, yb)
  counts <- tabulate(keys + 1L)
  obscured <- as.integer(sum(counts[counts > 1L]))
  total <- length(keys)
  fraction <- round(obscured / total, 3)
  rec <- if (obscured == 0L) {
    "no alpha needed (no occlusion; Success Criterion 1.3.1 satisfied)"
  } else {
    sprintf(paste0("%d%% of points share a grid cell; if alpha is added, ",
                   "verify composited contrast >= 3:1 via ",
                   "a11y_check_palette(alpha = ...) (Success Criterion 1.4.11)"),
            round(fraction * 100))
  }
  list(total = total, obscured = obscured,
       fraction = fraction, recommendation = rec)
}
