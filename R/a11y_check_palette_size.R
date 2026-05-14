#' Flag categorical palettes above the recommended maximum
#'
#' Distinguishability drops fast above seven categories even in CVD-safe
#' palettes; consider faceting, aggregation, or a sequential / ordinal
#' encoding instead.
#'
#' @param n Integer; number of categories.
#' @param max Integer; recommended maximum. Default `7`.
#' @return Named list with `n`, `max`, `status` (`"ok"` / `"todo"`), `note`.
#' @export
#' @examples
#' a11y_check_palette_size(5)
#' a11y_check_palette_size(12)
a11y_check_palette_size <- function(n, max = 7) {
  ok   <- n <= max
  note <- if (ok) sprintf("%d categories within recommended max %d", n, max)
          else    sprintf("%d categories exceeds recommended max %d; consider faceting or aggregation",
                          n, max)
  list(n = n, max = max, status = if (ok) "ok" else "todo", note = note)
}
