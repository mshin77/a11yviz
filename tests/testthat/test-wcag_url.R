test_that("known SC returns deep link", {
  expect_equal(a11y_wcag_url("1.4.3"),
               "https://www.w3.org/TR/WCAG21/#contrast-minimum")
})

test_that("unknown SC returns spec root", {
  expect_equal(a11y_wcag_url("9.9.9"),
               "https://www.w3.org/TR/WCAG21/")
})

test_that("all rubric SCs resolve to anchor URLs", {
  urls <- a11y_wcag_url(a11y_rubric()$criterion)
  expect_true(all(grepl("#", urls, fixed = TRUE)))
})
