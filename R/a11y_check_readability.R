#' Estimate reading level of prose
#'
#' Computes Flesch-Kincaid Grade Level and Flesch Reading Ease for the
#' supplied text. Pure base R with a syllable-count heuristic; no external
#' dependencies. Maps to WCAG 2.1 Success Criterion 3.1.5 (Reading Level, AAA).
#'
#' @param text Character vector, single string, or path to a `.md`, `.qmd`,
#'   `.Rmd`, or `.txt` file.
#' @return Data frame with one row and columns `sentences`, `words`,
#'   `syllables`, `flesch_kincaid_grade`, `flesch_reading_ease`.
#' @export
#' @examples
#' a11y_check_readability("The cat sat on the mat. The dog ran away.")
a11y_check_readability <- function(text) {
  if (length(text) == 1L && nzchar(text) && file.exists(text)) {
    text <- paste(readLines(text, warn = FALSE), collapse = "\n")
  }
  text <- paste(text, collapse = " ")
  text <- gsub("```[\\s\\S]*?```", " ", text, perl = TRUE)
  text <- gsub("`[^`]*`", " ", text)
  text <- gsub("[#*_>~\\[\\]\\(\\)]", " ", text, perl = TRUE)

  sentences <- length(.split_sentences(text))
  words_vec <- .split_words(text)
  words     <- length(words_vec)
  syllables <- sum(vapply(words_vec, .syllable_count, integer(1)))

  if (sentences == 0L || words == 0L) {
    return(data.frame(sentences = sentences, words = words,
                      syllables = syllables,
                      flesch_kincaid_grade = NA_real_,
                      flesch_reading_ease  = NA_real_))
  }

  asl <- words / sentences
  asw <- syllables / words
  fk_grade <- 0.39 * asl + 11.8 * asw - 15.59
  fk_ease  <- 206.835 - 1.015 * asl - 84.6 * asw

  data.frame(
    sentences            = sentences,
    words                = words,
    syllables            = syllables,
    flesch_kincaid_grade = round(fk_grade, 2),
    flesch_reading_ease  = round(fk_ease, 2)
  )
}

.split_sentences <- function(text) {
  s <- strsplit(text, "(?<=[.!?])\\s+", perl = TRUE)[[1]]
  s[nzchar(trimws(s))]
}

.split_words <- function(text) {
  w <- regmatches(text, gregexpr("[A-Za-z']+", text))[[1]]
  tolower(w)
}

.syllable_count <- function(word) {
  if (!nzchar(word)) return(0L)
  word <- tolower(word)
  if (nchar(word) > 2L && grepl("e$", word) && !grepl("le$", word)) {
    word <- sub("e$", "", word)
  }
  groups <- gregexpr("[aeiouy]+", word)[[1]]
  count  <- if (length(groups) == 1L && groups[1] == -1L) 0L else length(groups)
  max(1L, count)
}
