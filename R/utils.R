`%||%` <- function(a, b) if (is.null(a)) b else a

.wcag_rules <- function() {
  fp <- system.file("extdata", "wcag_rules.yaml", package = "a11yviz")
  if (!nzchar(fp)) stop("wcag_rules.yaml missing from package install", call. = FALSE)
  yaml::read_yaml(fp)
}

.check_level <- function(level) {
  level <- match.arg(toupper(level), c("AA", "AAA"))
  level
}

.require_pkg <- function(pkg, fn) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("`%s()` requires the '%s' package. Install with install.packages(\"%s\").",
                 fn, pkg, pkg), call. = FALSE)
  }
}

.relative_luminance <- function(hex) {
  rgb <- grDevices::col2rgb(hex) / 255
  lin <- ifelse(rgb <= 0.03928, rgb / 12.92, ((rgb + 0.055) / 1.055)^2.4)
  0.2126 * lin[1, ] + 0.7152 * lin[2, ] + 0.0722 * lin[3, ]
}

#' @noRd
.contrast_ratio <- function(fg, bg) {
  l1 <- .relative_luminance(fg)
  l2 <- .relative_luminance(bg)
  hi <- pmax(l1, l2); lo <- pmin(l1, l2)
  unname((hi + 0.05) / (lo + 0.05))
}
