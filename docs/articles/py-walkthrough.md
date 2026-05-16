# Python walkthrough

The same chart rendered with plotnine defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
contrast and font thresholds shift; the audit table reports
per-criterion status for each version. Switch tabs to compare baseline
against improved.

## Live demo

``` shinylive-python
#| '!! shinylive warning !!': |
#|   shinylive does not work in self-contained HTML documents.
#|   Please set `embed-resources: false` in your metadata.
#| standalone: true
#| viewerHeight: 860
#| components: [viewer]

## file: requirements.txt
shiny
plotnine
pandas
a11yviz==0.1.3

## file: app.py
from shiny import App, ui, render, reactive
from plotnine import (
    ggplot, aes, geom_point, labs,
    scale_color_manual, scale_shape_manual,
)
from plotnine.data import penguins
import pandas as pd
from a11yviz import theme_a11y, a11y_palette, a11y_alt_text, a11y_audit

penguins = penguins.dropna()
shapes = ["o", "s", "^", "D"]

def base_plot():
    return (
        ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
        + geom_point()
        + labs(title="Penguins (default plotnine)")
    )

def improved_plot(level):
    palette = a11y_palette("dark2_8", n=penguins["species"].nunique())
    p = (
        ggplot(penguins,
               aes("flipper_length_mm", "body_mass_g",
                   color="species", shape="species"))
        + geom_point()
        + scale_color_manual(values=palette)
        + scale_shape_manual(values=shapes[: penguins["species"].nunique()])
        + theme_a11y(level=level)
        + labs(title="Penguins (theme_a11y + a11y_palette + shape encoding)")
    )
    return a11y_alt_text(
        p,
        "Penguin body mass vs flipper length by species, AA accessible.",
    )

panel_css = """
html, body { height: 100%; }
.bslib-card { height: 100%; }
.tab-content { display: flex; flex-direction: column; }
.tab-pane.active { display: flex; flex-direction: column; flex: 1 1 auto; min-height: 0; }
.plot-wrap { flex: 1 1 auto; min-height: 320px; height: clamp(320px, 55vh, 620px); }
.table-responsive { overflow-x: auto; }
table { width: 100%; }
"""

def panel_body(plot_id, audit_id):
    return ui.TagList(
        ui.div(
            ui.output_plot(plot_id, height="100%", width="100%"),
            class_="plot-wrap",
        ),
        ui.h2("Audit", class_="h6 mt-3"),
        ui.div(ui.output_table(audit_id), class_="table-responsive"),
    )

app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_radio_buttons(
            "level", "WCAG level:",
            choices=["AA", "AAA"], selected="AA", inline=True,
        ),
        width=240,
    ),
    ui.tags.head(ui.tags.style(panel_css)),
    ui.navset_card_underline(
        ui.nav_panel("Baseline", panel_body("plot_before", "audit_before")),
        ui.nav_panel("Improved", panel_body("plot_after",  "audit_after")),
    ),
    fillable=True,
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
        return base().draw(show=False)

    @render.plot
    def plot_after():
        return improved().draw(show=False)

    @render.table(index=False, classes="table table-striped table-hover")
    def audit_before():
        return pd.DataFrame(a11y_audit(base(), level=input.level()))

    @render.table(index=False, classes="table table-striped table-hover")
    def audit_after():
        return pd.DataFrame(a11y_audit(improved(), level=input.level()))

app = App(app_ui, server)
```
