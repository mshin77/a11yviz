# R walkthrough

The same chart rendered with ggplot defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against accessible.

Edit the code on the left to swap in a different dataset, change
aesthetics, or tweak the theme — the chart and audit update on the
right.

## Live demo

``` shinylive-r
#| '!! shinylive warning !!': |
#|   shinylive does not work in self-contained HTML documents.
#|   Please set `embed-resources: false` in your metadata.
#| label: r-playground
#| standalone: true
#| viewerHeight: 900
#| components: [editor, viewer]

## file: chart.R
# Edit the chart. Re-run (Ctrl+Shift+Enter) to update both panels and the audit.

penguins <- na.omit(palmerpenguins::penguins)

base_plot <- function() {
  ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = species)) +
    geom_point() +
    labs(title = "Penguins (default ggplot)")
}

a11y_plot <- function(level) {
  pal_name <- if (level == "AAA") "aaa_5" else "dark2_8"
  palette  <- a11y_palette(pal_name, n = nlevels(droplevels(penguins$species)))
  pt_size  <- if (level == "AAA") 3.5 else 3
  p <- ggplot(penguins, aes(flipper_length_mm, body_mass_g,
                            fill = species, shape = species)) +
    geom_point(size = pt_size, stroke = 0.7, color = "white") +
    scale_fill_manual(values = palette) +
    scale_shape_manual(values = c(21, 24, 22)) +
    theme_a11y(level = level) +
    labs(title = "Penguins (theme_a11y + a11y_palette)",
         x = "Flipper length (mm)", y = "Body mass (g)",
         fill = "Species", shape = "Species") +
    theme(legend.position = "top")
  a11y_alt_text(p, "Penguin body mass vs flipper length by species, accessible chart.")
}

## file: app.R
suppressPackageStartupMessages({
  library(shiny); library(bslib); library(ggplot2)
  library(palmerpenguins)
})
source("helpers.R")
source("chart.R")
panel_css <- paste(readLines("styles.css", warn = FALSE), collapse = "\n")

panel_body <- function(plot_id, audit_id) {
  tagList(
    plotOutput(plot_id, height = "320px"),
    htmlOutput(audit_id)
  )
}

app_ui <- page_fluid(
  tags$head(tags$style(HTML(panel_css))),
  radioButtons("level", "WCAG level:",
               choices = c("AA", "AAA"), selected = "AA", inline = TRUE),
  navset_underline(
    nav_panel("Baseline",   panel_body("plot_before", "audit_before")),
    nav_panel("Accessible", panel_body("plot_after",  "audit_after"))
  )
)

server <- function(input, output, session) {
  base       <- reactive(base_plot())
  accessible <- reactive(a11y_plot(input$level))

  output$plot_before <- renderPlot(base(),       res = 96)
  output$plot_after  <- renderPlot(accessible(), res = 96)

  audit_table <- function(p) {
    rows      <- a11y_audit_actionable(a11y_audit_chart(p, level = input$level))
    esc       <- function(x) htmltools::htmlEscape(as.character(x))
    head_html <- paste0("<th>", esc(names(rows)), "</th>", collapse = "")
    body_html <- apply(rows, 1, function(r)
      paste0("<tr><td>", paste(esc(r), collapse = "</td><td>"), "</td></tr>"))
    HTML(paste0(
      "<table class=\"audit-table\"><caption>Audit</caption>",
      "<thead><tr>", head_html, "</tr></thead>",
      "<tbody>", paste(body_html, collapse = ""), "</tbody></table>"
    ))
  }

  output$audit_before <- renderUI(audit_table(base()))
  output$audit_after  <- renderUI(audit_table(accessible()))
}

shinyApp(app_ui, server)

## file: helpers.R
# a11yviz core (inlined; webR cannot install the package at runtime).
`%||%` <- function(a, b) if (is.null(a)) b else a

a11y_palette <- function(name = "dark2_8", n = NULL) {
  cols <- switch(name,
    dark2_8 = c("#1B9E77", "#D95F02", "#7570B3", "#E7298A",
                "#66A61E", "#E6AB02", "#A6761D", "#666666"),
    aaa_5   = c("#154E8A", "#7C2C5E", "#5C5108", "#8A3A1F", "#2D5C53"),
    stop(sprintf("Unknown palette '%s'.", name), call. = FALSE)
  )
  if (is.null(n)) cols else cols[seq_len(min(n, length(cols)))]
}

theme_a11y <- function(level = "AA") {
  fz   <- if (level == "AAA") 14 else 12
  fg   <- "#222222"; bg <- "#ffffff"; grid <- "#e5e5e5"
  ggplot2::theme_minimal(base_size = fz) +
    ggplot2::theme(
      text             = ggplot2::element_text(colour = fg),
      plot.title       = ggplot2::element_text(size = fz, face = "bold", colour = fg),
      axis.title       = ggplot2::element_text(size = fz, colour = fg),
      axis.text        = ggplot2::element_text(size = fz, colour = fg),
      legend.title     = ggplot2::element_text(size = fz, colour = fg),
      legend.text      = ggplot2::element_text(size = fz, colour = fg),
      panel.background = ggplot2::element_rect(fill = bg, colour = NA),
      plot.background  = ggplot2::element_rect(fill = bg, colour = NA),
      panel.grid.major = ggplot2::element_line(colour = grid),
      panel.grid.minor = ggplot2::element_line(colour = grid, linewidth = 0.25)
    )
}

a11y_alt_text <- function(p, text) {
  attr(p, "alt")      <- text
  attr(p, "a11y_alt") <- text
  p
}

.base_size <- function(p) {
  if (!inherits(p, "ggplot")) return(NULL)
  t <- p$theme
  if (length(t) == 0)              return(NULL)
  if (isTRUE(attr(t, "complete"))) return(t$text$size)
  (ggplot2::theme_get() + t)$text$size
}

a11y_audit_chart <- function(p, level = "AA") {
  alt_text  <- attr(p, "a11y_alt") %||% attr(p, "alt")
  has_alt   <- !is.null(alt_text) && nzchar(alt_text)
  applied   <- if (inherits(p, "ggplot")) "applied" else "unknown"
  threshold <- if (level == "AAA") 14 else 12
  base_size <- .base_size(p)
  text_ok   <- is.numeric(base_size) && base_size >= threshold
  m             <- p$mapping
  has_color     <- !is.null(m$colour) || !is.null(m$fill)
  has_redundant <- !is.null(m$shape)  || !is.null(m$linetype)
  rows <- data.frame(
    criterion = c("1.1.1", "1.4.1", "1.4.3", "1.4.4", "1.4.11", "1.4.13"),
    check = c("Alt text on figure", "Redundant group encoding",
              "Text contrast (Min)",
              sprintf("Recommended text size (%s default)", level),
              "Non-text contrast", "Content on hover or focus"),
    status = c(
      if (has_alt) "partial" else "todo",
      if (!has_color) "n/a" else if (has_redundant) "ok" else "todo",
      applied,
      if (!is.numeric(base_size)) "manual" else if (text_ok) "ok" else "todo",
      applied,
      "n/a"
    ),
    note = c(
      if (has_alt) "alt stored on figure; emit via the renderer's <img alt> or save with explicit alt -- audit cannot verify the rendered output"
      else         "call a11y_alt_text() or a11y_alt_template()",
      if (!has_color)         "no color/fill aesthetic"
      else if (has_redundant) "shape or linetype redundantly encodes group"
      else                    "add direct group labels (geom_text at cluster centroids), facet by group, or aes(shape=) / aes(linetype=) to redundantly encode the group",
      "theme_a11y() / a11y_layout() set 4.5:1 text on 3:1 non-text",
      if (!is.numeric(base_size)) sprintf("verify text size manually (min %g pt for %s)", threshold, level)
      else if (text_ok)           sprintf("base size %g pt (min %g pt)", base_size, threshold)
      else                        sprintf("base size %g pt; bump to >= %g pt or call theme_a11y(\"%s\")", base_size, threshold, level),
      "axis lines, gridlines, error bars styled",
      "ggplot output has no interactive hover tooltips"
    ),
    stringsAsFactors = FALSE
  )
  if (level == "AAA")
    rows <- rbind(rows,
      data.frame(criterion = "1.4.6", check = "AAA text contrast",
                 status = applied, note = "AAA contrast ratios applied",
                 stringsAsFactors = FALSE))
  rows
}

a11y_audit_actionable <- function(audit)
  audit[audit$status %in% c("todo", "ok"), , drop = FALSE]

## file: styles.css
html, body { background: transparent; font-size: 14px; }
body, .nav-link, .form-check-label, .control-label, table.audit-table, table.audit-table th, table.audit-table td, table.audit-table > caption { font-size: 14px !important; }
.bslib-card, .card { border: 0 !important; box-shadow: none !important; background: transparent !important; }
.card-body, .bslib-card > .card-body { padding: 0 !important; background: transparent !important; }
.bslib-card, .card, .card-body, .tab-content, .tab-pane, .navset-card-body { overflow: visible !important; max-height: none !important; height: auto !important; }
table.audit-table { width: 100% !important; border-collapse: collapse; }
table.audit-table > caption { caption-side: top; text-align: left; font-weight: 600; color: #1a1a1a; padding: 0.5rem 0 0.25rem; }
table.audit-table thead th { background: #f5f5f5 !important; color: #1a1a1a !important; }
table.audit-table th, table.audit-table td { padding: 6px 8px; border-bottom: 1px solid #e5e5e5; text-align: left; vertical-align: top; }
table.audit-table tbody tr:nth-child(odd) { background: #fafafa; }
table.audit-table tbody tr:hover { background: #f0f0f0; }
@media (max-width: 576px) {
  table.audit-table { table-layout: fixed !important; }
  table.audit-table td, table.audit-table th { padding: 4px 6px; word-wrap: break-word; }
  table.audit-table th:nth-child(1), table.audit-table td:nth-child(1) { width: 22%; }
  table.audit-table th:nth-child(2), table.audit-table td:nth-child(2) { width: 50%; }
  table.audit-table th:nth-child(3), table.audit-table td:nth-child(3) { width: 28%; }
  table.audit-table th:nth-child(4), table.audit-table td:nth-child(4) { display: none; }
}
```
