
test_that("time map single search converts to sf", {
  shp <- time_map_to_sf(single_search)
  expect_true("sf" %in% class(shp))
  expect_equal(nrow(shp), 1)
  expect_equal(shp$search_id[[1]], "public transport from Trafalgar Square")
  expect_false(shp$is_only_walking[[1]])
})

test_that("time map multiple searches converts to sf", {
  shp <- time_map_to_sf(multi_search)
  expect_true("sf" %in% class(shp))
  expect_equal(nrow(shp), 6)
  expect_equal(shp$search_id[[1]], "driving from Trafalgar Square")
})

test_that("time_map_sf gives correct result", {
  if(Sys.getenv("TRAVELTIME_ID") == "") skip("No traveltime credentials")
  library(sf)
  shp1 <- time_map_to_sf(single_search)

  departure_search <-
    traveltimeR::make_search(id = "public transport from Trafalgar Square",
      departure_time = strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ"),
      travel_time = 900,
      coords = list(lat = 51.507609, lng = -0.128315),
      transportation = list(type = "public_transport"),
      properties = list('is_only_walking'))
  shp2 <- time_map_sf(departure_searches = departure_search)

  expect_equal(as.numeric(st_bbox(shp1)), as.numeric(st_bbox(shp2)), tolerance = 0.01)
})
