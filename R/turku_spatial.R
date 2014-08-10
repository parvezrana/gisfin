# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen, Leo Lahti and Joona Lehtomäki / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' Retrieve administrative boundaries in Turku
#'
#' Retrieves administrative boundaries data from Lounaispaikka (GIS repository
#' for southwestern Finland). 
#' 
#' Available data sets (defined by the argument \code{map.specifier}) and the 
#' associated licenses are:
#'
#' \describe{
#'  \item{\code{elections}}{Election districts in City of Turku (City of turku, 
#'    \href{http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf}{Turun kaupungin lisenssi})}
#'  \item{\code{major-districts}}{Major district in City of Turku (City of turku, 
#'    \href{http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf}{Turun kaupungin lisenssi})}
#' }
#'
#' @param map.specifier A string. Specify the name of the Turku administrative 
#' data set to retrieve. 
#' @param data.dir A string. Specify a temporary folder for storing downloaded 
#' data (default: \code{tempdir()}.
#' @param verbose logical. Should R report extra information on progress?
#' (default: TRUE)
#' @param ... other arguments  passed on to \code{download_data}
#'
#' @return a spatial object (from SpatialPolygonsDataFrame class), CRS is 
#' EUREF-FIN (EPSG:3067)
#' 
#' @import rgdal
#' @import sp
#' @export
#'
#' @author Joona Lehtomaki, Juuso Parkkinen,and Leo Lahti 
#' \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @seealso \url{http://paikkatietokeskus.lounaispaikka.fi/fi/aineistot/}, 
#' \code{\link{download.data}}
#' 
#' @examples 
#' # See available options
#' get_turku_adminboundaries()
#' 
#' \dontrun{
#' # Get the election districts as a SpatialPolygonsDataFrame
#' get_turku_adminboundaries('elections')
#' 
#' # Use cache to avoid downloading the data each time
#' get_turku_adminboundaries('elections', data.dir='cache')
#' 
#' # Force update the cache
#' get_turku_adminboundaries('elections', data.dir='cache', overwrite=TRUE)
#' } 
#' 
get_turku_adminboundaries <- function(map.specifier=NULL, data.dir = tempdir(), 
                                      verbose=TRUE, ...) {
  # If data not specified, return a list of available options
  if (is.null(map.specifier)) {
    message("Please specify 'map.specifier' for Turku administrative boundaries")
    return(c("elections", "major-districts"))
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir)) {
    dir.create(data.dir)
  }
  
  ## Download data -----------------------------------
  
  base.url <- "http://paikkatietokeskus.lounaispaikka.fi/cms/files/aineistoja"
  
  # Define data to download
  if (map.specifier == "elections") {
    target <- paste0(base.url, "/", 
                     "geojson/aanestysalueet_alueina_euref_fin.geojson")
    if (verbose) {
      message("Turku election district boundaries (Turun kaupungin aanestysaluerajat) (C) City of Turku 2011")
      message("Licence: 'http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf'")
    }
    # The name of the actual spatial file, zips can include several different 
    # files
    sp.file <- file.path(data.dir, basename(target))
    # Spatial in EUREF-FIN => EPSG:3067
    p4s <- "+init=epsg:3067"
    
  } else if (map.specifier == "major-districts") {
    target <- paste0(base.url, "/", "Turku_suuralueet.zip")
    if (verbose) {
      message("Major district in City of Turku (Turun kaupungin aanestysaluerajat) (C) City of Turku 2011")
      message("Licence: 'http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf'")
    }
    # sp.file is the EUREF-FIN version
    sp.file <- file.path(data.dir, "Suuralueet_epsg3067_shape.shp")
    # Spatial in EUREF-FIN => EPSG:3067
    p4s <- "+init=epsg:3067"
  }
  
  # Local name for the downloaded file (zip or not)
  filename <- file.path(data.dir, basename(target))
  dl.success <- download_data(target, filename, ...)
  
  ## Read in the spatial data -----------------------------------
  
  # If downloading/extracting was a success, proceed to read in the spatial 
  # data.
  if (dl.success) {
    
    if (!file.exists(sp.file)) {
      stop("Input spatial file ", sp.file, " does not exist")
    }
    if (verbose) {
      message("Reading in spatial data from ", sp.file)
    }
    sp <- rgdal::readOGR(sp.file, layer = rgdal::ogrListLayers(sp.file), 
                         verbose = verbose, p4s=p4s, 
                         drop_unsupported_fields=T, dropNULLGeometries=T)
  } else {
    stop("Download failed")
  }
  
  if (verbose) {
    message("\nData loaded successfully!")
  }
  
  return(sp)
}
  