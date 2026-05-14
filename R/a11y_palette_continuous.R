#' Diverging palette
#'
#' Returns the low/mid/high anchor colors for a diverging gradient. Most
#' palettes resolve at runtime from `RColorBrewer`. `*_dual` variants pick
#' mid-saturation Brewer positions whose endpoints clear non-text 3:1 on
#' both white and `#1a1a1a` dark backgrounds. `coolwarm_aaa` is a custom
#' built-in whose endpoints both clear AAA on white only.
#'
#' @param name One of `"rdbu"` (default), `"puor"`, `"brbg"`,
#'   `"rdbu_dual"`, `"puor_dual"`, `"brbg_dual"`, `"coolwarm_aaa"`.
#' @return Named list with elements `low`, `mid`, `high` (hex codes for the
#'   diverging anchors). To materialize an N-step gradient, pass the list to
#'   a color interpolator (e.g., `grDevices::colorRampPalette()`).
#' @export
#' @examples
#' a11y_palette_div("rdbu")
#' a11y_palette_div("rdbu_dual")
a11y_palette_div <- function(name = "rdbu") {
  spec <- .lookup_continuous(name, "diverging")
  src  <- spec$source %||% "literal"
  switch(src,
    literal      = list(low = spec$low, mid = spec$mid, high = spec$high),
    rcolorbrewer = {
      .require_pkg("RColorBrewer", "a11y_palette_div")
      cols <- RColorBrewer::brewer.pal(11, spec$palette)
      pos  <- spec$positions %||% c(10, 6, 2)
      list(low = cols[pos[1]], mid = cols[pos[2]], high = cols[pos[3]])
    },
    stop(sprintf("Unsupported source '%s' for diverging palette", src), call. = FALSE)
  )
}

#' Sequential continuous palette
#'
#' Returns a viridisLite spec (option, begin, end, direction) for a
#' sequential gradient. Use directly with `ggplot2::scale_*_viridis_c()` or
#' via [scale_fill_a11y_seq()]. Pass `n =` to materialize hex codes.
#'
#' @param name One of `"cividis"` (default), `"viridis"`,
#'   `"plasma"`.
#' @param n Optional integer. If supplied, returns `n` hex codes from the
#'   gradient instead of the spec.
#' @return Named list with elements `option`, `begin`, `end`, `direction` --
#'   a viridisLite specification, NOT a color vector. Pass `n =` to
#'   materialize hex codes.
#' @export
#' @examples
#' a11y_palette_seq("cividis")
#' a11y_palette_seq("viridis", n = 7)
a11y_palette_seq <- function(name = "cividis", n = NULL) {
  spec <- .lookup_continuous(name, "sequential")
  src <- spec$source %||% "viridislite"
  out <- switch(src,
    viridislite = list(
      option    = spec$option,
      begin     = spec$begin     %||% 0,
      end       = spec$end       %||% 1,
      direction = spec$direction %||% 1
    ),
    stop(sprintf("Unsupported source '%s' for sequential palette", src), call. = FALSE)
  )
  if (is.null(n)) return(out)
  .require_pkg("viridisLite", "a11y_palette_seq")
  viridisLite::viridis(n, option = out$option, begin = out$begin,
                       end = out$end, direction = out$direction)
}

# helpers ----------------------------------------------------------------------

.lookup_continuous <- function(name, kind) {
  pals <- .wcag_rules()[[kind]]
  if (!name %in% names(pals))
    stop(sprintf("Unknown %s palette '%s'. Available: %s", kind, name,
                 paste(names(pals), collapse = ", ")), call. = FALSE)
  pals[[name]]
}

