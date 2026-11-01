# Document-level accessibility audit

Returns the host-page rows from the WCAG 2.1 audit: heading hierarchy,
text resizing, reflow, body text spacing, and visible keyboard focus.

## Usage

``` r
a11y_audit_doc(level = "AA")
```

## Arguments

- level:

  `"AA"` or `"AAA"`. Doc-level rows are identical for both.

## Value

Data frame with columns `criterion`, `check`, `status`, `note`.
