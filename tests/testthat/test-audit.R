test_that("audit fails alt by default for empty plotly figure", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly()
  rows <- a11y_audit(fig)
  alt_row <- rows[rows$check == "Alt text on figure", ]
  expect_equal(alt_row$status[1], "todo")
})

test_that("audit marks alt partial after a11y_alt_text", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly()
  fig <- a11y_alt_text(fig, "An empty figure used in tests.")
  rows <- a11y_audit(fig)
  alt_row <- rows[rows$check == "Alt text on figure", ]
  expect_equal(alt_row$status[1], "partial")
  expect_match(alt_row$note[1], "renderer")
})

test_that("AA returns 11 rows; AAA adds one", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly()
  expect_equal(nrow(a11y_audit(fig, level = "AA")),  11)
  expect_equal(nrow(a11y_audit(fig, level = "AAA")), 12)
})

test_that("audit columns are criterion / check / status / note", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly()
  expect_named(a11y_audit(fig), c("criterion", "check", "status", "note"))
})

test_that("criterion numbers match WCAG SCs", {
  skip_if_not_installed("plotly")
  fig <- plotly::plot_ly()
  expected_aa <- c("1.1.1", "1.3.1", "1.4.1", "1.4.3", "1.4.4",
                   "1.4.10", "1.4.11", "1.4.12", "1.4.13", "2.4.7")
  expect_setequal(a11y_audit(fig, level = "AA")$criterion,  expected_aa)
  expect_setequal(a11y_audit(fig, level = "AAA")$criterion, c(expected_aa, "1.4.6"))
})
