test_that("default returns base CSS path", {
  out <- a11y_css()
  expect_type(out, "character")
  expect_length(out, 1)
  expect_true(file.exists(out))
  expect_match(out, "a11yviz\\.css$")
})

test_that("shiny mode returns base + shiny add-on in order", {
  out <- a11y_css("shiny")
  expect_length(out, 2)
  expect_true(all(file.exists(out)))
  expect_match(out[1], "a11yviz\\.css$")
  expect_match(out[2], "a11yviz-shiny\\.css$")
})

test_that("shiny add-on contains skip-link and motion query", {
  css <- readLines(a11y_css("shiny")[2], warn = FALSE)
  expect_true(any(grepl("\\.skip-link", css)))
  expect_true(any(grepl("prefers-reduced-motion", css)))
  expect_true(any(grepl("prefers-contrast", css)))
  expect_true(any(grepl("\\.screen-reader-only", css)))
})

test_that("invalid mode errors", {
  expect_error(a11y_css("bogus"))
})
