# This file is a part of the gisfin package (http://github.com/rOpenGov/gisfin)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2015 Jussi Jousimo and Juuso Parkkinen / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' @include WFSClient.R
#'
#' @title Builds a WFS request to the \code{stat.fi} geospatial API.
#' 
#' @description Builds a WFS request to the \code{stat.fi} geospatial API. The request is submitted with
#' \code{\link{GeoserverHelFiWFSClient}} to retrieve the data.
#' For more information about the API, see \url{http://www.stat.fi/tup/rajapintapalvelut/index_en.html}.
#' For General Terms of Use, see \url{http://www.stat.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html/}. 
#'
#' @section Currently supported data sets:
#' \itemize{
#'   \item Population densities in various demographic groups
#'   \item Production and industrial facilities
#'   \item Educational institutions
#'   \item Road accidents
#' }
#'
#' @section Methods:
#' \itemize{
#'   \item\code{getSeutukarttaLayers()}: A request for a list of available population grid data sets (layers).
#'   \item\code{getSeutukartta(layer)}: A request for population grid data \code{layer}.
#' }
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{GeoserverHelFiWFSClient}} \code{\link{WFSStreamingRequest}}
#' @exportClass GeoserverHelFiWFSRequest
#' @export GeoserverHelFiWFSRequest
GeoserverHelFiWFSRequest <- R6::R6Class(
  "GeoserverHelFiWFSRequest",
  inherit = gisfin::WFSStreamingRequest,
  private = list(
    getURL = function() {
      url <- paste0("http://geoserver.hel.fi/geoserver/", private$getPathString(), "/wfs?", private$getParametersString())
      return(url)
    }
  ),
  public = list(
    getDataSource = function() private$getURL(),
    
    getGeoserverHelFiLayers = function(path) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      return(self$setPath(path)$getCapabilities())
    },

    getGeoserverHelFiLayer = function(path, layer) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(self$setPath(path)$getFeature(typeName=layer))
    },
    
    getSeutukarttaLayers = function() self$getGeoserverHelFiLayers("seutukartta"),
    getSeutukartta = function(layer) self$getGeoserverHelFiLayer("seutukartta", layer)

  )
)

#' @title Retrieves geospatial data from \code{stat.fi}.
#' 
#' @description Retrieves geospatial data from Statistics Finland (\url{http://www.stat.fi}). A request object
#' to retrieve data is constructed from the class \code{\link{GeoserverHelFiWFSRequest}}. Layer lists are
#' returned as \code{character} vectors and map data (layers) as \code{Spatial*} objects.
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @return In case the service at \code{stat.fi} cannot be reached, the relevant methods return \code{character(0)}.
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{GeoserverHelFiWFSRequest}} \code{\link{WFSStreamingClient}}
#' @exportClass GeoserverHelFiWFSClient
#' @export GeoserverHelFiWFSClient
GeoserverHelFiWFSClient <- R6::R6Class(
  "GeoserverHelFiWFSClient",
  inherit = gisfin::WFSStreamingClient,
  public = list(
  )
)
