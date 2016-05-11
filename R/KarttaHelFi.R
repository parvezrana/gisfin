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
#' @title Builds a WFS request to the \code{kartta.hel.fi} geospatial API.
#' 
#' @description Builds a WFS request to the \code{kartta.hel.fi} geospatial API. The request is submitted with
#' \code{\link{KarttaHelFiWFSClient}} to retrieve the data.
#'
#' @section Currently supported data sets:
#' \itemize{
#'   \item Avoin data (avoindata)
#' }
#'
#' @section Methods:
#' \itemize{
#'   \item\code{getAvoindataLayers()}: A request for a list of available regional map data sets (layers).
#'   \item\code{getAvoindata(layer)}: A request for regional map data \code{layer}.
#' }
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @references See citation("gisfin")
#' @author Juuso Parkkinen and Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{KarttaHelFiWFSClient}} \code{\link{WFSStreamingRequest}}
#' @exportClass KarttaHelFiWFSRequest
#' @export KarttaHelFiWFSRequest
KarttaHelFiWFSRequest <- R6::R6Class(
  "KarttaHelFiWFSRequest",
  inherit = gisfin::WFSStreamingRequest,
  private = list(
    getURL = function() {
      url <- paste0("http://kartta.hel.fi/ws/geoserver/", private$getPathString(), "/wfs?", private$getParametersString())
      return(url)
    }
  ),
  public = list(
    getDataSource = function() private$getURL(),
    
    getKarttaHelFiLayers = function(path) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      return(self$setPath(path)$getCapabilities())
    },

    getKarttaHelFiLayer = function(path, layer) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(self$setPath(path)$getFeature(typeName=layer))
    },
    
    getAvoindataLayers = function() self$getKarttaHelFiLayers("avoindata"),
    getAvoindata = function(layer) self$getKarttaHelFiLayer("avoindata", layer)
   )
)

#' @title Retrieves geospatial data from \code{kartta.hel.fi}.
#' 
#' @description Retrieves geospatial data from (\url{http://kartta.hel.fi}). A request object
#' to retrieve data is constructed from the class \code{\link{KarttaHelFiWFSRequest}}. Layer lists are
#' returned as \code{character} vectors and map data (layers) as \code{Spatial*} objects.
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @return In case the service at \code{hel.fi} cannot be reached, the relevant methods return \code{character(0)}.
#' @references See citation("gisfin")
#' @author Juuso Parkkinen and Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{KarttaHelFiWFSRequest}} \code{\link{WFSStreamingClient}}
#' @exportClass KarttaHelFiWFSClient
#' @export KarttaHelFiWFSClient
KarttaHelFiWFSClient <- R6::R6Class(
  "KarttaHelFiWFSClient",
  inherit = gisfin::WFSStreamingClient,
  public = list(
  )
)
