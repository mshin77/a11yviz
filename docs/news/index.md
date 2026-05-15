# Changelog

## a11yviz 0.1.2

- Shiny and HTML accessibility helpers added.
- Add-on stylesheet for Shiny apps.
- Alt-text audit now asks for a final manual check.
- Open the demo from a local R session with a one-line launcher.

## a11yviz 0.1.1

- Documentation hyperlinks corrected.
- [`a11y_check_overlap()`](https://mshin77.github.io/a11yviz/reference/a11y_check_overlap.md)
  for scatter overlap (WCAG Success Criterion 1.3.1).
- WCAG citations use `Success Criterion X.X.X` form.
- Defensive validation removed; bad input fails at the natural site.
- Vignette tables share a single `dt_show()` helper.

## a11yviz 0.1.0

- First release: accessible themes, palettes, and audits for ggplot2,
  plotly, and Quarto.
- WCAG-tagged palettes for discrete, diverging, and sequential data,
  with a per-criterion audit and reference rubric.
- Bundled stylesheet covering tooltips, dark mode, focus rings, and
  tables.
- Helpers to flag colour pairs too similar to tell apart and warn when a
  palette has too many categories.
- Interactive playground ships as a static shinylive page inside the
  unified pkgdown + Quarto site — no install or R server needed.
