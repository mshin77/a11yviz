test_that("a11y_layout returns a plotly object", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- a11y_layout(fig, level = "AA")
  expect_s3_class(out, "plotly")
})

test_that("a11y_layout sets transparent paper", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- a11y_layout(fig)
  attrs <- out$x$layoutAttrs[[1]]
  expect_equal(attrs$paper_bgcolor, "rgba(0,0,0,0)")
  expect_equal(attrs$plot_bgcolor,  "rgba(0,0,0,0)")
})

test_that("a11y_layout applies palette colorway", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- a11y_layout(fig, palette = "dark2_8")
  expect_equal(out$x$layoutAttrs[[1]]$colorway, a11y_palette("dark2_8"))
})

test_that("a11y_layout palette = NULL leaves colorway unset", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly(x = 1:3, y = 4:6, type = "scatter", mode = "markers")
  out <- a11y_layout(fig, palette = NULL)
  expect_null(out$x$layoutAttrs[[1]]$colorway)
})
