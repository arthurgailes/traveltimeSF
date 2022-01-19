#' Convert time_map to an sf object
#'
#' traveltime delivers results in parsed json - this script converts the geojson
#' to an `sf` classed object.
#'
#' @param time_map_data result from a call to `traveltimeR::time_map`
#'
#' @param return_list if FALSE (default), returns all results as a single
#'  `sf` dataframe.
#'
#' @examples
#' library(traveltimeSF)
#' data(single_search)
#' time_map_to_sf(single_search)
#'
#' @export
time_map_to_sf <- function(time_map_data, return_list = FALSE){

  results <- time_map_data$contentParsed$results

  #return an sf object for each result
  shape_list <- lapply(results, extract_spatial_data)

  # combine the line data into multipolygons
  poly_list <- lapply(shape_list, point_to_poly)

  # add the id info to each result - may do more here in future
  for( i in 1:length(poly_list)){
    shp <- poly_list[[i]]
    info <- results[[i]]
    shp$search_id <- info$search_id

    if(length(info$properties) > 0){
      props <- as.data.frame(info$properties)
      shp <- dplyr::bind_cols(shp, props)
    }
    poly_list[[i]] <- shp
  }

  if(return_list == FALSE){
    poly_list <- dplyr::bind_rows()
  }

}

#' extract the spatial data from the parsed results of a `time_map` call
extract_spatial_data <- function(item) {
  shapes <- item$shapes
  flat <- lapply(c(1:length(shapes)),
    function(x) dplyr::bind_rows(shapes[[x]]$shell))

  flat_df <- dplyr::bind_rows(flat, .id="group")

  shp <- sf::st_as_sf(x = flat_df,
    coords = c("lng", "lat"),
    crs = "+proj=longlat +datum=WGS84")

  return(shp)
}

#' convert list of points to multipolygons
point_to_poly <- function(raw_shp){

  polygons <- dplyr::mutate(raw_shp, ID=dplyr::row_number())
  polygons <- dplyr::group_by(polygons, group)
  polygons <- dplyr::arrange(polygons, ID)
  polygons <- dplyr::summarize(polygons, INT = dplyr::first(ID), do_union = FALSE)
  polygons <- sf::st_cast(polygons, "POLYGON")
  polygons <- dplyr::select(polygons, -INT)

  multipolygon <- sf::st_combine(polygons)
  multipolygon <- sf::st_sf(geometry=multipolygon)
}
