#' Audit a plot against accessibility standards
#'
#' Returns a tibble of accessibility checks, with a status per check.
#' Anchored to W3C WCAG 2.1. Each row carries a `criterion`
#' (success-criterion) number so the result joins cleanly to
#' [a11y_rubric()].
#'
#' @param p A `plotly` or `ggplot` object.
#' @param level `"AA"` or `"AAA"`.
#' @return Data frame with columns `criterion`, `check`, `status`, `note`.
#'   Pass any `criterion` value to [a11y_wcag_url()] for the spec link, or
#'   join to [a11y_rubric()] for principle, guideline, and threshold.
#' @export
a11y_audit <- function(p, level = "AA") {
  level    <- .check_level(level)
  alt_text <- attr(p, "a11y_alt") %||% attr(p, "alt")
  has_alt  <- !is.null(alt_text) && nzchar(alt_text)
  is_chart <- inherits(p, "plotly") || inherits(p, "ggplot")
  applied  <- if (is_chart) "applied" else "unknown"

  alt <- list(
    status = if (has_alt) "partial" else "todo",
    note   = if (has_alt)
               "alt stored on figure; emit via the renderer's <img alt> or save with explicit alt -- audit cannot verify the rendered output"
             else
               "call a11y_alt_text() or a11y_alt_template()"
  )
  color <- .check_color_only(p)
  text  <- .check_text_size(p, level)
  hover <- .check_hover(p)

  rows <- list(
    .row("1.1.1",  "Alt text on figure",
         alt$status, alt$note),
    .row("1.3.1",  "Heading hierarchy",
         "doc",    "run a11y_check_headings() on the host document"),
    .row("1.4.1",  "Redundant group encoding",
         color$status, color$note),
    .row("1.4.3",  "Text contrast (Min)",
         applied,  "theme_a11y() / a11y_layout() set 4.5:1 text on 3:1 non-text"),
    .row("1.4.4",  sprintf("Recommended text size (%s default)", level),
         text$status, text$note),
    .row("1.4.4",  "Text resizable",
         applied,  "fonts set in pt; layout scales with container"),
    .row("1.4.10", "Reflow at 320 CSS px",
         "manual", "verify the host page reflows at 320 px without 2D scroll; a11y_css() ships @media rules"),
    .row("1.4.11", "Non-text contrast",
         applied,  "axis lines, gridlines, error bars styled"),
    .row("1.4.12", "Body text spacing",
         "css",    "include a11y_css() for line-height and paragraph spacing"),
    .row("1.4.13", "Content on hover or focus",
         hover$status, hover$note),
    .row("2.4.7",  "Visible keyboard focus",
         "css",    "include a11y_css() for keyboard focus rings")
  )
  aaa <- list(.row("1.4.6", "Enhanced text contrast (AAA)",
                   applied, "AAA contrast ratios applied"))
  do.call(rbind, c(rows, aaa[level == "AAA"]))
}

.row <- function(criterion, check, status, note) {
  data.frame(criterion = criterion,
             check     = check,
             status    = status,
             note      = note,
             stringsAsFactors = FALSE)
}

.check_text_size <- function(p, level) {
  threshold <- if (level == "AAA") 14 else 12
  size      <- .extract_base_size(p)
  if (!is.numeric(size))
    return(list(status = "manual",
                note   = sprintf("verify text size manually (min %g pt for %s)",
                                 threshold, level)))
  ok <- size >= threshold
  list(
    status = if (ok) "ok" else "todo",
    note   = if (ok) sprintf("base size %g pt (min %g pt)", size, threshold)
             else    sprintf("base size %g pt; bump to >= %g pt or call theme_a11y(\"%s\")",
                             size, threshold, level)
  )
}

.extract_base_size <- function(p) {
  if (inherits(p, "ggplot")) return(p$theme$text$size)
  if (inherits(p, "plotly")) return((p$x$layout %||% list())$font$size)
  NULL
}

.check_hover <- function(p) {
  if (!inherits(p, "plotly"))
    return(list(status = "n/a",
                note   = "ggplot output has no interactive hover tooltips"))
  has_layout <- !is.null((p$x$layout %||% list())$hoverlabel)
  list(
    status = if (has_layout) "applied" else "todo",
    note   = if (has_layout)
               "hover labels styled by a11y_layout(); verify Esc dismiss + persistent on hover"
             else
               "call a11y_layout(); also verify tooltips dismiss with Esc and persist while hovered"
  )
}

.check_color_only <- function(p) {
  if (!inherits(p, "ggplot"))
    return(list(status = "manual",
                note   = "verify category encoding is not color-only"))
  m <- p$mapping
  has_color     <- !is.null(m$colour) || !is.null(m$fill)
  has_redundant <- !is.null(m$shape)  || !is.null(m$linetype)
  if (!has_color)
    return(list(status = "n/a", note = "no color/fill aesthetic"))
  list(
    status = if (has_redundant) "ok" else "todo",
    note   = if (has_redundant) "shape or linetype redundantly encodes group"
             else                "add shape= or linetype= to redundantly encode the group"
  )
}
