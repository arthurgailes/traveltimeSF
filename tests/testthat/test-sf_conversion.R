
test_that("time map single search converts to sf", {
  if(Sys.getenv("TRAVELTIME_ID") == "") skip("No traveltime credentials")
  shp <- time_map_to_sf(single_search)
  expect_true("sf" %in% class(shp))
  expect_equal(nrow(shp), 1)
  expect_equal(shp$search_id[[1]], "public transport from Trafalgar Square")
  expect_false(shp$is_only_walking[[1]])
})

test_that("time map multiple searches converts to sf", {
  if(Sys.getenv("TRAVELTIME_ID") == "") skip("No traveltime credentials")
  shp <- time_map_to_sf(multi_search)
  expect_true("sf" %in% class(shp))
  expect_equal(nrow(shp), 6)
  expect_equal(shp$search_id[[1]], "driving from Trafalgar Square")
})
