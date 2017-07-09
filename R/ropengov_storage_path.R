#' Retrieve rOpenGov storage path
#' 
#' Storage paths for package independent rOpenGov files.
#' 
#' @param key Character string key defining which storage path
#'        is requested. If NULL (default), print available
#'        keys and storage paths.
#'         
#' @return If key is provided, an URL to requested data. If not, return NULL.
#' 
#' @examples mml_url <- ropengov_storage_path("mml")
#' 
#' @export
#' 
#' @author Joona Lehtomaki \email{joona.lehtomaki@@gmail.com}
#' @keywords utilities
#' 
ropengov_storage_path <- function(key = NULL) {
  # Louhos data is stored in Github avoindata repo:
  # https://github.com/avoindata/
  storage_paths <- list(
    "mml" = "https://github.com/avoindata/mml/blob/master/rdata/",
    "louhos" = "https://github.com/avoindata/louhos/blob/master/"
  )
  
  # If no key is requested 
  if (is.null(key)) {
    print(storage_paths)
    storage_path <- NULL
  } else {
    if (key %in% names(storage_paths)) {
      storage_path <- storage_paths[[key]]
    } else {
      stop("key is not a suitable key to stored paths: ",
           paste(names(storage_paths), collapse = ", "))
    }
  }
  return(storage_path)
}
