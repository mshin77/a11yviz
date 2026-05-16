# R function reference

**Install:**
`install.packages("a11yviz", repos = c("https://mshin77.r-universe.dev", "https://cloud.r-project.org"))`

## ggplot2 transforms

Composable additions to a ggplot chain.

| Function | Description |
|----|----|
| `theme_a11y(level = "AA", base_family = "", dark = FALSE)` | Accessible ggplot2 theme |
| `scale_color_a11y(palette = NULL, level = "AA", ...)` | Accessible discrete color and fill scales |
| `scale_fill_a11y(palette = NULL, level = "AA", ...)` | Accessible discrete color and fill scales |
| `scale_color_a11y_div(palette = "rdbu", ...)` | Accessible diverging color and fill scales |
| `scale_fill_a11y_div(palette = "rdbu", ...)` | Accessible diverging color and fill scales |
| `scale_color_a11y_seq(palette = "cividis", ...)` | Accessible sequential continuous color and fill scales |
| `scale_fill_a11y_seq(palette = "cividis", ...)` | Accessible sequential continuous color and fill scales |

## plotly transforms

Layout and styling for plotly figures.

| Function | Description |
|----|----|
| `a11y_layout(p, level = "AA", palette = "dark2_8")` | Apply accessible layout to a plotly figure |
| `a11y_ggplotly(gg, level = "AA", palette = NULL, alt = NULL, tooltip = c("x", "y"), strip_title = TRUE, ...)` | Convert ggplot to accessible plotly for supplemental online output |

## Alt text

Attach, scaffold, or LLM-draft screen-reader descriptions.

| Function | Description |
|----|----|
| `a11y_alt_text(p, text)` | Add alt text to a plot |
| `a11y_alt_template(p)` | Generate a deterministic alt-text template for a plot |
| `a11y_describe(p, backend, attach = TRUE)` | Generate alt text via a user-supplied LLM backend |

## Palettes

Discrete, diverging, and sequential palettes with WCAG metadata.

| Function | Description |
|----|----|
| `a11y_palette(name = "dark2_8", n = NULL, bg = NULL)` | Discrete color palette (categorical) |
| `a11y_palette_div(name = "rdbu")` | Diverging palette |
| `a11y_palette_seq(name = "cividis", n = NULL)` | Sequential continuous palette |
| `a11y_palette_info(name = "dark2_8")` | Discrete palette metadata |
| `a11y_palette_list(type = NULL)` | List available palettes |
| `a11y_show_palette(name = "dark2_8", bg = "#ffffff", level = "AA")` | Visualize a palette with WCAG contrast overlay |

## Audits and checks

Multi-criterion figure audit, rubric, and single-aspect checks.

| Function | Description |
|----|----|
| `a11y_audit(p, level = "AA")` | Chart + document accessibility audit |
| `a11y_audit_chart(p, level = "AA")` | Chart-only accessibility audit |
| `a11y_audit_doc(level = "AA")` | Document-level accessibility audit |
| `a11y_audit_actionable(audit)` | Actionable rows from an audit |
| `a11y_audit_summary(audit)` | One-line summary of an audit |
| `a11y_rubric(level = NULL)` | WCAG 2.1 rubric for the success criteria a11yviz addresses |
| `a11y_check_alt_text(alt_text, element_type = "image", decorative = FALSE, min_length = 10)` | Check alt-text presence and length (WCAG 1.1.1) |
| `a11y_check_headings(path, min_chars = 3)` | Check Markdown / Quarto / HTML heading hierarchy and labels |
| `a11y_check_overlap(p, bins = 100)` | Scatter overlap check (WCAG Success Criterion 1.3.1) |
| `a11y_check_palette(colors, bg = "#ffffff", level = "AA", alpha = 1)` | Check a palette against WCAG contrast thresholds |
| `a11y_check_palette_size(n, max = 7)` | Flag categorical palettes above the recommended maximum |
| `a11y_check_readability(text)` | Estimate reading level of prose |
| `a11y_check_separability(colors, min_ratio = 3)` | Flag color pairs below the WCAG 2.1 Success Criterion 1.4.11 contrast threshold |
| `a11y_check_tabindex(tabindex = 0)` | Check that a tabindex value follows WCAG 2.1.1 |
| `a11y_plotly_sequences(bg = "#ffffff", level = "AA")` | Audit plotly’s built-in discrete color sequences |

## Shiny and HTML helpers

ARIA labels and live-region announcements for Shiny UI.

| Function | Description |
|----|----|
| `a11y_aria_label(element_type, action, context = NULL)` | Build an ARIA label string |
| `a11y_announce(text)` | Announce a status message to assistive technology |

## Wrappers and utilities

One-shot helpers and resource paths.

| Function | Description |
|----|----|
| `make_a11y(p, level = "AA", palette = "dark2_8", alt = NULL)` | One-shot accessibility wrapper |
| [`a11y_alpha_presets()`](https://mshin77.github.io/a11yviz/reference/a11y_alpha_presets.md) | Alpha presets for chart layers |
| [`a11y_text_spacing_ratios()`](https://mshin77.github.io/a11yviz/reference/a11y_text_spacing_ratios.md) | WCAG 1.4.12 text-spacing ratios (reference data) |
| `a11y_css(mode = c("default", "shiny"))` | Path to the accessible CSS |
| `a11y_css_contents(mode = c("default", "shiny"))` | Contents of the accessible CSS |
| `a11y_wcag_url(criterion)` | WCAG 2.1 specification URL for a success criterion |
| `run_app(...)` | Launch the local accessibility playground |
