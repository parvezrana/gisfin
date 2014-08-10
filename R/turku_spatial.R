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
#' for southwestern Finland). Available data sets and the associated licenses
#' are:
#'
#'\tabular{rl}{
#'  \code{Election districts in City of Turku} \tab (C) City of turku \tab (\href{http://paikkatietokeskus.lounaispaikka.fi/cms/files/Avoin_data_Turku_lisenssiehdot.pdf}{Turun kaupungin lisenssi} \cr
#' }
#'
#' 
#' @param map.specifier A string. Specify the name of the
#' Helsinki District Boundary data set to retrieve.
#' Run 'get_helsinki_aluejakokartat()' to see available options.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return a spatial object (from SpatialPolygonsDataFrame class)
#' 
#' @import rgdal
#' @import sp
#' @export
#' @note This function replaces sorvi::GetHRIaluejakokartat; The data is now retrieved directly from HKK.
#'
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @seealso \url{http://paikkatietokeskus.lounaispaikka.fi/fi/aineistot/}
#' 
get_turku_adminboundaries <- function(map.specifier=NULL, data.dir = tempdir(), verbose=TRUE) {

}