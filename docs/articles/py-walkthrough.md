# Python walkthrough

The same chart rendered with plotnine defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against improved.

Edit the code on the left to swap in a different dataset, change
aesthetics, or tweak the theme — the chart and audit update on the
right.

## Live demo

``` shinylive-python
#| '!! shinylive warning !!': |
#|   shinylive does not work in self-contained HTML documents.
#|   Please set `embed-resources: false` in your metadata.
#| label: py-playground
#| standalone: true
#| viewerHeight: 720
#| components: [editor, viewer]

## file: app.py
from shiny import App, ui, render, reactive
from plotnine import ggplot, aes, geom_point, labs, scale_color_manual, theme
from plotnine.data import penguins
import pandas as pd
import itables
from itables import to_html_datatable
from a11yviz import (theme_a11y, a11y_palette, a11y_alt_text,
                     a11y_audit_chart, a11y_audit_actionable)

itables.options.warn_on_undocumented_option = False

with open("styles.css") as f:
    panel_css = f.read()

dt_kwargs = {"dom": "t", "ordering": False,
             "columnDefs": [{"className": "dt-left", "targets": "_all"}]}

penguins = penguins.dropna()

def base_plot():
    return (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point()
        + labs(title="Penguins (default plotnine)")
    )

def improved_plot(level):
    palette = a11y_palette("dark2_8", n=penguins["species"].nunique())
    p = (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point(size=2, alpha=0.75)
        + scale_color_manual(values=palette)
        + theme_a11y(level=level)
        + labs(title="Penguins (theme_a11y + a11y_palette)",
               x="Flipper length (mm)", y="Body mass (g)", color="Species")
        + theme(legend_position="top")
    )
    return a11y_alt_text(
        p,
        "Penguin body mass vs flipper length by species, AA accessible.",
    )

def panel_body(plot_id, audit_id):
    return ui.TagList(
        ui.div(
            ui.output_plot(plot_id, height="100%", width="100%"),
            class_="plot-wrap",
        ),
        ui.div(ui.output_ui(audit_id), class_="table-responsive"),
    )

app_ui = ui.page_fillable(
    ui.tags.head(ui.tags.style(panel_css)),
    ui.input_radio_buttons(
        "level", "WCAG level:",
        choices=["AA", "AAA"], selected="AA", inline=True,
    ),
    ui.navset_underline(
        ui.nav_panel("Baseline", panel_body("plot_before", "audit_before")),
        ui.nav_panel("Improved", panel_body("plot_after",  "audit_after")),
    ),
)

def server(input, output, session):
    @reactive.calc
    def base():
        return base_plot()

    @reactive.calc
    def improved():
        return improved_plot(input.level())

    @render.plot
    def plot_before():
        return base()

    @render.plot
    def plot_after():
        return improved()

    def actionable_df(p):
        rows = a11y_audit_actionable(a11y_audit_chart(p, level=input.level()))
        return pd.DataFrame(rows)

    @render.ui
    def audit_before():
        return ui.HTML(to_html_datatable(actionable_df(base()),
                                         caption="Audit",
                                         classes="compact stripe hover",
                                         showIndex=False, **dt_kwargs))

    @render.ui
    def audit_after():
        return ui.HTML(to_html_datatable(actionable_df(improved()),
                                         caption="Audit",
                                         classes="compact stripe hover",
                                         showIndex=False, **dt_kwargs))

app = App(app_ui, server)

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

## file: requirements.txt
shiny
plotnine
pandas
itables
a11yviz==0.1.4
```
