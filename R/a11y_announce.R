#' Announce a status message to assistive technology
#'
#' Pair with a CSS rule that defines `.screen-reader-only` (see [a11y_css()]).
#'
#' @param text Character. Message to announce.
#' @return Character scalar containing HTML.
#' @seealso [a11y_css()]
#' @export
#' @examples
#' a11y_announce("Loading results, please wait")
a11y_announce <- function(text) {
  paste0(
    '<span class="screen-reader-only" role="status" aria-live="polite">',
    text,
    '</span>'
  )
}
