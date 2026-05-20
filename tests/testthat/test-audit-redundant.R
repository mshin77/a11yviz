test_that("redundant encoding via geom_text label is detected", {
  skip_if_not_installed("ggplot2")
  library(ggplot2)
  df <- data.frame(x = 1:3, y = 1:3, g = c("a", "b", "c"))
  baseline <- ggplot(df, aes(x, y, color = g)) + geom_point()
  labeled  <- baseline + geom_text(aes(label = g))
  shaped   <- ggplot(df, aes(x, y, color = g, shape = g)) + geom_point()

  r_base  <- a11y_audit_chart(baseline)
  r_lab   <- a11y_audit_chart(labeled)
  r_shape <- a11y_audit_chart(shaped)

  row <- function(r) r[r$check == "Redundant group encoding", ]
  expect_equal(row(r_base)$status,  "todo")
  expect_equal(row(r_lab)$status,   "ok")
  expect_match(row(r_lab)$note,     "direct text labels")
  expect_equal(row(r_shape)$status, "ok")
  expect_match(row(r_shape)$note,   "shape or linetype")
})
