#' Launch the local accessibility playground
#'
#' Opens a Shiny app comparing default `ggplot2` output against the
#' accessible theme, palette, and alt-text helpers, with a per-criterion
#' WCAG audit. Requires `shiny`, `bslib`, `ggplot2`, and `DT`; missing
#' packages are flagged at launch.
#'
#' @param ... Passed to [shiny::runApp()].
#' @return Invisibly, the return value of [shiny::runApp()].
#' @export
#' @examples
#' if (interactive()) run_app()
run_app <- function(...) {
  rlang::check_installed(c("shiny", "bslib", "ggplot2", "palmerpenguins", "DT"))
  app_dir <- system.file("playground", package = "a11yviz")
  if (!nzchar(app_dir)) {
    stop("playground assets not found; reinstall a11yviz", call. = FALSE)
  }
  shiny::runApp(app_dir, ...)
}
