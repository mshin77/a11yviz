#' Apply accessible layout to a plotly figure
#'
#' Sets fonts, axis styling, hover-label colors, legend position, and an
#' accessible categorical `colorway`. Targets WCAG 2.1 contrast (1.4.3,
#' 1.4.6, 1.4.11) and resizability (1.4.4). Font sizes are package
#' defaults, not WCAG-mandated minimums. Returns the plotly object so it
#' can stay in a `|>` chain.
#'
#' @param p A plotly object (from `plotly::plot_ly` or `plotly::ggplotly`).
#' @param level `"AA"` or `"AAA"`.
#' @param palette Discrete palette name applied as plotly's `colorway`. See
#'   [a11y_palette_list()]. Pass `NULL` to leave plotly's default colors
#'   unchanged.
#' @return Modified plotly object.
#' @export
a11y_layout <- function(p, level = "AA", palette = "dark2_8") {
  .require_pkg("plotly", "a11y_layout")
  level <- .check_level(level)
  rules <- .wcag_rules()
  fz    <- rules$font_size[[level]]
  tt    <- rules$tooltip

  axis_sz <- fz$axis_text %||% fz$body
  body  <- list(family = tt$font, size = fz$body, color = "#222")
  title <- list(family = tt$font, size = fz$title, color = "#222")
  tick  <- list(family = tt$font, size = axis_sz, color = "#222")
  hover <- list(family = tt$font, size = tt$size, color = tt$text)
  axis  <- list(tickfont = tick, titlefont = title,
                gridcolor = "#e5e5e5", zerolinecolor = "#c0c0c0")

  args <- list(
    autosize      = TRUE,
    font          = body,
    title         = NULL,
    margin        = list(t = 30, b = 60, l = 90, r = 30, autoexpand = TRUE),
    paper_bgcolor = "rgba(0,0,0,0)",
    plot_bgcolor  = "rgba(0,0,0,0)",
    xaxis         = axis,
    yaxis         = axis,
    hoverlabel    = list(bgcolor = tt$bg, bordercolor = tt$border,
                         font = hover, align = "left", namelength = -1),
    legend        = list(orientation = "v", x = 1.02, xanchor = "left",
                         y = 0.5, yanchor = "middle", font = body,
                         title = list(font = title)),
    coloraxis     = list(colorbar = list(tickfont = body,
                                         title = list(font = title)))
  )
  if (!is.null(palette)) args$colorway <- a11y_palette(palette)

  do.call(plotly::layout, c(list(p), args)) |>
    plotly::config(
      displayModeBar       = TRUE,
      displaylogo          = FALSE,
      responsive           = TRUE,
      toImageButtonOptions = list(format = "png", scale = 2)
    )
}
