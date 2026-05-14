test_that("make_a11y on plotly attaches alt", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- make_a11y(fig, level = "AA", alt = "Test scatter.")
  expect_s3_class(out, "plotly")
  expect_equal(attr(out, "a11y_alt"), "Test scatter.")
})

test_that("make_a11y on ggplot applies theme + scale + alt", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("palmerpenguins")
  p   <- ggplot2::ggplot(palmerpenguins::penguins,
                         ggplot2::aes(flipper_length_mm, body_mass_g)) +
         ggplot2::geom_point()
  out <- make_a11y(p, level = "AA", palette = "dark2_8", alt = "Penguin scatter.")
  expect_s3_class(out, "ggplot")
  expect_equal(attr(out, "a11y_alt"), "Penguin scatter.")
})

test_that("make_a11y rejects unknown type", {
  expect_error(make_a11y(123, level = "AA"), "ggplot")
})

test_that("make_a11y forwards palette to a11y_layout for plotly", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- make_a11y(fig, level = "AA", palette = "set2_8")
  expect_equal(out$x$layoutAttrs[[1]]$colorway, a11y_palette("set2_8"))
})
