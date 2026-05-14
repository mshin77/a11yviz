test_that("zero (natural order) is valid", {
  expect_true(a11y_check_tabindex(0))
})

test_that("negative one (focusable, skipped) is valid", {
  expect_true(a11y_check_tabindex(-1))
})

test_that("non-numeric warns and returns FALSE", {
  expect_warning(out <- a11y_check_tabindex("a"))
  expect_false(out)
})

test_that("> 100 warns and returns FALSE per WCAG 2.1.1", {
  expect_warning(out <- a11y_check_tabindex(999), "WCAG 2.1.1")
  expect_false(out)
})
