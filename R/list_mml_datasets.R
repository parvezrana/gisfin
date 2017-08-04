#' @title List Land Survey Finland (MML) data sets readily available in RData format.
#' @description Retrieves the list of currently available MML data sets in http://www.datavaalit.fi/storage/avoindata/mml/rdata/
#' @param verbose logical. Should R report extra information on progress? 
#' @return List of data sets
#' 
#' @import dplyr
#' @import httr
#' 
#' @export
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples datasets = list_mml_datasets()
#' @keywords utilities
list_mml_datasets <- function(verbose=TRUE) {
  
  # Helper function to turn a vector of data features into a tibble
  parse_features <- function(x) {
    # Process each path which is in form 
    features <- lapply(x, function(y) {
      components <- unlist(strsplit(x))
      return(c(components, x))
    })    
    return(dplyr::bind_rows(features))
  }
  
  url <- ropengov_storage_path("mml")
  
  if (verbose) {
    message(paste("Retrieving data set listing from ", url))
  }
  
  # While trying to be URL agnostic, figure out if storage path is
  # pointing to GitHub. Each datastore needs specific extraction logic.
  if (grepl("github.com", filepath)) {
    req <- httr::GET(url)
    httr::stop_for_status(req)
    
    file_list <- unlist(lapply(httr::content(req)$tree, "[", "path"), 
                        use.names = FALSE)
    rdata_list <- gsub("rdata/", "", grep(".+\\.RData$", file_list, 
                                          value = TRUE))
  }
  
  
  
  if (verbose) {
    message("\nData loaded successfully!")
  }
  return(data.ids)
}


