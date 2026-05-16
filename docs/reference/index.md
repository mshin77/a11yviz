# Package index

## ggplot2 transforms

Composable additions to a ggplot chain

- [`theme_a11y()`](https://mshin77.github.io/a11yviz/reference/theme_a11y.md)
  : Accessible ggplot2 theme
- [`scale_color_a11y()`](https://mshin77.github.io/a11yviz/reference/scale_a11y.md)
  [`scale_fill_a11y()`](https://mshin77.github.io/a11yviz/reference/scale_a11y.md)
  : Accessible discrete color and fill scales
- [`scale_color_a11y_div()`](https://mshin77.github.io/a11yviz/reference/scale_a11y_div.md)
  [`scale_fill_a11y_div()`](https://mshin77.github.io/a11yviz/reference/scale_a11y_div.md)
  : Accessible diverging color and fill scales
- [`scale_color_a11y_seq()`](https://mshin77.github.io/a11yviz/reference/scale_a11y_seq.md)
  [`scale_fill_a11y_seq()`](https://mshin77.github.io/a11yviz/reference/scale_a11y_seq.md)
  : Accessible sequential continuous color and fill scales

## plotly transforms

Layout and styling for plotly figures

- [`a11y_layout()`](https://mshin77.github.io/a11yviz/reference/a11y_layout.md)
  : Apply accessible layout to a plotly figure
- [`a11y_ggplotly()`](https://mshin77.github.io/a11yviz/reference/a11y_ggplotly.md)
  : Convert ggplot to accessible plotly for supplemental online output

## Alt text

Attach, scaffold, or LLM-draft screen-reader descriptions

- [`a11y_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_text.md)
  : Add alt text to a plot
- [`a11y_alt_template()`](https://mshin77.github.io/a11yviz/reference/a11y_alt_template.md)
  : Generate a deterministic alt-text template for a plot
- [`a11y_describe()`](https://mshin77.github.io/a11yviz/reference/a11y_describe.md)
  : Generate alt text via a user-supplied LLM backend

## Palettes

Discrete, diverging, and sequential palettes with WCAG metadata

- [`a11y_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_palette.md)
  : Discrete color palette (categorical)
- [`a11y_palette_div()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_div.md)
  : Diverging palette
- [`a11y_palette_seq()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_seq.md)
  : Sequential continuous palette
- [`a11y_palette_info()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_info.md)
  : Discrete palette metadata
- [`a11y_palette_list()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_list.md)
  : List available palettes
- [`a11y_show_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_show_palette.md)
  : Visualize a palette with WCAG contrast overlay

## Audits and checks

Multi-criterion figure audit, rubric, and single-aspect checks

- [`a11y_audit()`](https://mshin77.github.io/a11yviz/reference/a11y_audit.md)
  : Chart + document accessibility audit
- [`a11y_audit_chart()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_chart.md)
  : Chart-only accessibility audit
- [`a11y_audit_doc()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_doc.md)
  : Document-level accessibility audit
- [`a11y_audit_actionable()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_actionable.md)
  : Actionable rows from an audit
- [`a11y_audit_summary()`](https://mshin77.github.io/a11yviz/reference/a11y_audit_summary.md)
  : One-line summary of an audit
- [`a11y_rubric()`](https://mshin77.github.io/a11yviz/reference/a11y_rubric.md)
  : WCAG 2.1 rubric for the success criteria a11yviz addresses
- [`a11y_check_alt_text()`](https://mshin77.github.io/a11yviz/reference/a11y_check_alt_text.md)
  : Check alt-text presence and length (WCAG 1.1.1)
- [`a11y_check_headings()`](https://mshin77.github.io/a11yviz/reference/a11y_check_headings.md)
  : Check Markdown / Quarto / HTML heading hierarchy and labels
- [`a11y_check_overlap()`](https://mshin77.github.io/a11yviz/reference/a11y_check_overlap.md)
  : Scatter overlap check (WCAG Success Criterion 1.3.1)
- [`a11y_check_palette()`](https://mshin77.github.io/a11yviz/reference/a11y_check_palette.md)
  : Check a palette against WCAG contrast thresholds
- [`a11y_check_palette_size()`](https://mshin77.github.io/a11yviz/reference/a11y_check_palette_size.md)
  : Flag categorical palettes above the recommended maximum
- [`a11y_check_readability()`](https://mshin77.github.io/a11yviz/reference/a11y_check_readability.md)
  : Estimate reading level of prose
- [`a11y_check_separability()`](https://mshin77.github.io/a11yviz/reference/a11y_check_separability.md)
  : Flag color pairs below the WCAG 2.1 Success Criterion 1.4.11
  contrast threshold
- [`a11y_check_tabindex()`](https://mshin77.github.io/a11yviz/reference/a11y_check_tabindex.md)
  : Check that a tabindex value follows WCAG 2.1.1
- [`a11y_plotly_sequences()`](https://mshin77.github.io/a11yviz/reference/a11y_plotly_sequences.md)
  : Audit plotly's built-in discrete color sequences

## Shiny and HTML helpers

ARIA labels and live-region announcements for Shiny UI

- [`a11y_aria_label()`](https://mshin77.github.io/a11yviz/reference/a11y_aria_label.md)
  : Build an ARIA label string
- [`a11y_announce()`](https://mshin77.github.io/a11yviz/reference/a11y_announce.md)
  : Announce a status message to assistive technology

## Wrappers and utilities

One-shot helpers and resource paths

- [`make_a11y()`](https://mshin77.github.io/a11yviz/reference/make_a11y.md)
  : One-shot accessibility wrapper
- [`a11y_alpha_presets()`](https://mshin77.github.io/a11yviz/reference/a11y_alpha_presets.md)
  : Alpha presets for chart layers
- [`a11y_text_spacing_ratios()`](https://mshin77.github.io/a11yviz/reference/a11y_text_spacing_ratios.md)
  : WCAG 1.4.12 text-spacing ratios (reference data)
- [`a11y_css()`](https://mshin77.github.io/a11yviz/reference/a11y_css.md)
  : Path to the accessible CSS
- [`a11y_css_contents()`](https://mshin77.github.io/a11yviz/reference/a11y_css_contents.md)
  : Contents of the accessible CSS
- [`a11y_wcag_url()`](https://mshin77.github.io/a11yviz/reference/a11y_wcag_url.md)
  : WCAG 2.1 specification URL for a success criterion
- [`run_app()`](https://mshin77.github.io/a11yviz/reference/run_app.md)
  : Launch the local accessibility playground
