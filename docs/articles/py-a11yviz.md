# Getting started with a11yviz (Python)

``` python
import a11yviz
import pandas as pd
from itables import show
from plotnine import aes, geom_point, ggplot, labs
from plotnine.data import penguins

penguins = penguins.dropna()

dt_options = dict(
    buttons=["copy", "csv", "excel", "pdf"],
    pageLength=10,
    scrollX=True,
    autoWidth=True,
    classes="compact stripe hover",
)
```

## Example

``` python
p = (
    ggplot(penguins, aes("flipper_length_mm", "body_mass_g", color="species"))
    + geom_point()
    + labs(x="Flipper length (mm)", y="Body mass (g)")
)
p
```

![](py-a11yviz_files/figure-html/example-output-1.png)

## Audit reveals the gaps

[`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md)
returns one row per WCAG criterion with a status field. The table below
filters to **actionable** rows (`status = "todo"` or `"ok"`) — the items
where the chart needs human attention.

| status | meaning |
|----|----|
| `ok` | check passes automatically |
| `todo` | needs user action |
| `applied` | handled by [`theme_a11y()`](https://mshin77.github.io/a11yviz/reference/theme_a11y.md) / `scale_*_a11y()` / [`a11y_layout()`](https://mshin77.github.io/a11yviz/reference/a11y_layout.md) |
| `manual` | requires human review (e.g., reflow at 320 px) |
| `css` | covered by [`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md) stylesheet |
| `doc` | document-level check; run [`a11y_check_headings()`](https://mshin77.github.io/a11yviz/reference/a11y_check_headings.md) separately |
| `n/a` | not applicable to this chart type (e.g., hover on plotnine) |

``` python
show(pd.DataFrame([r for r in a11yviz.a11y_audit(p) if r["status"] in ("todo", "ok")]),
     table_id="audit-example", **dt_options)
```

|  |
|:---|
| [![](data:image/svg+xml;base64,PHN2ZyBjbGFzcz0ibWFpbi1zdmciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHdpZHRoPSI2NCIgdmlld2JveD0iMCAwIDUwMCA0MDAiIHN0eWxlPSJmb250LWZhbWlseTogJiMzOTtEcm9pZCBTYW5zJiMzOTssIHNhbnMtc2VyaWY7Ij48ZyBzdHlsZT0iZmlsbDojZDlkN2ZjIj48cGF0aCBkPSJNMTAwLDQwMEg1MDBWMzU3SDEwMFoiIC8+PHBhdGggZD0iTTEwMCwzMDBINDAwVjI1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0wLDIwMEg0MDBWMTU3SDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMTAwSDUwMFY1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMzUwSDUwMFYzMDdIMTAwWiIgLz48cGF0aCBkPSJNMTAwLDI1MEg0MDBWMjA3SDEwMFoiIC8+PHBhdGggZD0iTTAsMTUwSDQwMFYxMDdIMFoiIC8+PHBhdGggZD0iTTEwMCw1MEg1MDBWN0gxMDBaIiAvPjwvZz48ZyBzdHlsZT0iZmlsbDojMWExMzY2O3N0cm9rZTojMWExMzY2OyI+PHJlY3QgeD0iMTAwIiB5PSI3IiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQzIj48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ3aWR0aCIgdmFsdWVzPSIwOzQwMDswIiBkdXI9IjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMTAwOzEwMDs1MDAiIGR1cj0iNXMiIHJlcGVhdGNvdW50PSJpbmRlZmluaXRlIj48L2FuaW1hdGU+PC9yZWN0PjxyZWN0IHg9IjAiIHk9IjEwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMDswOzQwMCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjIwNyIgd2lkdGg9IjMwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDszMDA7MCIgZHVyPSIzcyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NDAwIiBkdXI9IjNzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjMwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSI0cyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NTAwIiBkdXI9IjRzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48ZyBzdHlsZT0iZmlsbDp0cmFuc3BhcmVudDtzdHJva2Utd2lkdGg6ODsgc3Ryb2tlLWxpbmVqb2luOnJvdW5kIiByeD0iNSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDUgNTApIHJvdGF0ZSgtNDUpIj48Y2lyY2xlIHI9IjMzIiBjeD0iMCIgY3k9IjAiPjwvY2lyY2xlPjxyZWN0IHg9Ii04IiB5PSIzMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjMwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0NTAgMTUyKSI+PHBvbHlsaW5lIHBvaW50cz0iLTE1LC0yMCAtMzUsLTIwIC0zNSw0MCAyNSw0MCAyNSwyMCI+PC9wb2x5bGluZT48cmVjdCB4PSItMTUiIHk9Ii00MCIgd2lkdGg9IjYwIiBoZWlnaHQ9IjYwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MCAzNTIpIj48cG9seWdvbiBwb2ludHM9Ii0zNSwtNSAwLC00MCAzNSwtNSI+PC9wb2x5Z29uPjxwb2x5Z29uIHBvaW50cz0iLTM1LDEwIDAsNDUgMzUsMTAiPjwvcG9seWdvbj48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzUgMjUwKSI+PHBvbHlsaW5lIHBvaW50cz0iLTMwLDMwIC02MCwwIC0zMCwtMzAiPjwvcG9seWxpbmU+PHBvbHlsaW5lIHBvaW50cz0iMCwzMCAtMzAsMCAwLC0zMCI+PC9wb2x5bGluZT48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDI1IDI1MCkgcm90YXRlKDE4MCkiPjxwb2x5bGluZSBwb2ludHM9Ii0zMCwzMCAtNjAsMCAtMzAsLTMwIj48L3BvbHlsaW5lPjxwb2x5bGluZSBwb2ludHM9IjAsMzAgLTMwLDAgMCwtMzAiPjwvcG9seWxpbmU+PC9nPjwvZz48L2c+PC9zdmc+)](https://mwouts.github.io/itables/) Loading ITables v2.7.3 from the internet... (need [help](https://mwouts.github.io/itables/troubleshooting.html)?) |

Two actionable items come back as `todo`:

- WCAG 1.1.1: alt text missing
- WCAG 1.4.1: redundant group encoding (color only)

## Improved

``` python
p2 = (
    ggplot(penguins, aes("flipper_length_mm", "body_mass_g",
                         color="species", shape="species"))
    + geom_point()
    + a11yviz.theme_a11y()
    + a11yviz.scale_color_a11y(palette="dark2_8")
    + labs(x="Flipper length (mm)", y="Body mass (g)")
)
p2 = a11yviz.a11y_alt_text(
    p2,
    "Scatter of penguin body mass vs flipper length by species; "
    "Gentoo cluster at long flippers and high body mass.",
)
p2
```

    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.
    findfont: Font family '' not found.

![](py-a11yviz_files/figure-html/improved-output-2.png)

Four accessibility wins from a few extra lines: `shape="species"`
encodes group via marker shape (Success Criterion 1.4.1),
`scale_color_a11y("dark2_8")` swaps in WCAG-tagged colors that clear 3:1
on white (Success Criterion 1.4.11),
[`theme_a11y()`](https://mshin77.github.io/a11yviz/reference/theme_a11y.md)
applies the recommended font sizes and axis styling (Success Criterion
1.4.4), and
[`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md)
attaches the screen-reader description (Success Criterion 1.1.1).

## Audit again

``` python
show(pd.DataFrame([r for r in a11yviz.a11y_audit(p2) if r["status"] in ("todo", "ok")]),
     table_id="audit-improved", **dt_options)
```

|  |
|:---|
| [![](data:image/svg+xml;base64,PHN2ZyBjbGFzcz0ibWFpbi1zdmciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHdpZHRoPSI2NCIgdmlld2JveD0iMCAwIDUwMCA0MDAiIHN0eWxlPSJmb250LWZhbWlseTogJiMzOTtEcm9pZCBTYW5zJiMzOTssIHNhbnMtc2VyaWY7Ij48ZyBzdHlsZT0iZmlsbDojZDlkN2ZjIj48cGF0aCBkPSJNMTAwLDQwMEg1MDBWMzU3SDEwMFoiIC8+PHBhdGggZD0iTTEwMCwzMDBINDAwVjI1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0wLDIwMEg0MDBWMTU3SDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMTAwSDUwMFY1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMzUwSDUwMFYzMDdIMTAwWiIgLz48cGF0aCBkPSJNMTAwLDI1MEg0MDBWMjA3SDEwMFoiIC8+PHBhdGggZD0iTTAsMTUwSDQwMFYxMDdIMFoiIC8+PHBhdGggZD0iTTEwMCw1MEg1MDBWN0gxMDBaIiAvPjwvZz48ZyBzdHlsZT0iZmlsbDojMWExMzY2O3N0cm9rZTojMWExMzY2OyI+PHJlY3QgeD0iMTAwIiB5PSI3IiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQzIj48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ3aWR0aCIgdmFsdWVzPSIwOzQwMDswIiBkdXI9IjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMTAwOzEwMDs1MDAiIGR1cj0iNXMiIHJlcGVhdGNvdW50PSJpbmRlZmluaXRlIj48L2FuaW1hdGU+PC9yZWN0PjxyZWN0IHg9IjAiIHk9IjEwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMDswOzQwMCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjIwNyIgd2lkdGg9IjMwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDszMDA7MCIgZHVyPSIzcyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NDAwIiBkdXI9IjNzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjMwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSI0cyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NTAwIiBkdXI9IjRzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48ZyBzdHlsZT0iZmlsbDp0cmFuc3BhcmVudDtzdHJva2Utd2lkdGg6ODsgc3Ryb2tlLWxpbmVqb2luOnJvdW5kIiByeD0iNSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDUgNTApIHJvdGF0ZSgtNDUpIj48Y2lyY2xlIHI9IjMzIiBjeD0iMCIgY3k9IjAiPjwvY2lyY2xlPjxyZWN0IHg9Ii04IiB5PSIzMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjMwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0NTAgMTUyKSI+PHBvbHlsaW5lIHBvaW50cz0iLTE1LC0yMCAtMzUsLTIwIC0zNSw0MCAyNSw0MCAyNSwyMCI+PC9wb2x5bGluZT48cmVjdCB4PSItMTUiIHk9Ii00MCIgd2lkdGg9IjYwIiBoZWlnaHQ9IjYwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MCAzNTIpIj48cG9seWdvbiBwb2ludHM9Ii0zNSwtNSAwLC00MCAzNSwtNSI+PC9wb2x5Z29uPjxwb2x5Z29uIHBvaW50cz0iLTM1LDEwIDAsNDUgMzUsMTAiPjwvcG9seWdvbj48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzUgMjUwKSI+PHBvbHlsaW5lIHBvaW50cz0iLTMwLDMwIC02MCwwIC0zMCwtMzAiPjwvcG9seWxpbmU+PHBvbHlsaW5lIHBvaW50cz0iMCwzMCAtMzAsMCAwLC0zMCI+PC9wb2x5bGluZT48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDI1IDI1MCkgcm90YXRlKDE4MCkiPjxwb2x5bGluZSBwb2ludHM9Ii0zMCwzMCAtNjAsMCAtMzAsLTMwIj48L3BvbHlsaW5lPjxwb2x5bGluZSBwb2ludHM9IjAsMzAgLTMwLDAgMCwtMzAiPjwvcG9seWxpbmU+PC9nPjwvZz48L2c+PC9zdmc+)](https://mwouts.github.io/itables/) Loading ITables v2.7.3 from the internet... (need [help](https://mwouts.github.io/itables/troubleshooting.html)?) |

All actionable checks come back as `ok`.

## WCAG rubric

[`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md)
is the per-criterion reference: name, level, threshold, and the
`a11yviz` function that addresses each. Same `criterion` field as
[`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md),
so the two join cleanly.

``` python
show(pd.DataFrame(a11yviz.a11y_rubric()), table_id="rubric", **dt_options)
```

|  |
|:---|
| [![](data:image/svg+xml;base64,PHN2ZyBjbGFzcz0ibWFpbi1zdmciIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHdpZHRoPSI2NCIgdmlld2JveD0iMCAwIDUwMCA0MDAiIHN0eWxlPSJmb250LWZhbWlseTogJiMzOTtEcm9pZCBTYW5zJiMzOTssIHNhbnMtc2VyaWY7Ij48ZyBzdHlsZT0iZmlsbDojZDlkN2ZjIj48cGF0aCBkPSJNMTAwLDQwMEg1MDBWMzU3SDEwMFoiIC8+PHBhdGggZD0iTTEwMCwzMDBINDAwVjI1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0wLDIwMEg0MDBWMTU3SDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMTAwSDUwMFY1N0gxMDBaIiAvPjxwYXRoIGQ9Ik0xMDAsMzUwSDUwMFYzMDdIMTAwWiIgLz48cGF0aCBkPSJNMTAwLDI1MEg0MDBWMjA3SDEwMFoiIC8+PHBhdGggZD0iTTAsMTUwSDQwMFYxMDdIMFoiIC8+PHBhdGggZD0iTTEwMCw1MEg1MDBWN0gxMDBaIiAvPjwvZz48ZyBzdHlsZT0iZmlsbDojMWExMzY2O3N0cm9rZTojMWExMzY2OyI+PHJlY3QgeD0iMTAwIiB5PSI3IiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQzIj48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ3aWR0aCIgdmFsdWVzPSIwOzQwMDswIiBkdXI9IjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMTAwOzEwMDs1MDAiIGR1cj0iNXMiIHJlcGVhdGNvdW50PSJpbmRlZmluaXRlIj48L2FuaW1hdGU+PC9yZWN0PjxyZWN0IHg9IjAiIHk9IjEwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjxhbmltYXRlIGF0dHJpYnV0ZW5hbWU9IngiIHZhbHVlcz0iMDswOzQwMCIgZHVyPSIzLjVzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjIwNyIgd2lkdGg9IjMwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDszMDA7MCIgZHVyPSIzcyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NDAwIiBkdXI9IjNzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48cmVjdCB4PSIxMDAiIHk9IjMwNyIgd2lkdGg9IjQwMCIgaGVpZ2h0PSI0MyI+PGFuaW1hdGUgYXR0cmlidXRlbmFtZT0id2lkdGgiIHZhbHVlcz0iMDs0MDA7MCIgZHVyPSI0cyIgcmVwZWF0Y291bnQ9ImluZGVmaW5pdGUiPjwvYW5pbWF0ZT48YW5pbWF0ZSBhdHRyaWJ1dGVuYW1lPSJ4IiB2YWx1ZXM9IjEwMDsxMDA7NTAwIiBkdXI9IjRzIiByZXBlYXRjb3VudD0iaW5kZWZpbml0ZSI+PC9hbmltYXRlPjwvcmVjdD48ZyBzdHlsZT0iZmlsbDp0cmFuc3BhcmVudDtzdHJva2Utd2lkdGg6ODsgc3Ryb2tlLWxpbmVqb2luOnJvdW5kIiByeD0iNSI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDUgNTApIHJvdGF0ZSgtNDUpIj48Y2lyY2xlIHI9IjMzIiBjeD0iMCIgY3k9IjAiPjwvY2lyY2xlPjxyZWN0IHg9Ii04IiB5PSIzMiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjMwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg0NTAgMTUyKSI+PHBvbHlsaW5lIHBvaW50cz0iLTE1LC0yMCAtMzUsLTIwIC0zNSw0MCAyNSw0MCAyNSwyMCI+PC9wb2x5bGluZT48cmVjdCB4PSItMTUiIHk9Ii00MCIgd2lkdGg9IjYwIiBoZWlnaHQ9IjYwIiAvPjwvZz48ZyB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1MCAzNTIpIj48cG9seWdvbiBwb2ludHM9Ii0zNSwtNSAwLC00MCAzNSwtNSI+PC9wb2x5Z29uPjxwb2x5Z29uIHBvaW50cz0iLTM1LDEwIDAsNDUgMzUsMTAiPjwvcG9seWdvbj48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNzUgMjUwKSI+PHBvbHlsaW5lIHBvaW50cz0iLTMwLDMwIC02MCwwIC0zMCwtMzAiPjwvcG9seWxpbmU+PHBvbHlsaW5lIHBvaW50cz0iMCwzMCAtMzAsMCAwLC0zMCI+PC9wb2x5bGluZT48L2c+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNDI1IDI1MCkgcm90YXRlKDE4MCkiPjxwb2x5bGluZSBwb2ludHM9Ii0zMCwzMCAtNjAsMCAtMzAsLTMwIj48L3BvbHlsaW5lPjxwb2x5bGluZSBwb2ludHM9IjAsMzAgLTMwLDAgMCwtMzAiPjwvcG9seWxpbmU+PC9nPjwvZz48L2c+PC9zdmc+)](https://mwouts.github.io/itables/) Loading ITables v2.7.3 from the internet... (need [help](https://mwouts.github.io/itables/troubleshooting.html)?) |

## Accessible CSS

[`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md)
returns the path to a stylesheet that handles dark-mode tooltips,
keyboard focus rings, table styling, and responsive layout.
`a11y_css("shiny")` also returns the path to the Shiny add-on with
skip-link, reduced-motion, and high-contrast rules.

``` python
import os
os.path.basename(str(a11yviz.a11y_css()))
```

    'a11yviz.css'

## Playground

`a11yviz.run_app()` launches a local Shiny for Python playground
(mirrors the R
[`run_app()`](https://mshin77.github.io/a11yviz/reference/run_app.md)).
Two tabs compare a baseline plotnine chart against the a11y-improved
version with paired audit tables; toggle between WCAG AA and AAA in the
sidebar. Requires the `playground` extra:

``` bash
pip install "a11yviz[playground]"
```

``` python
import a11yviz
a11yviz.run_app()
```

## More features

- **Palettes** —
  [`a11y_palette_list()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_list.md)
  enumerates discrete palettes with WCAG metadata.
  [`a11y_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_palette.md),
  [`a11y_palette_div()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_div.md),
  [`a11y_palette_seq()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_seq.md)
  resolve hex codes for plotnine / plotly.
- **Plotly** —
  [`a11y_layout()`](https://mshin77.github.io/a11yviz/reference/a11y_layout.md)
  applies accessible chrome, fonts, and colorway.
  [`a11y_plotly_sequences()`](https://mshin77.github.io/a11yviz/reference/a11y_plotly_sequences.md)
  audits plotly’s built-in discrete colorways.
- **Document-level checks** —
  [`a11y_check_headings()`](https://mshin77.github.io/a11yviz/reference/a11y_check_headings.md)
  and
  [`a11y_check_readability()`](https://mshin77.github.io/a11yviz/reference/a11y_check_readability.md)
  flag heading-skip and reading-level issues in `.qmd` / `.Rmd` / `.md`
  files.
- **Live-region announcements** —
  [`a11y_announce()`](https://mshin77.github.io/a11yviz/reference/a11y_announce.md)
  wraps a status message in a live region for screen-reader-only
  announcement.
- **Alpha guidance** —
  [`a11y_alpha_presets()`](https://mshin77.github.io/a11yviz/reference/a11y_alpha_presets.md)
  returns sensible alpha values for overlay layers; verify composited
  contrast with `a11y_check_palette(alpha=...)`.

See the [function
reference](https://mshin77.github.io/a11yviz/articles/py-reference.md)
for the full API.

## References

- Crameri, F., Shephard, G. E., & Heron, P. J. (2020). The misuse of
  colour in science communication. *Nature Communications*, 11, 5444.
- Nuñez, J. R., Anderton, C. R., & Renslow, R. S. (2018). Optimizing
  colormaps with consideration for color vision deficiency to enable
  accurate interpretation of scientific data. *PLoS ONE*, 13(7),
  e0199239.
- [WCAG 2.1 specification](https://www.w3.org/TR/WCAG21/) — pass any
  `criterion` value to
  [`a11y_wcag_url()`](https://mshin77.github.io/a11yviz/reference/a11y_wcag_url.md)
  for the deep link.
- [ADA web guidance](https://www.ada.gov/resources/web-guidance/)
