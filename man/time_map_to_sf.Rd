% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/time_map_to_sf.R
\name{time_map_to_sf}
\alias{time_map_to_sf}
\title{Convert time_map to an sf object}
\usage{
time_map_to_sf(time_map_data, return_list = FALSE)
}
\arguments{
\item{time_map_data}{result from a call to \code{traveltimeR::time_map}}

\item{return_list}{if FALSE (default), returns all results as a single
\code{sf} dataframe.}
}
\description{
traveltime delivers results in parsed json - this script converts the geojson
to an \code{sf} classed object.
}
\examples{
library(traveltimeSF)
data(single_search)
time_map_to_sf(single_search)

}
