#' Generate alt text via a user-supplied LLM backend
#'
#' Extracts deterministic plot context (chart type, axes, ranges, group
#' counts) and passes it to the user's `backend` function, which calls any
#' LLM provider and returns the alt-text string. Result is attached to the
#' plot via [a11y_alt_text()] when `attach = TRUE`.
#'
#' The package itself depends on no LLM SDK; the caller supplies the
#' transport. See examples for OpenAI, Gemini, and Ollama backends.
#'
#' @param p A `ggplot` or `plotly` object.
#' @param backend A function `function(context) -> character(1)`. Receives a
#'   list with fields `chart_type`, `title`, `x`, `y`, `color`,
#'   `n_observations`. Returns a single string.
#' @param attach If `TRUE` (default), attach via `a11y_alt_text()`.
#'   Otherwise return the string.
#' @return The plot with alt text attached, or the string itself.
#' @export
#' @examples
#' \dontrun{
#'   openai_backend <- function(context) {
#'     prompt <- paste(
#'       "Write one-sentence WCAG 1.1.1 alt text.",
#'       "State chart type, axes, and key trend."
#'     )
#'     auth <- paste("Bearer", Sys.getenv("OPENAI_API_KEY"))
#'     res <- httr::POST(
#'       "https://api.openai.com/v1/chat/completions",
#'       httr::add_headers(Authorization = auth),
#'       body = list(
#'         model = "gpt-4o-mini",
#'         messages = list(
#'           list(role = "system", content = prompt),
#'           list(role = "user",
#'                content = jsonlite::toJSON(context, auto_unbox = TRUE))
#'         )
#'       ),
#'       encode = "json"
#'     )
#'     httr::content(res)$choices[[1]]$message$content
#'   }
#'   p |> a11y_describe(backend = openai_backend)
#' }
a11y_describe <- function(p, backend, attach = TRUE) {
  context <- .plot_context(p)
  text    <- backend(context)
  if (attach) a11y_alt_text(p, text) else text
}

.plot_context <- function(p) {
  if (inherits(p, "ggplot")) return(.context_ggplot(p))
  if (inherits(p, "plotly")) return(.context_plotly(p))
  stop("a11y_describe() supports ggplot and plotly objects.", call. = FALSE)
}

.context_ggplot <- function(p) {
  .require_pkg("ggplot2", "a11y_describe")
  geoms <- unique(vapply(p$layers, function(l) class(l$geom)[1], character(1)))
  d     <- p$data
  x_var <- .aes_var(p, "x")
  y_var <- .aes_var(p, "y")
  c_var <- .aes_var(p, "colour") %||% .aes_var(p, "fill")

  list(
    chart_type     = .geom_phrase(geoms),
    title          = p$labels$title,
    x              = .axis_context(p, "x", d, x_var),
    y              = .axis_context(p, "y", d, y_var),
    color          = .group_context(p, c_var, d),
    n_observations = if (is.data.frame(d)) nrow(d) else NA_integer_,
    facet          = .facet_context(p)
  )
}

.context_plotly <- function(p) {
  .require_pkg("plotly", "a11y_describe")
  attrs  <- p$x$attrs %||% list()
  layout <- p$x$layout %||% list()
  trace_types <- vapply(attrs, function(a) {
    t <- a$type %||% "scatter"
    if (t == "scatter" && !is.null(a$mode)) paste0("scatter:", a$mode) else t
  }, character(1))
  list(
    chart_type     = if (length(trace_types)) .plotly_phrase(trace_types[1]) else "Plot",
    title          = .layout_axis_title(layout$title) %||% layout$title,
    x              = list(label = .layout_axis_title(layout$xaxis) %||% "x"),
    y              = list(label = .layout_axis_title(layout$yaxis) %||% "y"),
    n_traces       = length(attrs)
  )
}

.axis_context <- function(p, aes_name, d, var) {
  list(
    label = p$labels[[aes_name]] %||% .aes_label(p, aes_name) %||% aes_name,
    variable = var,
    range = .num_range(d, var)
  )
}

.group_context <- function(p, var, d) {
  if (is.null(var)) return(NULL)
  list(
    label    = p$labels$colour %||% p$labels$fill %||% var,
    variable = var,
    levels   = .group_levels(d, var)
  )
}

.facet_context <- function(p) {
  if (inherits(p$facet, "FacetNull")) return(NULL)
  fvars <- names(c(p$facet$params$facets, p$facet$params$rows, p$facet$params$cols))
  if (!length(fvars)) NULL else fvars
}
