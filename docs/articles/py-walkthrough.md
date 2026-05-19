# Python walkthrough

The same chart rendered with plotnine defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against accessible.

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
#| viewerHeight: 900
#| components: [editor, viewer]

## file: chart.py
# Edit the chart. Re-run (Ctrl+Shift+Enter) to update both panels and the audit.

from plotnine import (ggplot, aes, geom_point, geom_text, labs,
                      scale_color_manual, theme)
from plotnine.data import penguins
from a11yviz import a11y_palette, theme_a11y, a11y_alt_text

penguins  = penguins.dropna()
centroids = penguins.groupby("species", as_index=False).agg(
    flipper_length_mm=("flipper_length_mm", "mean"),
    body_mass_g=("body_mass_g", "mean"),
)

def base_plot():
    return (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point()
        + labs(title="Penguins (default plotnine)")
    )

def a11y_plot(level):
    pal_name = "aaa_5" if level == "AAA" else "dark2_8"
    palette = a11y_palette(pal_name, n=penguins["species"].nunique())
    p = (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point(size=2, alpha=0.75)
        + scale_color_manual(values=palette)
        + geom_text(data=centroids, mapping=aes(label="species"),
                    color="black", size=10, fontweight="bold",
                    show_legend=False)
        + theme_a11y(level=level)
        + labs(title="Penguins (theme_a11y + a11y_palette)",
               x="Flipper length (mm)", y="Body mass (g)", color="Species")
        + theme(legend_position="top")
    )
    return a11y_alt_text(
        p,
        "Penguin body mass vs flipper length by species, AA accessible.",
    )

## file: app.py
from pathlib import Path
from shiny import App, ui, render, reactive
import pandas as pd
import itables
from itables import to_html_datatable
from a11yviz import a11y_audit_chart, a11y_audit_actionable

from chart import base_plot, a11y_plot

itables.options.warn_on_undocumented_option = False

panel_css = (Path(__file__).parent / "styles.css").read_text()

audit_opts = {"dom": "t",
              "columnDefs": [{"className": "dt-left", "targets": "_all"}]}

def panel_body(plot_id, audit_id):
    return ui.TagList(
        ui.output_plot(plot_id, height="320px"),
        ui.output_ui(audit_id),
    )

app_ui = ui.page_fluid(
    ui.tags.head(ui.tags.style(panel_css)),
    ui.input_radio_buttons(
        "level", "WCAG level:",
        choices=["AA", "AAA"], selected="AA", inline=True,
    ),
    ui.navset_underline(
        ui.nav_panel("Baseline",   panel_body("plot_before", "audit_before")),
        ui.nav_panel("Accessible", panel_body("plot_after",  "audit_after")),
    ),
)

def server(input, output, session):
    @reactive.calc
    def base():
        return base_plot()

    @reactive.calc
    def accessible():
        return a11y_plot(input.level())

    @render.plot
    def plot_before():
        return base()

    @render.plot
    def plot_after():
        return accessible()

    def audit_table(p):
        rows = a11y_audit_actionable(a11y_audit_chart(p, level=input.level()))
        return ui.HTML(to_html_datatable(
            pd.DataFrame(rows),
            caption="Audit", classes="compact stripe hover",
            showIndex=False, **audit_opts))

    @render.ui
    def audit_before():
        return audit_table(base())

    @render.ui
    def audit_after():
        return audit_table(accessible())

app = App(app_ui, server)

## file: requirements.txt
shiny
plotnine
pandas
itables
a11yviz==0.1.5

## file: styles.css
html, body { background: transparent; font-size: 14px; }
body, .nav-link, .form-check-label, .control-label, table.dataTable, table.dataTable th, table.dataTable td, table.dataTable > caption { font-size: 14px !important; }
.bslib-card, .card { border: 0 !important; box-shadow: none !important; background: transparent !important; }
.card-body, .bslib-card > .card-body { padding: 0 !important; background: transparent !important; }
.bslib-card, .card, .card-body, .tab-content, .tab-pane, .navset-card-body { overflow: visible !important; max-height: none !important; height: auto !important; }
.dataTables_wrapper, .dt-container { overflow: visible !important; }
table.dataTable { width: 100% !important; }
table.dataTable > caption { caption-side: top; text-align: left; font-weight: 600; color: #1a1a1a; padding: 0.5rem 0 0.25rem; }
table.dataTable thead th { background: #f5f5f5 !important; color: #1a1a1a !important; }
@media (max-width: 576px) {
  table.dataTable { table-layout: fixed !important; }
  table.dataTable td, table.dataTable th { padding: 4px 6px; word-wrap: break-word; }
  table.dataTable th:nth-child(1), table.dataTable td:nth-child(1) { width: 22%; }
  table.dataTable th:nth-child(2), table.dataTable td:nth-child(2) { width: 50%; }
  table.dataTable th:nth-child(3), table.dataTable td:nth-child(3) { width: 28%; }
  table.dataTable th:nth-child(4), table.dataTable td:nth-child(4) { display: none; }
}
```
