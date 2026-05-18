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
#| viewerHeight: 720
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
import io
from pathlib import Path
from shiny import App, ui, render, reactive
import pandas as pd
import itables
from itables import to_html_datatable
from a11yviz import a11y_audit_chart, a11y_audit_actionable

from chart import base_plot, a11y_plot

itables.options.warn_on_undocumented_option = False

app_dir   = Path(__file__).parent
panel_css = (app_dir / "styles.css").read_text()

audit_opts = {"dom": "Bt", "ordering": False,
              "buttons": ["copy", "csv", "excel", "pdf"],
              "columnDefs": [{"className": "dt-left", "targets": "_all"}]}

def panel_body(plot_id, audit_id, dl_id):
    return ui.TagList(
        ui.div(
            ui.output_plot(plot_id, height="100%", width="100%"),
            class_="plot-wrap",
        ),
        ui.div(ui.download_button(dl_id, "Download chart (PNG)",
                                  class_="btn btn-sm"),
               class_="plot-actions"),
        ui.div(ui.output_ui(audit_id), class_="table-responsive"),
    )

app_ui = ui.page_fillable(
    ui.tags.head(ui.tags.style(panel_css)),
    ui.input_radio_buttons(
        "level", "WCAG level:",
        choices=["AA", "AAA"], selected="AA", inline=True,
    ),
    ui.navset_underline(
        ui.nav_panel("Baseline",   panel_body("plot_before", "audit_before", "dl_before")),
        ui.nav_panel("Accessible", panel_body("plot_after",  "audit_after",  "dl_after")),
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

    def save_chart(plot_fn):
        buf = io.BytesIO()
        plot_fn().save(buf, format="png", width=7, height=4.5,
                       units="in", dpi=150, verbose=False)
        buf.seek(0)
        yield buf.getvalue()

    @render.download(filename="chart_baseline.png")
    def dl_before():
        yield from save_chart(base)

    @render.download(filename="chart_accessible.png")
    def dl_after():
        yield from save_chart(accessible)

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
html, body { height: 100%; background: transparent; font-size: 14px; }
body, .nav-link, .form-check-label, .control-label, table.dataTable, table.dataTable th, table.dataTable td, table.dataTable > caption, .dataTables_info, .dt-info, .dataTables_paginate, .dt-paging { font-size: 14px !important; }
.bslib-card, .card { height: 100%; border: 0 !important; box-shadow: none !important; background: transparent !important; }
.card-body, .bslib-card > .card-body { padding: 0 !important; background: transparent !important; }
.tab-content { display: flex; flex-direction: column; flex: 1 1 auto !important; min-height: 0; }
.tab-pane.active { display: flex; flex-direction: column; flex: 1 1 auto; min-height: 0; overflow: hidden; }
.plot-wrap { flex: 0 0 320px; height: 320px; overflow: hidden; }
.plot-actions { flex: 0 0 auto; padding: 4px 0 8px; }
.plot-actions .btn { background: #fff; color: #1a1a1a; border: 1px solid #c0c0c0; border-radius: 3px; padding: 3px 8px; font-size: 12px; }
.plot-actions .btn:hover { background: #f0f0f0; border-color: #888; }
.plot-actions .btn:focus-visible { outline: 2px solid #1B6EC2; outline-offset: 2px; }
.table-responsive { flex: 0 0 220px; height: 220px; min-height: 220px; overflow-y: auto; overflow-x: hidden; }
.dataTables_wrapper, .dt-container { overflow: visible !important; }
table.dataTable { width: 100% !important; }
table.dataTable > caption { caption-side: top; text-align: left; font-weight: 600; color: #1a1a1a; padding: 0.5rem 0 0.25rem; position: sticky; top: 0; background: #fff; z-index: 2; }
table.dataTable thead th, table.dataTable thead td { background: #f5f5f5 !important; color: #1a1a1a !important; border-bottom-color: #d0d0d0 !important; }
table.dataTable.stripe > tbody > tr.odd > *, table.dataTable.display > tbody > tr.odd > * { background-color: #fafafa !important; }
.dt-buttons { display: flex; gap: 4px; margin: 4px 0 6px; flex-wrap: wrap; }
.dt-buttons .dt-button, .dt-buttons button.dt-button { background: #fff !important; color: #1a1a1a !important; border: 1px solid #c0c0c0 !important; border-radius: 3px !important; padding: 3px 8px !important; font-size: 12px !important; box-shadow: none !important; }
.dt-buttons .dt-button:hover, .dt-buttons button.dt-button:hover { background: #f0f0f0 !important; border-color: #888 !important; }
.dt-buttons .dt-button:focus-visible { outline: 2px solid #1B6EC2 !important; outline-offset: 2px !important; }
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
