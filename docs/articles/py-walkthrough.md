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

from plotnine import (ggplot, aes, geom_point, labs,
                      scale_color_manual,
                      theme, element_text)
from plotnine.data import penguins
from a11yviz import a11y_palette, theme_a11y, a11y_alt_text, a11y_minimum

penguins = penguins.dropna()

def base_plot():
    return (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point(size=1.0, alpha=0.45)
        + labs(title="Penguins (default)",
               x="flipper_length_mm", y="body_mass_g")
        + theme(text=element_text(size=9))
    )

def minimum_plot(level):
    threshold = {"AA": 12, "AAA": 14}[level]
    p = base_plot() + labs(title=f"Penguins (minimum, {level})")
    p = a11y_minimum(
        p, level=level,
        alt="Penguin body mass vs flipper length, retrofit with alt text and minimum text size.",
    )
    return p + theme(plot_title=element_text(size=threshold))

def a11y_plot(level):
    pal_name = {"AA": "dark2_8", "AAA": "aaa_5"}[level]
    palette  = a11y_palette(pal_name, n=penguins["species"].nunique())
    pt_size  = {"AA": 1.8, "AAA": 2.2}[level]
    p = (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point(size=pt_size, alpha=0.65)
        + scale_color_manual(values=palette)
        + theme_a11y(level=level)
        + theme(plot_title=element_text(weight="bold", ha="left"),
                legend_position="top")
        + labs(title=f"Penguins (accessible, {level})",
               x="Flipper length (mm)", y="Body mass (g)",
               color="Species")
    )
    return a11y_alt_text(
        p, "Penguin body mass vs flipper length by species, accessible chart."
    )

## file: app.py
from html import escape
from pathlib import Path
from shiny import App, ui, render, reactive
import pandas as pd
from a11yviz import a11y_audit_chart, a11y_audit_actionable

from chart import base_plot, minimum_plot, a11y_plot

panel_css = (Path(__file__).parent / "styles.css").read_text()

def panel_body(plot_id, audit_id):
    return ui.TagList(
        ui.output_plot(plot_id, height="440px"),
        ui.output_ui(audit_id),
    )

app_ui = ui.page_fluid(
    ui.tags.head(ui.tags.style(panel_css)),
    ui.input_radio_buttons(
        "level", "WCAG level:",
        choices=["AA", "AAA"], selected="AA", inline=True,
    ),
    ui.navset_underline(
        ui.nav_panel("Baseline",   panel_body("plot_before",  "audit_before")),
        ui.nav_panel("Minimum",    panel_body("plot_minimum", "audit_minimum")),
        ui.nav_panel("Accessible", panel_body("plot_after",   "audit_after")),
    ),
)

def server(input, output, session):
    @reactive.calc
    def base():
        return base_plot()

    @reactive.calc
    def minimum():
        return minimum_plot(input.level())

    @reactive.calc
    def accessible():
        return a11y_plot(input.level())

    @render.plot
    def plot_before():
        return base()

    @render.plot
    def plot_minimum():
        return minimum()

    @render.plot
    def plot_after():
        return accessible()

    def audit_table(p, level):
        df  = pd.DataFrame(a11y_audit_actionable(a11y_audit_chart(p, level=level)))
        ths = "".join(f"<th>{escape(str(c))}</th>" for c in df.columns)
        trs = "".join(
            "<tr>" + "".join(f"<td>{escape(str(v))}</td>" for v in row) + "</tr>"
            for row in df.itertuples(index=False)
        )
        return ui.HTML(
            '<table class="audit-table"><caption>Audit</caption>'
            f'<thead><tr>{ths}</tr></thead>'
            f'<tbody>{trs}</tbody></table>'
        )

    @render.ui
    def audit_before():
        return audit_table(base(), input.level())

    @render.ui
    def audit_minimum():
        return audit_table(minimum(), input.level())

    @render.ui
    def audit_after():
        return audit_table(accessible(), input.level())

app = App(app_ui, server)

## file: requirements.txt
shiny
plotnine
pandas
a11yviz==0.1.7

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
