# Sys.setenv(TRAVELTIME_ID = "YOUR_ID")
# Sys.setenv(TRAVELTIME_KEY = "YOUR_KEY")

departure_search <-
  traveltimeR::make_search(id = "public transport from Trafalgar Square",
    departure_time = strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ"),
    travel_time = 900,
    coords = list(lat = 51.507609, lng = -0.128315),
    transportation = list(type = "public_transport"),
    properties = list('is_only_walking'))
single_search <- traveltimeR::time_map(departure_searches = departure_search)

usethis::use_data(single_search, overwrite = TRUE)
