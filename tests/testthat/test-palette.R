test_that("dark2_8 returns 8 RColorBrewer Dark2 colors", {
  cols <- a11y_palette("dark2_8")
  expect_length(cols, 8)
  expect_equal(toupper(cols[1]), "#1B9E77")
})

test_that("aaa_5 is the literal AAA-on-white set", {
  expect_equal(a11y_palette("aaa_5"),
               c("#154E8A", "#7C2C5E", "#5C5108", "#8A3A1F", "#2D5C53"))
})

test_that("the default palette is dark2_a11y_8", {
  expect_equal(a11y_palette(),
               c("#1B9E77", "#D95F02", "#7570B3", "#E7298A",
                 "#5E8C1A", "#8B4513", "#B8860B", "#2C6FAC"))
  expect_equal(.scale_a11y_palette(NULL, "AA"), "dark2_a11y_8")
  expect_equal(formals(make_a11y)$palette, "dark2_a11y_8")
  expect_equal(formals(a11y_layout)$palette, "dark2_a11y_8")
})

test_that("new palettes hold their exact colors", {
  expect_equal(a11y_palette("dark2_strict_5"),
               c("#1B9E77", "#D95F02", "#7570B3", "#8B4513", "#C2185B"))
  expect_equal(a11y_palette("okabe_ito"),
               c("#E69F00", "#56B4E9", "#009E73", "#0072B2",
                 "#D55E00", "#CC79A7", "#000000"))
  expect_equal(a11y_palette("grayscale"), c("#1A1A1A", "#595959", "#8C8C8C"))
})

test_that("white-safe palettes reach 3:1 on white", {
  for (nm in c("dark2_a11y_8", "dark2_strict_5", "grayscale")) {
    res <- a11y_check_palette(a11y_palette(nm), level = "AA-large")
    expect_true(all(res$status == "ok"), info = nm)
  }
})

test_that("old palette names still work", {
  for (nm in c("dark2_8", "set2_8", "paired_12", "aaa_5")) {
    expect_true(length(a11y_palette(nm)) > 0, info = nm)
  }
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
