#' WCAG 2.1 specification URL for a success criterion
#'
#' Returns a deep link to the W3C WCAG 2.1 specification entry for one or
#' more success criteria.
#'
#' @param criterion Character vector of success-criterion numbers (e.g.,
#'   `"1.4.3"`). Recognised values are the chart-relevant subset returned
#'   by [a11y_rubric()].
#' @return Character vector of URLs the same length as `criterion`. Returns
#'   the spec root URL for unrecognised values.
#' @export
#' @examples
#' a11y_wcag_url("1.4.3")
#' a11y_wcag_url(c("1.1.1", "2.4.7", "4.1.3"))
a11y_wcag_url <- function(criterion) {
  base <- "https://www.w3.org/TR/WCAG21/"
  slug <- .wcag_slug(criterion)
  ifelse(is.na(slug), base, paste0(base, "#", slug))
}

.wcag_slug <- function(criterion) {
  map <- c(
    "1.1.1"  = "non-text-content",
    "1.3.1"  = "info-and-relationships",
    "1.4.1"  = "use-of-color",
    "1.4.3"  = "contrast-minimum",
    "1.4.4"  = "resize-text",
    "1.4.6"  = "contrast-enhanced",  # W3C-set fragment id; do not rename

    "1.4.10" = "reflow",
    "1.4.11" = "non-text-contrast",
    "1.4.12" = "text-spacing",
    "1.4.13" = "content-on-hover-or-focus",
    "2.4.6"  = "headings-and-labels",
    "2.4.7"  = "focus-visible",
    "2.4.10" = "section-headings",
    "3.1.5"  = "reading-level",
    "4.1.3"  = "status-messages"
  )
  unname(map[criterion])
}
