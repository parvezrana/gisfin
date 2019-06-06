.onAttach <- function(lib, pkg)
{

  # This may help with encodings in Mac/Linux
  # Sys.setlocale(locale = "UTF-8")
  # Sys.setlocale(locale = "WINDOWS-1252")

  packageStartupMessage("\ngisfin R package: tools for open GIS data for Finland.\nPart of rOpenGov <ropengov.github.io>.")

}

#' @import rgeos
#' @import maptools
#' @importFrom grDevices colorRampPalette
#' @importFrom grDevices rainbow
#' @importFrom utils download.file
#' @importFrom utils read.csv
