#' Check Markdown / Quarto / HTML heading hierarchy and labels
#'
#' Scans a file for three heading defects:
#' (a) skipped heading levels (e.g., `##` followed by `####`),
#' (b) empty headings,
#' (c) non-descriptive headings (text shorter than `min_chars`).
#' These violate WCAG 2.1 Success Criteria 1.3.1 (Info and Relationships),
#' 2.4.6 (Headings and Labels), and 2.4.10 (Section Headings).
#'
#' @param path Path to a `.md`, `.qmd`, `.Rmd`, or `.html` file.
#' @param min_chars Minimum heading text length (after trimming) considered
#'   descriptive. Default `3`.
#' @return Data frame with one row per issue, columns `line`, `level`,
#'   `text`, `issue`. Empty data frame if no issues.
#' @export
#' @examples
#' \dontrun{
#'   a11y_check_headings("paper.qmd")
#' }
a11y_check_headings <- function(path, min_chars = 3) {
  if (!file.exists(path)) stop("File not found: ", path, call. = FALSE)
  ext      <- tolower(tools::file_ext(path))
  headings <- if (ext == "html") .parse_headings_html(path) else .parse_headings_md(path)
  if (!nrow(headings)) return(.empty_heading_issues())

  rows <- list(
    .heading_skip_rows(headings),
    .heading_empty_rows(headings),
    .heading_short_rows(headings, min_chars)
  )
  out <- do.call(rbind, rows)
  if (is.null(out) || !nrow(out)) return(.empty_heading_issues())
  out[order(out$line), , drop = FALSE]
}

.heading_skip_rows <- function(h) {
  diffs    <- diff(h$level)
  skip_idx <- which(diffs > 1) + 1L
  if (!length(skip_idx)) return(NULL)
  data.frame(
    line  = h$line[skip_idx],
    level = h$level[skip_idx],
    text  = h$text[skip_idx],
    issue = sprintf("Level skip from h%d to h%d",
                    h$level[skip_idx - 1L], h$level[skip_idx]),
    stringsAsFactors = FALSE
  )
}

.heading_empty_rows <- function(h) {
  empty_idx <- which(!nzchar(trimws(h$text)))
  if (!length(empty_idx)) return(NULL)
  data.frame(
    line  = h$line[empty_idx],
    level = h$level[empty_idx],
    text  = h$text[empty_idx],
    issue = "Empty heading",
    stringsAsFactors = FALSE
  )
}

.heading_short_rows <- function(h, min_chars) {
  trimmed   <- trimws(h$text)
  short_idx <- which(nzchar(trimmed) & nchar(trimmed) < min_chars)
  if (!length(short_idx)) return(NULL)
  data.frame(
    line  = h$line[short_idx],
    level = h$level[short_idx],
    text  = h$text[short_idx],
    issue = sprintf("Heading text under %d chars (likely non-descriptive)", min_chars),
    stringsAsFactors = FALSE
  )
}

.empty_heading_issues <- function() {
  data.frame(line = integer(0), level = integer(0),
             text = character(0), issue = character(0),
             stringsAsFactors = FALSE)
}

.parse_headings_md <- function(path) {
  lines       <- readLines(path, warn = FALSE)
  in_yaml     <- .yaml_frontmatter_mask(lines)
  fence_lines <- grepl("^```", lines) & !in_yaml
  fence_state <- as.logical(cumsum(fence_lines) %% 2)
  in_fence    <- fence_state | fence_lines

  is_h <- grepl("^#{1,6}(\\s|$)", lines) & !in_fence & !in_yaml
  if (!any(is_h)) return(.empty_heading_issues()[, c("line", "level", "text")])

  hl <- lines[is_h]
  data.frame(
    line  = which(is_h),
    level = nchar(sub("^(#{1,6}).*$", "\\1", hl)),
    text  = trimws(sub("^#{1,6}\\s*", "", hl)),
    stringsAsFactors = FALSE
  )
}

.yaml_frontmatter_mask <- function(lines) {
  mask <- logical(length(lines))
  if (length(lines) < 2L || lines[1] != "---") return(mask)
  close <- which(lines[-1] == "---")[1]
  if (is.na(close)) return(mask)
  mask[seq_len(close + 1L)] <- TRUE
  mask
}

.parse_headings_html <- function(path) {
  raw     <- paste(readLines(path, warn = FALSE), collapse = "\n")
  pattern <- "<h([1-6])[^>]*>(.*?)</h\\1>"
  m       <- gregexpr(pattern, raw, ignore.case = TRUE, perl = TRUE)[[1]]
  if (m[1] == -1L) return(.empty_heading_issues()[, c("line", "level", "text")])

  matches <- regmatches(raw, list(m))[[1]]
  starts  <- as.integer(m)
  nl_pos  <- gregexpr("\n", raw, fixed = TRUE)[[1]]
  nl_pos  <- if (nl_pos[1] == -1L) integer(0) else as.integer(nl_pos)
  newlines_before <- vapply(starts, function(s) sum(nl_pos < s), integer(1))

  level <- as.integer(sub(".*<h([1-6]).*", "\\1", matches, ignore.case = TRUE))
  body  <- sub(pattern, "\\2", matches, ignore.case = TRUE, perl = TRUE)
  body  <- trimws(gsub("<[^>]+>", "", body))

  data.frame(
    line  = newlines_before + 1L,
    level = level,
    text  = body,
    stringsAsFactors = FALSE
  )
}
