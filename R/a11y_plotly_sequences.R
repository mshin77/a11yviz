#' Audit plotly's built-in discrete color sequences
#'
#' Plotly ships several discrete categorical sequences (from plotly.js).
#' This helper computes WCAG contrast statistics for each one against a
#' reference background so users can pick a sequence that passes their
#' contrast bar.
#'
#' @param bg Reference background hex (default `"#ffffff"`).
#' @param level `"AA"` (4.5:1) or `"AAA"` (7:1).
#' @return Data frame with one row per sequence: `name`, `n`,
#'   `min_ratio`, `median_ratio`, `n_pass`, `pct_pass`.
#' @export
#' @examples
#' a11y_plotly_sequences()
#' a11y_plotly_sequences(level = "AAA")
a11y_plotly_sequences <- function(bg = "#ffffff", level = "AA") {
  level <- .check_level(level)
  threshold <- if (level == "AA") 4.5 else 7
  seqs <- list(
    Plotly  = c("#636EFA","#EF553B","#00CC96","#AB63FA","#FFA15A",
                "#19D3F3","#FF6692","#B6E880","#FF97FF","#FECB52"),
    D3      = c("#1F77B4","#FF7F0E","#2CA02C","#D62728","#9467BD",
                "#8C564B","#E377C2","#7F7F7F","#BCBD22","#17BECF"),
    G10     = c("#3366CC","#DC3912","#FF9900","#109618","#990099",
                "#0099C6","#DD4477","#66AA00","#B82E2E","#316395"),
    T10     = c("#4C78A8","#F58518","#E45756","#72B7B2","#54A24B",
                "#EECA3B","#B279A2","#FF9DA6","#9D755D","#BAB0AC"),
    Vivid   = c("#E58606","#5D69B1","#52BCA3","#99C945","#CC61B0",
                "#24796C","#DAA51B","#2F8AC4","#764E9F","#ED645A","#CC3A8E","#A5AA99"),
    Bold    = c("#7F3C8D","#11A579","#3969AC","#F2B701","#E73F74",
                "#80BA5A","#E68310","#008695","#CF1C90","#F97B72","#4B4B8F","#A5AA99"),
    Pastel  = c("#66C5CC","#F6CF71","#F89C74","#DCB0F2","#87C55F",
                "#9EB9F3","#FE88B1","#C9DB74","#8BE0A4","#B497E7","#D3B484","#B3B3B3")
  )

  rows <- lapply(names(seqs), function(nm) {
    cols   <- seqs[[nm]]
    ratios <- vapply(cols, function(c) .contrast_ratio(c, bg), numeric(1))
    n_pass <- sum(ratios >= threshold)
    data.frame(
      name         = nm,
      n            = length(cols),
      min_ratio    = round(min(ratios), 2),
      median_ratio = round(stats::median(ratios), 2),
      n_pass       = n_pass,
      pct_pass     = round(100 * n_pass / length(cols), 1),
      stringsAsFactors = FALSE
    )
  })
  out <- do.call(rbind, rows)
  out[order(-out$pct_pass), , drop = FALSE]
}
