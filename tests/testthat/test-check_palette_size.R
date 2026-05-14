test_that("ok when n is within max", {
  expect_equal(a11y_check_palette_size(5)$status, "ok")
})

test_that("todo when n exceeds max", {
  expect_equal(a11y_check_palette_size(12)$status, "todo")
})

test_that("custom max threshold honoured", {
  expect_equal(a11y_check_palette_size(8, max = 10)$status, "ok")
})
