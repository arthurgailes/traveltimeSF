## code to prepare `multi_search` dataset goes here
departure_search1 <-
  make_search(id = "public transport from Trafalgar Square",
    departure_time = "2022-01-01T08:00:00Z",
    travel_time = 900,
    coords = list(lat = 51.507609, lng = -0.128315),
    transportation = list(type = "public_transport"),
    properties = list('is_only_walking'))

departure_search2 <-
  make_search(id = "driving from Trafalgar Square",
    departure_time = "2022-01-01T08:00:00Z",
    travel_time = 900,
    coords = list(lat = 51.507609, lng = -0.128315),
    transportation = list(type = "driving"))

arrival_search <-
  make_search(id = "public transport to Trafalgar Square",
    arrival_time = "2022-01-01T08:00:00Z",
    travel_time = 900,
    coords = list(lat = 51.507609, lng = -0.128315),
    transportation = list(type = "public_transport"),
    range = list(enabled = T, width = 3600))

arrival_search2 <-
  make_search(id = "driving to Trafalgar Square",
    arrival_time = "2022-01-01T08:00:00Z",
    travel_time = 900,
    coords = list(lat = 51.507609, lng = -0.128315),
    transportation = list(type = "driving"))

union <- make_union_intersect(id = "union of driving and public transport",
  search_ids = list('driving from Trafalgar Square',
    'public transport from Trafalgar Square'))
intersection <- make_union_intersect(id = "intersection of driving and public transport",
  search_ids = list('driving from Trafalgar Square',
    'public transport from Trafalgar Square'))

multi_search <-
  time_map(
    departure_searches = c(departure_search1, departure_search2),
    arrival_searches = c(arrival_search, arrival_search2),
    unions = union,
    intersections = intersection
  )

usethis::use_data(multi_search, overwrite = TRUE)
