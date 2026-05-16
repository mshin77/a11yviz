# Apply accessible layout to a plotly figure

Sets fonts, axis styling, hover-label colors, legend position, and an
accessible categorical `colorway`. Targets WCAG 2.1 contrast (1.4.3,
1.4.6, 1.4.11) and resizability (1.4.4). Font sizes are package
defaults, not WCAG-mandated minimums. Returns the plotly object so it
can stay in a `|>` chain.

## Usage

``` r
a11y_layout(p, level = "AA", palette = "dark2_8")
```

## Arguments

- p:

  A plotly object (from
  [`plotly::plot_ly`](https://rdrr.io/pkg/plotly/man/plot_ly.html) or
  [`plotly::ggplotly`](https://rdrr.io/pkg/plotly/man/ggplotly.html)).

- level:

  `"AA"` or `"AAA"`.

- palette:

  Discrete palette name applied as plotly's `colorway`. See
  [`a11y_palette_list()`](https://mshin77.github.io/a11yviz/reference/a11y_palette_list.md).
  Pass `NULL` to leave plotly's default colors unchanged.

## Value

Modified plotly object.
