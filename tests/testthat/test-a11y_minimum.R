.fig <- function(base_size = NULL) {
  skip_if_not_installed("ggplot2")
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(mpg, wt)) + ggplot2::geom_point()
  if (is.null(base_size)) p else p + ggplot2::theme_minimal(base_size = base_size)
}

test_that("alt text is attached when supplied", {
  out <- a11y_minimum(.fig(), alt = "demo")
  expect_equal(attr(out, "a11y_alt"), "demo")
})

test_that("no alt text when alt is NULL", {
  expect_null(attr(a11y_minimum(.fig()), "a11y_alt"))
})

test_that("text size bumps only when below threshold", {
  expect_gte(.extract_base_size(a11y_minimum(.fig(8),  level = "AA")), 12)
  expect_equal(.extract_base_size(a11y_minimum(.fig(16), level = "AA")), 16)
})

test_that("AAA threshold is 14 pt", {
  expect_gte(.extract_base_size(a11y_minimum(.fig(11), level = "AAA")), 14)
})

test_that("rejects non-ggplot/plotly", {
  expect_error(a11y_minimum(list()), "supports ggplot and plotly")
})

test_that("rejects invalid level", {
  expect_error(a11y_minimum(.fig(), level = "A"))
})
