# Python function reference

**Install:** `pip install a11yviz` — [a11yviz on
PyPI](https://pypi.org/project/a11yviz/)

## plotnine transforms

Composable additions to a plotnine chain.

| Function | Description |
|----|----|
| `theme_a11y(level: str = 'AA', base_family: str = 'DejaVu Sans', dark: bool = False)` | Plotnine theme with WCAG contrast settings and recommended font sizes. |
| `scale_color_a11y(palette=None, level='AA', **kwargs)` | Categorical color scale using a WCAG-tagged palette. |
| `scale_fill_a11y(palette=None, level='AA', **kwargs)` | Categorical fill scale using a WCAG-tagged palette. |
| `scale_color_a11y_div(palette: str = 'rdbu', **kwargs)` | Diverging color scale (gradient2). |
| `scale_fill_a11y_div(palette: str = 'rdbu', **kwargs)` | Diverging fill scale (gradient2). |
| `scale_color_a11y_seq(palette: str = 'cividis', **kwargs)` | Sequential continuous color scale (viridis-style). |
| `scale_fill_a11y_seq(palette: str = 'cividis', **kwargs)` | Sequential continuous fill scale (viridis-style). |

## plotly transforms

Layout and styling for plotly figures.

| Function | Description |
|----|----|
| `a11y_layout(p, level: str = 'AA', palette: Optional[str] = 'dark2_8')` | Apply WCAG layout styling to a plotly Figure. |
| `a11y_plotly(p, level: str = 'AA', palette: Optional[str] = None, alt: Optional[str] = None, strip_title: bool = True)` | One-call wrapper applying a11y layout and optional alt text. |

## Alt text

Attach, scaffold, or LLM-draft screen-reader descriptions.

| Function | Description |
|----|----|
| `a11y_alt_text(p, text: str)` | Attach alt text to a figure for screen readers and audits. |
| `a11y_alt_template(p) -> str` | Return a sentence scaffold pre-filled with chart type and axis labels. |
| `a11y_describe(p, backend: Callable[[dict], str], attach: bool = True)` | Call `backend(context)` to draft alt text and optionally attach it. |

## Palettes

Discrete, diverging, and sequential palettes with WCAG metadata.

| Function | Description |
|----|----|
| `a11y_palette(name: str = 'dark2_8', n: Optional[int] = None, bg: Optional[str] = None) -> list[str]` | Return hex codes for a categorical palette. |
| `a11y_palette_div(name: str = 'rdbu') -> dict` | Return low/mid/high anchor colors for a diverging gradient. |
| `a11y_palette_seq(name: str = 'cividis', n: Optional[int] = None)` | Return a viridis-style spec or, with `n`, n sampled hex codes. |
| `a11y_palette_info(name: str = 'dark2_8') -> dict` | Return the full spec for a palette. |
| `a11y_palette_list(type: Optional[str] = None) -> list[dict]` | List discrete, diverging, and sequential palettes; filter by `type` if set. |
| `a11y_show_palette(name: str = 'dark2_8', bg: str = '#ffffff', level: str = 'AA')` | Render a swatch grid with contrast ratios for each palette color. |

## Audits and checks

Multi-criterion figure audit, rubric, and single-aspect checks.

| Function | Description |
|----|----|
| `a11y_audit(p, level: str = 'AA') -> list[dict]` | Return per-criterion status rows (chart + document). |
| `a11y_audit_chart(p, level: str = 'AA') -> list[dict]` | Return chart-relevant audit rows for a plotly Figure or plotnine plot. |
| `a11y_audit_doc(level: str = 'AA') -> list[dict]` | Return host-document audit rows (identical at AA and AAA). |
| `a11y_audit_actionable(audit: list[dict]) -> list[dict]` | Return rows with status ‘todo’ or ‘ok’ – the chart author’s decisions. |
| `a11y_audit_summary(audit: list[dict]) -> str` | Return a one-line count by status. |
| `a11y_rubric(level: Optional[str] = None) -> list[dict]` | Return the chart-relevant WCAG 2.1 rubric, optionally filtered by level. |
| `a11y_check_alt_text(alt_text: Optional[str], element_type: str = 'image', decorative: bool = False, min_length: int = 10) -> bool` | Return True if `alt_text` is valid for `element_type`; warn otherwise. |
| `a11y_check_headings(path: os.PathLike, min_chars: int = 3) -> list[dict]` | Return heading hierarchy and label issues for a Markdown or HTML file. |
| `a11y_check_overlap(p, bins: int = 100) -> dict` | Bin scatter coordinates and report the fraction sharing a grid cell. |
| `a11y_check_palette(colors: Sequence[str], bg: Union[str, Iterable[str]] = '#ffffff', level: str = 'AA', alpha: float = 1.0) -> list[dict]` | Return per-color contrast rows against one or more backgrounds. |
| `a11y_check_palette_size(n: int, max: int = 7) -> dict` | Return a status row for the palette’s category count. |
| `a11y_check_readability(text: Union[str, os.PathLike]) -> dict` | Return sentences, words, syllables, FK grade, and FK reading ease. |
| `a11y_check_separability(colors: Sequence[str], min_ratio: float = 3.0) -> list[dict]` | Return per-pair contrast rows; pairs below `min_ratio` get status ‘todo’. |
| `a11y_check_tabindex(tabindex: float = 0) -> bool` | Return True if `tabindex` is a numeric value \<= 100; warn otherwise. |
| `a11y_plotly_sequences(bg: str = '#ffffff', level: str = 'AA') -> list[dict]` | Return contrast statistics for plotly’s built-in discrete sequences. |

## Shiny and HTML helpers

ARIA labels and live-region announcements for Shiny UI.

| Function | Description |
|----|----|
| `a11y_aria_label(element_type: str, action: str, context: Optional[str] = None) -> str` | Return an ARIA label combining action, optional context, and element type. |
| `a11y_announce(text: str) -> str` |  |

## Wrappers and utilities

One-shot helpers and resource paths.

| Function | Description |
|----|----|
| `make_a11y(p, level: str = 'AA', palette: str = 'dark2_8', alt: Optional[str] = None)` | Apply theme + palettes (plotnine) or layout + palette (plotly) in one call. |
| `a11y_alpha_presets() -> dict` | Return a dict of named alpha presets for chart layers. |
| `a11y_text_spacing_ratios() -> dict` | Return WCAG 1.4.12 text-spacing ratios (multiples of font size). |
| `a11y_css(mode: str = 'default') -> Union[str, list[str]]` |  |
| `a11y_css_contents(mode: str = 'default') -> str` |  |
| `a11y_wcag_url(criterion: Union[str, Sequence[str]])` | Return a spec deep link for one or more success criteria. |
| `run_app(host: str = '127.0.0.1', port: int = 8000, launch_browser: bool = True) -> None` |  |
