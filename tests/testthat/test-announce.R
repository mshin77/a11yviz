test_that("wraps text in screen-reader-only span with aria-live polite", {
  out <- a11y_announce("Loading")
  expect_true(grepl('class="screen-reader-only"', out, fixed = TRUE))
  expect_true(grepl('role="status"',           out, fixed = TRUE))
  expect_true(grepl('aria-live="polite"',      out, fixed = TRUE))
  expect_true(grepl(">Loading<",               out, fixed = TRUE))
})

test_that("returns a single character scalar", {
  out <- a11y_announce("hi")
  expect_type(out, "character")
  expect_length(out, 1)
})
