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

#' Download data to a location
#' 
#' Archived (zips) data items will also be automatically extracted.
#' 
#' @param url A string url to data to be downloaded.
#' @param output A string path defining the output name.
#' @param overwrite Logical indicating if the output should be overwritten if 
#' found (default: FALSE)
#' @param verbose logical. Should R report extra information on progress? 
#' (default: TRUE)
#' 
#' @return Logical indicating whether the download and potential extraction 
#' operations were succesful (TRUE) or not (FALSE).
#' 
#' @author Joona Lehtomaki, Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @keywords internal
#' 
.download_data <- function(url, output, overwrite=FALSE, verbose=TRUE) {
  
  final_message <- "Download complete"
  
  # Check whether the data already exists and whether it should be overwritten
  if (file.exists(output)) {
    if (overwrite) {
      if (verbose) {
        message("File ", output, " found, but overwrite is on; dowloading again")
      }
    } else {
      if (verbose) {
        message("File ", output, " already found, will not download!")
      }
      # Return TRUE as no further operations are needed
      # [todo] - techically this might be just the zip file prior to extraction
      return(TRUE)
    }
  }
  
  download.success <- tryCatch(
              {
                if (verbose){ 
                    message("Dowloading ", url, "\ninto ", output, "\n")
                }
                utils::download.file(url, destfile = output, quiet =! verbose)
                return(TRUE)
              }, error=function(cond) {
                message(paste("URL does not seem to exist:", url))
                message("Original error message:")
                message(cond)
                # Choose a return value in case of error
                return(FALSE)
              })
  
  if(download.success){
    # See if the file is a zip file
    if(grepl('\\.zip$', output)) {
      if(verbose) {
        print(paste("Extracting zip file", output, "to", dirname(output)))
      }
      utils::unzip(output, exdir = dirname(output))
    }
    return(TRUE)
  } else {
    # Just propagate the failure
    return(FALSE)
  }
}
