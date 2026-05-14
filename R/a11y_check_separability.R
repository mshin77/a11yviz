#' Flag color pairs below the WCAG 2.1 Success Criterion 1.4.11 contrast threshold
#'
#' For every pair of colors in the palette, computes the WCAG
#' relative-luminance contrast ratio -- the same formula used by
#' [a11y_check_palette()]. Pairs below `min_ratio` (default `3.0`, the
#' WCAG 2.1 Success Criterion 1.4.11 "Non-text Contrast / Graphical Objects"
#' threshold) are flagged. Two data marks of similar colors may
#' fail this -- viewers cannot tell them apart.
#'
#' @param colors Character vector of hex codes.
#' @param min_ratio Numeric threshold; default `3.0` per WCAG Success Criterion 1.4.11.
#' @return Data frame with columns `from`, `to`, `ratio`, `status`.
#' @export
#' @examples
#' a11y_check_separability(c("#1B9E77", "#D95F02", "#7570B3"))
a11y_check_separability <- function(colors, min_ratio = 3.0) {
  if (length(colors) < 2L) {
    return(data.frame(from = character(0), to = character(0),
                      ratio = numeric(0), status = character(0),
                      stringsAsFactors = FALSE))
  }
  combs  <- utils::combn(length(colors), 2)
  c1     <- colors[combs[1, ]]
  c2     <- colors[combs[2, ]]
  ratios <- .contrast_ratio(c1, c2)
  data.frame(
    from   = c1,
    to     = c2,
    ratio  = round(ratios, 2),
    status = ifelse(ratios >= min_ratio, "ok", "todo"),
    stringsAsFactors = FALSE
  )
}
