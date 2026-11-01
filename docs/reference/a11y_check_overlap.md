# Scatter overlap check (WCAG Success Criterion 1.3.1)

Bins point coordinates from `geom_point` layers to a `bins` x `bins`
grid in data space and reports the fraction of points that share a cell
with another point. Treat as a render-resolution proxy for Success
Criterion 1.3.1 (information must remain perceivable). When overlap is
non-zero, alpha may be considered, but composited contrast must clear
3:1 per Success Criterion 1.4.11.

## Usage

``` r
a11y_check_overlap(p, bins = 100)
```

## Arguments

- p:

  A `ggplot` object with at least one `geom_point` layer.

- bins:

  Grid resolution per axis (default 100).

## Value

List with `total`, `obscured`, `fraction`, `recommendation`.
