test_that("adequate alt text passes", {
  expect_true(a11y_check_alt_text("Bar chart of word frequency", "plot"))
})

test_that("empty alt text warns and fails (WCAG 1.1.1)", {
  expect_warning(out <- a11y_check_alt_text("", "plot"), "WCAG 1.1.1")
  expect_false(out)
})

test_that("NULL alt text warns and fails", {
  expect_warning(out <- a11y_check_alt_text(NULL, "image"))
  expect_false(out)
})

test_that("alt text under min_length warns and fails", {
  expect_warning(out <- a11y_check_alt_text("short", "image"), "too short")
  expect_false(out)
})

test_that("decorative element with empty alt passes", {
  expect_true(a11y_check_alt_text("", "icon", decorative = TRUE))
})

test_that("min_length is configurable", {
  expect_true(a11y_check_alt_text("abc", "image", min_length = 3))
})
