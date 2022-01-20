#' convenience wrapper that combines time_map and time_map_to_sf
#'
#' @inheritParams time_map_to_sf
#'
#' @param ... arguments passed to `time_map`
#'
#' @export
time_map_sf <- function(return_list = FALSE, ...){
  map <- traveltimeR::time_map(...)
  shp <- time_map_to_sf(map)
  return(shp)
}
