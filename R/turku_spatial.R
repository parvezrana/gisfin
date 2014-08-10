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
#'  \item{\code{elections}}{Election districts in City of Turku (City of turku, \href{http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf}{Turun kaupungin lisenssi})}
#' }
#'
#' 
#' @param map.specifier A string. Specify the name of the Turku administrative 
#' data set to retrieve. 
#' @param data.dir A string. Specify a temporary folder for storing downloaded 
#' data (default: \code{tempdir()}.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return a spatial object (from SpatialPolygonsDataFrame class)
#' 
#' @import rgdal
#' @import sp
#' @export
#'
#' @author Joona Lehtomaki, Juuso Parkkinen,and Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @seealso \url{http://paikkatietokeskus.lounaispaikka.fi/fi/aineistot/}
#' 
#' @examples
#' # See available options
#' get_turku_adminboundaries() 
#' 
get_turku_adminboundaries <- function(map.specifier=NULL, data.dir = tempdir(), 
                                      verbose=TRUE) {
  return("foo")
}