test_that("a11y_text_size scales with WCAG level", {
  skip_if_not_installed("ggplot2")
  expect_lt(a11y_text_size("AA"), a11y_text_size("AAA"))
})

test_that("a11y_text_size rejects invalid level", {
  expect_error(a11y_text_size("A"), "AA")
})

test_that("a11y_contrast_text picks dark on light fill, light on dark fill", {
  out <- a11y_contrast_text(c("#ffffff", "#000000"))
  expect_equal(out[1], "#222222")
  expect_equal(out[2], "#ffffff")
})

test_that("a11y_contrast_text AAA enforces 7:1", {
  mid <- "#a0a0a0"
  expect_equal(a11y_contrast_text(mid, level = "AA"),  "#222222")
  expect_equal(a11y_contrast_text(mid, level = "AAA"), "#ffffff")
})
