test_that("wcag_rules.yaml has required top-level keys", {
  rules <- yaml::read_yaml(
    system.file("extdata/wcag_rules.yaml", package = "a11yviz")
  )
  expect_true(all(c("contrast", "font_size", "palettes", "diverging",
                    "sequential", "overlay_presets", "tooltip", "sc_mapping")
                  %in% names(rules)))
  expect_named(rules$contrast, c("AA", "AAA"))
  expect_true("dark2_8" %in% names(rules$palettes))
  expect_true("rdbu"    %in% names(rules$diverging))
  expect_true("cividis" %in% names(rules$sequential))
})

test_that("yaml version matches package version", {
  rules <- yaml::read_yaml(
    system.file("extdata/wcag_rules.yaml", package = "a11yviz")
  )
  expect_equal(rules$version, as.character(packageVersion("a11yviz")))
})
