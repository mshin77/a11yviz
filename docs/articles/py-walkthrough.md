# Python walkthrough

The same chart rendered with plotly defaults versus the package’s
accessible layout, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against improved.

``` shinylive-python
#| '!! shinylive warning !!': |
#|   shinylive does not work in self-contained HTML documents.
#|   Please set `embed-resources: false` in your metadata.
#| standalone: true
#| viewerHeight: 720

## file: requirements.txt
shiny
shinywidgets
plotly
pandas
plotnine
a11yviz

## file: app.py
from shiny import App, ui, render
from shinywidgets import output_widget, render_widget
import plotly.express as px
from plotnine.data import penguins
import pandas as pd
from a11yviz import a11y_layout, a11y_alt_text, a11y_audit

penguins = penguins.dropna()

def base_fig():
    return px.scatter(
        penguins, x="flipper_length_mm", y="body_mass_g",
        color="species",
        title="Penguins (default plotly)",
    )

def improved_fig(level):
    fig = px.scatter(
        penguins, x="flipper_length_mm", y="body_mass_g",
        color="species", symbol="species",
        title="Penguins (a11y_layout + redundant shape encoding)",
    )
    fig = a11y_layout(fig, level=level)
    fig = a11y_alt_text(
        fig,
        "Penguin body mass vs flipper length by species, AA accessible.",
    )
    return fig

app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_radio_buttons(
            "level", "WCAG level:",
            choices=["AA", "AAA"], selected="AA", inline=True,
        ),
        width=240,
    ),
    ui.navset_card_underline(
        ui.nav_panel("Baseline",
            output_widget("plot_before"),
            ui.h3("Audit", class_="h6 mt-3"),
            ui.output_data_frame("audit_before"),
        ),
        ui.nav_panel("Improved",
            output_widget("plot_after"),
            ui.h3("Audit", class_="h6 mt-3"),
            ui.output_data_frame("audit_after"),
        ),
    ),
)

def server(input, output, session):
    @render_widget
    def plot_before():
        return base_fig()

    @render_widget
    def plot_after():
        return improved_fig(input.level())

    @render.data_frame
    def audit_before():
        rows = a11y_audit(base_fig(), level=input.level())
        return render.DataGrid(pd.DataFrame(rows), height="320px")

    @render.data_frame
    def audit_after():
        rows = a11y_audit(improved_fig(input.level()), level=input.level())
        return render.DataGrid(pd.DataFrame(rows), height="320px")

app = App(app_ui, server)
```
