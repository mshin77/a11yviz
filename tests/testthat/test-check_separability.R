test_that("identical colors fail by default", {
  out <- a11y_check_separability(c("#1B9E77", "#1B9E77"))
  expect_equal(out$ratio[1], 1)
  expect_equal(out$status[1], "todo")
})

test_that("widely-spaced colors pass", {
  out <- a11y_check_separability(c("#000000", "#FFFFFF"))
  expect_gt(out$ratio[1], 20)
  expect_equal(out$status[1], "ok")
})

test_that("returns choose(n, 2) pairs", {
  out <- a11y_check_separability(c("#000000", "#FF0000", "#00FF00"))
  expect_equal(nrow(out), 3)
})

test_that("min_ratio configurable", {
  permissive <- a11y_check_separability(c("#666666", "#777777"), min_ratio = 1)
  strict     <- a11y_check_separability(c("#666666", "#777777"), min_ratio = 3)
  expect_equal(permissive$status[1], "ok")
  expect_equal(strict$status[1],     "todo")
})

test_that("default threshold is WCAG Success Criterion 1.4.11 (3:1)", {
  out <- a11y_check_separability(c("#000000", "#888888"))
  expect_gte(out$ratio[1], 3)
  expect_equal(out$status[1], "ok")
})
