test_that("theme_a11y returns a ggplot theme", {
  skip_if_not_installed("ggplot2")
  th <- theme_a11y(level = "AA")
  expect_s3_class(th, "theme")
})

test_that("theme_a11y AAA bumps base size from 12 to 14 pt", {
  skip_if_not_installed("ggplot2")
  th_aa  <- theme_a11y(level = "AA")
  th_aaa <- theme_a11y(level = "AAA")
  expect_equal(th_aa$text$size,  12)
  expect_equal(th_aaa$text$size, 14)
})

test_that("theme_a11y dark mode swaps fg / bg", {
  skip_if_not_installed("ggplot2")
  light <- theme_a11y(dark = FALSE)
  dark  <- theme_a11y(dark = TRUE)
  expect_equal(light$text$colour,             "#222222")
  expect_equal(dark$text$colour,              "#dee2e6")
  expect_equal(light$panel.background$fill,   "#ffffff")
  expect_equal(dark$panel.background$fill,    "#2d2d2d")
})

test_that("theme_a11y rejects invalid level", {
  expect_error(theme_a11y(level = "A"), "AA")
})
