# Hex sticker

`logo.svg` is the canonical 600×691 hex sticker (1:1.152 ratio per [hexb.in](http://hexb.in/) standard).

## Generating the PNG variants for CRAN / pkgdown / GitHub

```r
# requires: rsvg, magick
rsvg::rsvg_png("man/figures/logo.svg",
               file = "man/figures/logo.png",
               width = 600, height = 691)

# pkgdown favicon set
pkgdown::build_favicons(overwrite = TRUE)
```

`pkgdown::build_favicons()` reads `man/figures/logo.png` and emits
`pkgdown/favicon/{favicon.ico, apple-touch-icon.png, ...}` automatically.

## Embedding in README

```markdown
<img src="man/figures/logo.png" align="right" height="139" alt="a11yviz hex sticker" />
```

Add `alt=` text — the package teaches accessibility, so the README example
should model it.
