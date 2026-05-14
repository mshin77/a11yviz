test_that("black on white passes AA and AAA", {
  rows <- a11y_check_palette("#000000", bg = "#ffffff", level = "AA")
  expect_equal(rows$status[1], "ok")
  expect_gt(rows$ratio[1], 20)
})

test_that("light gray on white fails AA", {
  rows <- a11y_check_palette("#cccccc", bg = "#ffffff", level = "AA")
  expect_equal(rows$status[1], "todo")
})

test_that("AAA threshold rejects AA-only colors", {
  rows <- a11y_check_palette("#0072B2", bg = "#ffffff", level = "AAA")
  expect_equal(rows$status[1], "todo")
})

test_that("returns one row per color with expected columns", {
  rows <- a11y_check_palette(c("#000000", "#ffffff", "#888888"))
  expect_equal(nrow(rows), 3)
  expect_named(rows, c("color", "bg", "alpha", "rendered", "ratio", "status"))
})

test_that("AA-large uses 3:1 threshold", {
  rows_large <- a11y_check_palette("#888888", bg = "#ffffff", level = "AA-large")
  expect_equal(rows_large$status[1], "ok")
  rows_aa    <- a11y_check_palette("#888888", bg = "#ffffff", level = "AA")
  expect_equal(rows_aa$status[1], "todo")
})

test_that("alpha = 1 leaves color unchanged", {
  rows <- a11y_check_palette("#000000", bg = "#ffffff", alpha = 1)
  expect_equal(tolower(rows$rendered[1]), "#000000")
  expect_equal(rows$alpha[1], 1)
})

test_that("alpha < 1 composites toward bg", {
  rows <- a11y_check_palette("#000000", bg = "#ffffff", alpha = 0.5)
  expect_true(tolower(rows$rendered[1]) %in% c("#808080", "#7f7f7f"))
})

test_that("alpha lowers contrast against white", {
  full  <- a11y_check_palette("#0072B2", bg = "#ffffff", alpha = 1)$ratio[1]
  faded <- a11y_check_palette("#0072B2", bg = "#ffffff", alpha = 0.4)$ratio[1]
  expect_lt(faded, full)
})

test_that("vector bg returns cross product", {
  rows <- a11y_check_palette(c("#000000", "#ff0000"), bg = c("#ffffff", "#1a1a1a"))
  expect_equal(nrow(rows), 4)
  expect_setequal(rows$bg, c("#ffffff", "#1a1a1a"))
})

test_that("vector bg dual background check", {
  rows <- a11y_check_palette("#0072B2", bg = c("#ffffff", "#1a1a1a"), level = "AA-large")
  expect_equal(nrow(rows), 2)
  expect_true(all(rows$status == "ok"))
})
