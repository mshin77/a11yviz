# R walkthrough

The same chart rendered with ggplot defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against improved.

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
#| viewerHeight: 720
#| components: [editor, viewer]

## file: app.R
suppressPackageStartupMessages({
  library(shiny); library(bslib); library(ggplot2)
  library(palmerpenguins); library(DT)
})
app_dir   <- if (is.null(sys.frame(1)$ofile)) "." else dirname(sys.frame(1)$ofile)
source(file.path(app_dir, "helpers.R"))
panel_css <- paste(readLines(file.path(app_dir, "styles.css"), warn = FALSE),
                   collapse = "\n")

penguins <- na.omit(penguins)

base_plot <- function() {
  ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = species)) +
    geom_point() +
    labs(title = "Penguins (default ggplot)")
}

improved_plot <- function(level) {
  pal_name <- if (level == "AAA") "aaa_5" else "dark2_8"
  palette  <- a11y_palette(pal_name, n = nlevels(droplevels(penguins$species)))
  p <- ggplot(penguins, aes(flipper_length_mm, body_mass_g, color = species)) +
    geom_point(size = 2, alpha = 0.75) +
    scale_color_manual(values = palette) +
    theme_a11y(level = level) +
    labs(title = "Penguins (theme_a11y + a11y_palette)",
         x = "Flipper length (mm)", y = "Body mass (g)", color = "Species") +
    theme(legend.position = "top")
  a11y_alt_text(p, "Penguin body mass vs flipper length by species, AA accessible.")
}

panel_body <- function(plot_id, audit_id) {
  tagList(
    div(class = "plot-wrap",
        plotOutput(plot_id, height = "100%", width = "100%")),
    div(class = "table-responsive", DT::DTOutput(audit_id))
  )
}

ui <- page_fillable(
  tags$head(tags$style(HTML(panel_css))),
  radioButtons("level", "WCAG level:",
               choices = c("AA", "AAA"), selected = "AA", inline = TRUE),
  navset_underline(
    nav_panel("Baseline", panel_body("plot_before", "audit_before")),
    nav_panel("Improved", panel_body("plot_after",  "audit_after"))
  )
)

server <- function(input, output, session) {
  base     <- reactive(base_plot())
  improved <- reactive(improved_plot(input$level))

  output$plot_before <- renderPlot(base(),     res = 96)
  output$plot_after  <- renderPlot(improved(), res = 96)

  audit_opts <- list(dom = "t", ordering = FALSE,
                     columnDefs = list(list(className = "dt-left", targets = "_all")))

  audit_table <- function(p) {
    DT::datatable(
      a11y_audit_actionable(a11y_audit_chart(p, level = input$level)),
      caption = "Audit", options = audit_opts, rownames = FALSE,
      class = "compact stripe hover", selection = "none"
    )
  }

  output$audit_before <- DT::renderDT(audit_table(base()))
  output$audit_after  <- DT::renderDT(audit_table(improved()))
}

shinyApp(ui, server)

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

a11y_audit_chart <- function(p, level = "AA") {
  alt_text  <- attr(p, "a11y_alt") %||% attr(p, "alt")
  has_alt   <- !is.null(alt_text) && nzchar(alt_text)
  applied   <- if (inherits(p, "ggplot")) "applied" else "unknown"
  threshold <- if (level == "AAA") 14 else 12
  base_size <- p$theme$text$size
  text_ok   <- is.numeric(base_size) && base_size >= threshold
  m         <- p$mapping
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
      if (has_alt) "alt stored on figure; emit via the renderer's <img alt>"
      else         "call a11y_alt_text() or a11y_alt_template()",
      if (!has_color)        "no color/fill aesthetic"
      else if (has_redundant) "shape or linetype redundantly encodes group"
      else                    "add shape= or linetype= to redundantly encode the group",
      "theme_a11y() / a11y_layout() set 4.5:1 text on 3:1 non-text",
      if (!is.numeric(base_size)) sprintf("verify text size manually (min %g pt for %s)", threshold, level)
      else if (text_ok)           sprintf("base size %g pt (min %g pt)", base_size, threshold)
      else                        sprintf("base size %g pt; bump to >= %g pt", base_size, threshold),
      "axis lines, gridlines, error bars styled",
      "ggplot output has no interactive hover tooltips"
    ),
    stringsAsFactors = FALSE
  )
  if (level == "AAA")
    rows <- rbind(rows,
      data.frame(criterion = "1.4.6", check = "Enhanced text contrast (AAA)",
                 status = applied, note = "AAA contrast ratios applied",
                 stringsAsFactors = FALSE))
  rows
}

a11y_audit_actionable <- function(audit)
  audit[audit$status %in% c("todo", "ok"), , drop = FALSE]

## file: styles.css
html, body { height: 100%; background: transparent; font-size: 14px; }
body, .nav-link, .form-check-label, .control-label, table.dataTable, table.dataTable th, table.dataTable td, table.dataTable > caption, .dataTables_info, .dt-info, .dataTables_paginate, .dt-paging { font-size: 14px !important; }
.bslib-card, .card { height: 100%; border: 0 !important; box-shadow: none !important; background: transparent !important; }
.card-body, .bslib-card > .card-body { padding: 0 !important; background: transparent !important; }
.tab-content { display: flex; flex-direction: column; flex: 1 1 auto !important; min-height: 0; }
.tab-pane.active { display: flex; flex-direction: column; flex: 1 1 auto; min-height: 0; overflow: hidden; }
.plot-wrap { flex: 0 0 320px; height: 320px; overflow: hidden; }
.table-responsive { flex: 0 0 200px; height: 200px; min-height: 200px; overflow-y: auto; overflow-x: hidden; }
.dataTables_wrapper, .dt-container { overflow: visible !important; }
table.dataTable { width: 100% !important; }
table.dataTable > caption { caption-side: top; text-align: left; font-weight: 600; color: #1a1a1a; padding: 0.5rem 0 0.25rem; position: sticky; top: 0; background: #fff; z-index: 2; }
table.dataTable.hover > tbody > tr:hover > *, table.dataTable.hover tbody tr:hover > *, table.dataTable.hover tbody tr:hover, table.dataTable.display > tbody > tr:hover > *, table.dataTable.display tbody tr:hover > *, table.dataTable.display tbody tr:hover { box-shadow: inset 0 0 0 9999px rgba(0,0,0,.035) !important; background-color: transparent !important; }
.nav-underline .nav-link:hover, .nav-underline .nav-link:focus { border-bottom-color: transparent !important; color: inherit !important; }
.form-check:hover, .form-check-input:hover { background-color: transparent !important; }
@media (max-width: 576px) {
  .plot-wrap { flex: 0 0 220px; height: 220px; }
  .table-responsive { flex: 0 0 180px; height: 180px; min-height: 180px; }
  table.dataTable { table-layout: fixed !important; }
  table.dataTable td, table.dataTable th { padding: 4px 6px; word-wrap: break-word; }
  table.dataTable th:nth-child(1), table.dataTable td:nth-child(1) { width: 22%; }
  table.dataTable th:nth-child(2), table.dataTable td:nth-child(2) { width: 50%; }
  table.dataTable th:nth-child(3), table.dataTable td:nth-child(3) { width: 28%; }
  table.dataTable th:nth-child(4), table.dataTable td:nth-child(4) { display: none; }
}
```
