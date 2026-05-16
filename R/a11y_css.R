#' Path to the accessible CSS
#'
#' Returns the filesystem path to `a11yviz.css`, an accessible stylesheet that
#' makes plotly, DT, DiagrammeR, and static plot images theme-aware and
#' applies WCAG-aligned defaults for contrast, focus, and text spacing. Use
#' it in Quarto via `css:`, in Shiny via `tags$link()`,
#' or copy it into a project's `www/`.
#'
#' @param mode `"default"` returns the base CSS path; `"shiny"` also
#'   appends `a11yviz-shiny.css` (skip-link, screen-reader-only text, reduced-motion,
#'   high-contrast rules) in load order.
#' @return Character path (default) or character vector of paths (shiny).
#' @export
#' @examples
#' basename(a11y_css())
#' length(a11y_css("shiny"))
a11y_css <- function(mode = c("default", "shiny")) {
  mode <- match.arg(mode)
  base <- system.file("css", "a11yviz.css", package = "a11yviz")
  if (!nzchar(base)) stop("a11yviz.css missing from package install", call. = FALSE)
  if (mode == "default") return(base)
  shiny <- system.file("css", "a11yviz-shiny.css", package = "a11yviz")
  if (!nzchar(shiny)) stop("a11yviz-shiny.css missing from package install", call. = FALSE)
  c(base, shiny)
}

#' Contents of the accessible CSS
#'
#' Reads the bundled CSS file(s) returned by [a11y_css()] and concatenates
#' them as a single string. Useful for embedding inline in Quarto via
#' `<style>` tags or in Shiny via `tags$style()`.
#'
#' @inheritParams a11y_css
#' @return Character scalar of CSS source.
#' @export
#' @examples
#' nchar(a11y_css_contents())
a11y_css_contents <- function(mode = c("default", "shiny")) {
  paste(unlist(lapply(a11y_css(match.arg(mode)), readLines, warn = FALSE)),
        collapse = "\n")
}
