# Python function reference

**Install:** `pip install a11yviz` — [a11yviz on
PyPI](https://pypi.org/project/a11yviz/)

## plotnine transforms

Composable additions to a plotnine chain.

| Function | Description |
|----|----|
| `theme_a11y(level: str = 'AA', base_family: str = 'DejaVu Sans', dark: bool = False)` | Accessible ggplot2 theme |
| `scale_color_a11y(palette=None, level='AA', **kwargs)` | Accessible discrete color and fill scales |
| `scale_fill_a11y(palette=None, level='AA', **kwargs)` | Accessible discrete color and fill scales |
| `scale_color_a11y_div(palette: str = 'rdbu', **kwargs)` | Accessible diverging color and fill scales |
| `scale_fill_a11y_div(palette: str = 'rdbu', **kwargs)` | Accessible diverging color and fill scales |
| `scale_color_a11y_seq(palette: str = 'cividis', **kwargs)` | Accessible sequential continuous color and fill scales |
| `scale_fill_a11y_seq(palette: str = 'cividis', **kwargs)` | Accessible sequential continuous color and fill scales |

## plotly transforms

Layout and styling for plotly figures.

| Function | Description |
|----|----|
| `a11y_layout(p, level: str = 'AA', palette: Optional[str] = 'dark2_8')` | Apply accessible layout to a plotly figure |
| `a11y_plotly(p, level: str = 'AA', palette: Optional[str] = None, alt: Optional[str] = None, strip_title: bool = True)` | Accessible plotly wrapper (Python version of R’s a11y_ggplotly) |

## Alt text

Attach, scaffold, or LLM-draft screen-reader descriptions.

| Function | Description |
|----|----|
| `a11y_alt_text(p, text: str)` | Add alt text to a plot |
| `a11y_alt_template(p) -> str` | Generate a deterministic alt-text template for a plot |
| `a11y_describe(p, backend: Callable[[dict], str], attach: bool = True)` | Generate alt text via a user-supplied LLM backend |

## Palettes

Discrete, diverging, and sequential palettes with WCAG metadata.

| Function | Description |
|----|----|
| `a11y_palette(name: str = 'dark2_8', n: Optional[int] = None, bg: Optional[str] = None) -> list[str]` | Discrete color palette (categorical) |
| `a11y_palette_div(name: str = 'rdbu') -> dict` | Diverging palette |
| `a11y_palette_seq(name: str = 'cividis', n: Optional[int] = None)` | Sequential continuous palette |
| `a11y_palette_info(name: str = 'dark2_8') -> dict` | Discrete palette metadata |
| `a11y_palette_list(type: Optional[str] = None) -> list[dict]` | List available palettes |
| `a11y_show_palette(name: str = 'dark2_8', bg: str = '#ffffff', level: str = 'AA')` | Visualize a palette with WCAG contrast overlay |

## Audits and checks

Multi-criterion figure audit, rubric, and single-aspect checks.

| Function | Description |
|----|----|
| `a11y_audit(p, level: str = 'AA') -> list[dict]` | Chart + document accessibility audit |
| `a11y_audit_chart(p, level: str = 'AA') -> list[dict]` | Chart-only accessibility audit |
| `a11y_audit_doc(level: str = 'AA') -> list[dict]` | Document-level accessibility audit |
| `a11y_audit_actionable(audit: list[dict]) -> list[dict]` | Actionable rows from an audit |
| `a11y_audit_summary(audit: list[dict]) -> str` | One-line summary of an audit |
| `a11y_rubric(level: Optional[str] = None) -> list[dict]` | WCAG 2.1 rubric for the success criteria a11yviz addresses |
| `a11y_check_alt_text(alt_text: Optional[str], element_type: str = 'image', decorative: bool = False, min_length: int = 10) -> bool` | Check alt-text presence and length (WCAG 1.1.1) |
| `a11y_check_headings(path: os.PathLike, min_chars: int = 3) -> list[dict]` | Check Markdown / Quarto / HTML heading hierarchy and labels |
| `a11y_check_overlap(p, bins: int = 100) -> dict` | Scatter overlap check (WCAG Success Criterion 1.3.1) |
| `a11y_check_palette(colors: Sequence[str], bg: Union[str, Iterable[str]] = '#ffffff', level: str = 'AA', alpha: float = 1.0) -> list[dict]` | Check a palette against WCAG contrast thresholds |
| `a11y_check_palette_size(n: int, max: int = 7) -> dict` | Flag categorical palettes above the recommended maximum |
| `a11y_check_readability(text: Union[str, os.PathLike]) -> dict` | Estimate reading level of prose |
| `a11y_check_separability(colors: Sequence[str], min_ratio: float = 3.0) -> list[dict]` | Flag color pairs below the WCAG 2.1 Success Criterion 1.4.11 contrast threshold |
| `a11y_check_tabindex(tabindex: float = 0) -> bool` | Check that a tabindex value follows WCAG 2.1.1 |
| `a11y_plotly_sequences(bg: str = '#ffffff', level: str = 'AA') -> list[dict]` | Audit plotly’s built-in discrete color sequences |

## Shiny and HTML helpers

ARIA labels and live-region announcements for Shiny UI.

| Function | Description |
|----|----|
| `a11y_aria_label(element_type: str, action: str, context: Optional[str] = None) -> str` | Build an ARIA label string |
| `a11y_announce(text: str) -> str` | Announce a status message to assistive technology |

## Wrappers and utilities

One-shot helpers and resource paths.

| Function | Description |
|----|----|
| `make_a11y(p, level: str = 'AA', palette: str = 'dark2_8', alt: Optional[str] = None)` | One-shot accessibility wrapper |
| `a11y_minimum(p, alt: Optional[str] = None, level: str = 'AA')` | Layer minimum accessibility onto a chart |
| `a11y_alpha_presets() -> dict` | Alpha presets for chart layers |
| `a11y_text_spacing_ratios() -> dict` | WCAG 1.4.12 text-spacing ratios (reference data) |
| `a11y_css(mode: str = 'default') -> Union[str, list[str]]` | Path to the accessible CSS |
| `a11y_css_contents(mode: str = 'default') -> str` | Contents of the accessible CSS |
| `a11y_wcag_url(criterion: Union[str, Sequence[str]])` | WCAG 2.1 specification URL for a success criterion |
| `run_app(host: str = '127.0.0.1', port: int = 8000, launch_browser: bool = True) -> None` | Launch the local accessibility playground |
