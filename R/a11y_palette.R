#' Discrete color palette (categorical)
#'
#' Returns hex codes for a color-vision-aware categorical palette. Most
#' palettes are runtime wrappers around `RColorBrewer::brewer.pal()` so the
#' authoritative colors stay in their source package.
#'
#' @param name Discrete palette name. Built-in: `"dark2_8"` (default,
#'   RColorBrewer Dark2), `"set2_8"` (RColorBrewer Set2), `"paired_12"`
#'   (RColorBrewer Paired), `"aaa_5"` (custom AAA-on-white set).
#' @param n Optional number of colors. Defaults to the palette's full size
#'   (truncates from the start when smaller).
#' @param bg Plot background context. One of `NULL` (default -- no check),
#'   `"white"`, or `"dark"`. When set, the function warns if the palette's
#'   `safe_on` tag does not match.
#' @return Character vector of hex codes (e.g., "#1B9E77"). For sequential
#'   gradients, see [a11y_palette_seq()].
#' @export
#' @examples
#' a11y_palette("dark2_8")
#' a11y_palette("aaa_5")
#' a11y_palette("dark2_8", n = 4)
a11y_palette <- function(name = "dark2_8", n = NULL, bg = NULL) {
  spec <- .palette_spec(name)
  cols <- .resolve_discrete(spec, n)
  if (!is.null(bg)) .warn_if_unsafe(name, spec, bg)
  cols
}

#' Discrete palette metadata
#'
#' Returns the source spec, resolved colors, and WCAG metadata for a
#' discrete palette. For continuous palettes, see [a11y_palette_div()] and
#' [a11y_palette_seq()].
#'
#' @inheritParams a11y_palette
#' @return Named list with `name`, `colors`, `safe_on`, `purpose`, `notes`,
#'   plus the source spec fields.
#' @export
#' @examples
#' a11y_palette_info("aaa_5")
a11y_palette_info <- function(name = "dark2_8") {
  spec <- .palette_spec(name)
  c(list(name = name, colors = .resolve_discrete(spec, NULL)), spec)
}

#' List available palettes
#'
#' Lists discrete, diverging, and sequential palettes in one data frame.
#'
#' @param type Optional filter: `"discrete"`, `"diverging"`, or
#'   `"sequential"`. `NULL` (default) returns all.
#' @return Data frame with columns `name`, `type`, `source`, `n`,
#'   `safe_on`, `purpose`. `n` is `NA` for continuous palettes. For the
#'   `notes` field of a single palette, call [a11y_palette_info()].
#' @export
#' @examples
#' a11y_palette_list()
#' a11y_palette_list(type = "diverging")
a11y_palette_list <- function(type = NULL) {
  rules <- .wcag_rules()
  rows <- c(
    lapply(names(rules$palettes),  function(nm) .palette_row(nm, "discrete",   rules$palettes[[nm]])),
    lapply(names(rules$diverging), function(nm) .palette_row(nm, "diverging",  rules$diverging[[nm]])),
    lapply(names(rules$sequential),function(nm) .palette_row(nm, "sequential", rules$sequential[[nm]]))
  )
  out <- do.call(rbind, rows)
  if (is.null(type)) return(out)
  type <- match.arg(type, c("discrete", "diverging", "sequential"))
  out[out$type == type, , drop = FALSE]
}

# helpers ----------------------------------------------------------------------

.palette_spec <- function(name) {
  pals <- .wcag_rules()$palettes
  if (!name %in% names(pals))
    stop(sprintf("Unknown palette '%s'. Available: %s", name,
                 paste(names(pals), collapse = ", ")), call. = FALSE)
  pals[[name]]
}

.resolve_discrete <- function(spec, n = NULL) {
  src <- spec$source %||% "literal"
  cols <- switch(src,
    literal      = spec$colors,
    rcolorbrewer = {
      .require_pkg("RColorBrewer", "a11y_palette")
      RColorBrewer::brewer.pal(spec$n_colors, spec$palette)
    },
    stop(sprintf("Unsupported source '%s' for discrete palette", src), call. = FALSE)
  )
  if (is.null(n)) cols else cols[seq_len(min(n, length(cols)))]
}

.warn_if_unsafe <- function(name, spec, bg) {
  bg <- match.arg(bg, c("white", "dark"))
  safe <- spec$safe_on %||% "white"
  if (safe == "both" || safe == bg) return(invisible())
  msg <- if (safe == "labeled") {
    sprintf("Palette '%s' is mixed-contrast -- only safe when each fill carries a high-contrast text label. %s",
            name, spec$notes %||% "")
  } else {
    sprintf("Palette '%s' is tagged safe_on='%s' but bg='%s' was requested. %s",
            name, safe, bg, spec$notes %||% "")
  }
  warning(msg, call. = FALSE)
}

.palette_row <- function(nm, type, p) {
  data.frame(
    name    = nm,
    type    = type,
    source  = p$source %||% "literal",
    n       = if (type == "discrete")
                length(.resolve_discrete(p, NULL))
              else NA_integer_,
    safe_on = p$safe_on %||% NA_character_,
    purpose = p$purpose %||% NA_character_,
    stringsAsFactors = FALSE
  )
}
