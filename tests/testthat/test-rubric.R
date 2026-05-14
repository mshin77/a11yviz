test_that("rubric returns 15 success criteria by default", {
  rb <- a11y_rubric()
  expect_equal(nrow(rb), 15)
  expect_setequal(rb$criterion, c("1.1.1", "1.3.1", "1.4.1", "1.4.3", "1.4.4",
                                  "1.4.6", "1.4.10", "1.4.11", "1.4.12", "1.4.13",
                                  "2.4.6", "2.4.7", "2.4.10", "3.1.5", "4.1.3"))
})

test_that("AA filter drops AAA-only rows", {
  rb <- a11y_rubric(level = "AA")
  expect_false("AAA" %in% rb$level)
})

test_that("AAA filter keeps all rows", {
  expect_equal(nrow(a11y_rubric(level = "AAA")), 15)
})

test_that("rubric has expected columns", {
  expect_named(a11y_rubric(),
               c("criterion", "name", "level", "threshold_aa",
                 "threshold_aaa", "a11yviz_function"))
})
