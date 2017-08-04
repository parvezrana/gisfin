#' Get MML (Land Survey Finland) data
#' 
#' Retrieve data from Land Survey Finland (Maanmittauslaitos, MML). The data 
#' are processed into .RData files due to their big size. See the preprocessing 
#' details in \url{https://github.com/avoindata/mml}.
#' 
#' @param map.id data ID. See details.
#' @param data.id data ID. See details.
#' @param verbose logical. Should R report extra information on progress? 
#' @return url connection
#' @details To browse for available RData, run list_mml_datasets() or see 
#'          https://github.com/avoindata/mml/tree/master/rdata. 
#' @export
#' @author Leo Lahti \email{louhos@@googlegroups.com}, 
#'         Joona Lehtomaki \email{joona.lehtomaki@@gmail.com}
#'         
#' @references See citation("gisfin")
#' 
#' @import sf
#'    
#' @examples datasets <- list_mml_datasets(); 
#'           map.id <- names(datasets)[[4]]; 
#'           data.id <- datasets[[map.id]][[1]]; 
#'           sp <- get_mml(map.id, data.id)
#'           
get_mml <- function(map.id, data.id, verbose = TRUE) {

  # Data are stored as SpatialX objects in the rdata files. In 
  # future, sf-objects might be used instead
  url <- paste(ropengov_storage_path(), "mml/rdata/", sep = "")
  filepath <- paste(url, map.id, "/", data.id, ".RData", sep = "")
  
  if (verbose) {
    message("Loading ", filepath, ". (C) MML 2013. Converted to ",
            "RData shape object by Louhos. For more information, ", 
            "see https://github.com/avoindata/mml/")
  }

  # Returns a SpatialPolygonsDataFrame named "sp"
  load(url(filepath)) 

  if (!exists("sp")) {
    stop("Loaded data does not contain needed 'sp' object")
  }
    
  # Coerce into a sf-object
  sf::st_as_sf(sp)
  
  if (verbose) {
    message("\nData loaded successfully!")
  }
  
  return(sp)
}
