#' Generate a deterministic alt-text template for a plot
#'
#' Introspects a `ggplot` or `plotly` object and emits a sentence scaffold
#' with chart type, axis labels, ranges, and group counts pre-filled. A
#' bracketed placeholder marks where the substantive trend description
#' belongs. Pass the edited string to [a11y_alt_text()] to attach it.
#'
#' @param p A `ggplot` or `plotly` object.
#' @return Character scalar.
#' @export
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   p <- ggplot(mtcars, aes(wt, mpg, color = factor(cyl))) + geom_point()
#'   a11y_alt_template(p)
#' }
a11y_alt_template <- function(p) {
  if (inherits(p, "ggplot")) return(.alt_template_ggplot(p))
  if (inherits(p, "plotly")) return(.alt_template_plotly(p))
  stop("a11y_alt_template() supports ggplot and plotly objects.", call. = FALSE)
}

.alt_template_ggplot <- function(p) {
  .require_pkg("ggplot2", "a11y_alt_template")

  geoms <- unique(vapply(p$layers, function(l) class(l$geom)[1], character(1)))
  chart_type <- .geom_phrase(geoms)

  x_lab <- p$labels$x %||% .aes_label(p, "x") %||% "x"
  y_lab <- p$labels$y %||% .aes_label(p, "y") %||% "y"
  c_lab <- p$labels$colour %||% p$labels$fill %||%
           .aes_label(p, "colour") %||% .aes_label(p, "fill")

  d     <- p$data
  x_var <- .aes_var(p, "x")
  y_var <- .aes_var(p, "y")
  c_var <- .aes_var(p, "colour") %||% .aes_var(p, "fill")

  n      <- if (is.data.frame(d)) nrow(d) else NA_integer_
  x_rng  <- .num_range(d, x_var)
  y_rng  <- .num_range(d, y_var)
  groups <- .group_levels(d, c_var)

  parts <- sprintf("%s of %s versus %s", chart_type, y_lab, x_lab)
  if (!is.na(n)) parts <- paste0(parts, sprintf(", %d data points", n))
  parts <- paste0(parts, ".")

  title <- p$labels$title
  if (!is.null(title) && nzchar(title))
    parts <- c(paste0(trimws(title), "."), parts)

  x_trans <- .scale_transform(p, "x")
  y_trans <- .scale_transform(p, "y")

  if (!is.null(x_rng))
    parts <- c(parts, sprintf("X axis: %s, range %s to %s%s.",
                              x_lab, x_rng[1], x_rng[2],
                              if (nzchar(x_trans)) paste0(" (", x_trans, "-transformed)") else ""))
  if (!is.null(y_rng))
    parts <- c(parts, sprintf("Y axis: %s, range %s to %s%s.",
                              y_lab, y_rng[1], y_rng[2],
                              if (nzchar(y_trans)) paste0(" (", y_trans, "-transformed)") else ""))
  if (!is.null(groups) && length(groups) > 0)
    parts <- c(parts, sprintf("Colored by %s (%d groups: %s).",
                              c_lab %||% c_var, length(groups),
                              paste(utils::head(groups, 5), collapse = ", ")))

  if (!inherits(p$facet, "FacetNull")) {
    fvars <- names(c(p$facet$params$facets, p$facet$params$rows, p$facet$params$cols))
    if (length(fvars))
      parts <- c(parts, sprintf("Faceted by %s.", paste(fvars, collapse = ", ")))
  }

  parts <- c(parts,
             "[REPLACE - describe the substantive trend, e.g., direction, clusters, outliers.]")
  paste(parts, collapse = " ")
}

.alt_template_plotly <- function(p) {
  .require_pkg("plotly", "a11y_alt_template")

  attrs  <- p$x$attrs %||% list()
  layout <- p$x$layout %||% list()

  trace_types <- vapply(attrs, function(a) {
    t <- a$type %||% "scatter"
    if (t == "scatter" && !is.null(a$mode)) paste0("scatter:", a$mode) else t
  }, character(1))
  chart_type <- if (length(trace_types)) .plotly_phrase(trace_types[1]) else "Plot"

  x_lab <- .layout_axis_title(layout$xaxis) %||% "x"
  y_lab <- .layout_axis_title(layout$yaxis) %||% "y"

  parts <- sprintf("%s of %s versus %s.", chart_type, y_lab, x_lab)
  if (length(attrs) > 1)
    parts <- c(parts, sprintf("%d traces.", length(attrs)))
  parts <- c(parts,
             "[REPLACE - describe the substantive trend.]")
  paste(parts, collapse = " ")
}

.geom_phrase <- function(geoms) {
  if (length(geoms) > 1) return("Composite plot")
  if (length(geoms) == 0) return("Plot")
  switch(geoms,
    GeomPoint      = "Scatter plot",
    GeomLine       = "Line plot",
    GeomPath       = "Line plot",
    GeomStep       = "Step plot",
    GeomBar        = "Bar chart",
    GeomCol        = "Bar chart",
    GeomTile       = "Heatmap",
    GeomRaster     = "Heatmap",
    GeomBoxplot    = "Boxplot",
    GeomViolin     = "Violin plot",
    GeomHistogram  = "Histogram",
    GeomDensity    = "Density plot",
    GeomPointrange = "Coefficient plot with intervals",
    GeomLinerange  = "Range plot",
    GeomErrorbar   = "Range plot",
    GeomSmooth     = "Smoothed trend plot",
    GeomArea       = "Area plot",
    GeomRibbon     = "Ribbon plot",
    "Plot"
  )
}

.plotly_phrase <- function(t) {
  switch(t,
    "scatter"               = "Scatter plot",
    "scatter:markers"       = "Scatter plot",
    "scatter:lines"         = "Line plot",
    "scatter:lines+markers" = "Line plot with markers",
    "bar"                   = "Bar chart",
    "heatmap"               = "Heatmap",
    "contour"               = "Contour plot",
    "box"                   = "Boxplot",
    "violin"                = "Violin plot",
    "histogram"             = "Histogram",
    "surface"               = "3-D surface plot",
    "Plot"
  )
}

.aes_label <- function(p, aes_name) {
  q <- p$mapping[[aes_name]]
  if (is.null(q)) return(NULL)
  rlang::as_label(q)
}

.aes_var <- function(p, aes_name) {
  q <- p$mapping[[aes_name]]
  if (is.null(q)) return(NULL)
  vars <- all.vars(rlang::quo_get_expr(q))
  if (length(vars)) vars[1] else NULL
}

.num_range <- function(d, var) {
  if (is.null(d) || is.null(var) || !var %in% names(d)) return(NULL)
  v <- d[[var]]
  if (!is.numeric(v)) return(NULL)
  rng <- range(v, na.rm = TRUE)
  if (any(!is.finite(rng))) return(NULL)
  formatC(rng, digits = 3, format = "fg")
}

.group_levels <- function(d, var) {
  if (is.null(d) || is.null(var) || !var %in% names(d)) return(NULL)
  levs <- unique(d[[var]])
  as.character(levs[!is.na(levs)])
}

.layout_axis_title <- function(ax) {
  if (is.null(ax)) return(NULL)
  if (is.list(ax$title)) return(ax$title$text)
  ax$title
}

.scale_transform <- function(p, axis) {
  sc <- tryCatch(p$scales$get_scales(axis), error = function(e) NULL)
  if (is.null(sc)) return("")
  nm <- tryCatch(sc$trans$name, error = function(e) NULL)
  if (is.null(nm) || identical(nm, "identity")) "" else as.character(nm)
}
