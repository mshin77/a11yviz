#' Launch the local accessibility playground
#'
#' Opens a Shiny app comparing default `ggplot2` output against the
#' accessible theme, palette, and alt-text helpers, with a per-criterion
#' WCAG audit. Requires `shiny`, `bslib`, `ggplot2`, and `DT`; missing
#' packages are flagged at launch.
#'
#' @param host Network host (default `"127.0.0.1"`).
#' @param port Port (default `8000`).
#' @param launch_browser Open the default browser (default `TRUE`).
#' @param ... Passed to [shiny::runApp()].
#' @return Invisibly, the return value of [shiny::runApp()].
#' @export
#' @examples
#' if (interactive()) run_app()
run_app <- function(host = "127.0.0.1", port = 8000,
                    launch_browser = TRUE, ...) {
  rlang::check_installed(c("shiny", "bslib", "ggplot2", "palmerpenguins", "DT"))
  app_dir <- system.file("playground", package = "a11yviz")
  if (!nzchar(app_dir)) {
    stop("playground assets not found; reinstall a11yviz", call. = FALSE)
  }
  shiny::runApp(app_dir, host = host, port = port,
                launch.browser = launch_browser, ...)
}
