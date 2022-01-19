
<!-- README.md is generated from README.Rmd. Please edit that file -->

# traveltimeSF

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/traveltimeSF)](https://CRAN.R-project.org/package=traveltimeSF)
[![R-CMD-check](https://github.com/arthurgailes/traveltimeSF/workflows/R-CMD-check/badge.svg)](https://github.com/arthurgailes/traveltimeSF/actions)
<!-- badges: end -->

The goal of traveltimeSF is to provide simple wrappers for converting
data from the TravelTime SDK for R to sf. Currently only works with
isochrones

## Installation

You can install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("arthurgailes/traveltimeSF")
```

## Example

Adapted from the [TravelTime
Github](https://github.com/traveltime-dev/traveltime-sdk-r):

``` r
library(traveltimeR)

#store your credentials in an environment variable
# Sys.setenv(TRAVELTIME_ID = "YOUR_API_ID")
# Sys.setenv(TRAVELTIME_KEY = "YOUR_API_KEY")

library(traveltimeSF)
departure_search <-
  make_search(id = "public transport from Trafalgar Square",
              departure_time = strftime(as.POSIXlt(Sys.time(), "UTC"), "%Y-%m-%dT%H:%M:%SZ"),
              travel_time = 900,
              coords = list(lat = 51.507609, lng = -0.128315),
              transportation = list(type = "public_transport"),
              properties = list('is_only_walking'))

result <- time_map(departure_searches = departure_search)

shp <- time_map_to_sf(result)
shp
#> Simple feature collection with 1 feature and 2 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -0.145391 ymin: 51.49496 xmax: -0.1094006 ymax: 51.51833
#> CRS:           +proj=longlat +datum=WGS84
#>                                search_id is_only_walking
#> 1 public transport from Trafalgar Square           FALSE
#>                         geometry
#> 1 MULTIPOLYGON (((-0.1453906 ...
```

``` r
plot(shp$geometry)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
