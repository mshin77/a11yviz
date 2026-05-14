test_that("two-arg form title-cases action and appends element", {
  expect_equal(a11y_aria_label("button", "analyze"), "Analyze button")
})

test_that("context is inserted between action and element", {
  expect_equal(
    a11y_aria_label("button", "analyze", "readability"),
    "Analyze readability button"
  )
})

test_that("returns a single character scalar", {
  out <- a11y_aria_label("input", "search")
  expect_type(out, "character")
  expect_length(out, 1)
})
