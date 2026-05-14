test_that("dark2_8 returns 8 RColorBrewer Dark2 colors", {
  cols <- a11y_palette("dark2_8")
  expect_length(cols, 8)
  expect_equal(toupper(cols[1]), "#1B9E77")
})

test_that("aaa_5 is the literal AAA-on-white set", {
  expect_equal(a11y_palette("aaa_5"),
               c("#154E8A", "#7C2C5E", "#5C5108", "#8A3A1F", "#2D5C53"))
})

test_that("n truncates from the start", {
  expect_length(a11y_palette("dark2_8", n = 3), 3)
})

test_that("unknown palette errors", {
  expect_error(a11y_palette("rainbow"), "Unknown")
})

test_that("palette_div returns low/mid/high anchors", {
  p <- a11y_palette_div("rdbu")
  expect_named(p, c("low", "mid", "high"))
})

test_that("palette_seq returns viridisLite spec", {
  expect_named(a11y_palette_seq("cividis"),
               c("option", "begin", "end", "direction"))
})

test_that("palette_info reports family for known palette", {
  expect_equal(a11y_palette_info("aaa_5")$name, "aaa_5")
})

test_that("palette_list covers all three families", {
  expect_setequal(a11y_palette_list()$type,
                  c("discrete", "diverging", "sequential"))
})
