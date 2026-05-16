# Python walkthrough

The same chart rendered with plotnine defaults versus the package’s
accessible theme, palette, and alt text. Toggle the WCAG level to see
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
plotnine
pandas
a11yviz==0.1.3

## file: app.py
from shiny import App, ui, render
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

app_ui = ui.page_sidebar(
    ui.sidebar(
        ui.input_radio_buttons(
            "level", "WCAG level:",
            choices=["AA", "AAA"], selected="AA", inline=True,
        ),
        width=220,
    ),
    ui.navset_card_underline(
        ui.nav_panel("Baseline",
            ui.output_plot("plot_before", height="320px"),
            ui.h3("Audit", class_="h6 mt-3"),
            ui.output_table("audit_before"),
        ),
        ui.nav_panel("Improved",
            ui.output_plot("plot_after", height="320px"),
            ui.h3("Audit", class_="h6 mt-3"),
            ui.output_table("audit_after"),
        ),
    ),
    fillable=True,
)

def server(input, output, session):
    @render.plot(width=640, height=320)
    def plot_before():
        return base_plot().draw(show=False)

    @render.plot(width=640, height=320)
    def plot_after():
        return improved_plot(input.level()).draw(show=False)

    @render.table
    def audit_before():
        return pd.DataFrame(a11y_audit(base_plot(), level=input.level()))

    @render.table
    def audit_after():
        return pd.DataFrame(a11y_audit(improved_plot(input.level()), level=input.level()))

app = App(app_ui, server)
```
