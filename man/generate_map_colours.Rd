% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_map_colours.R
\name{generate_map_colours}
\alias{generate_map_colours}
\title{Generate color indices}
\usage{
generate_map_colours(sp, verbose = TRUE)
}
\arguments{
\item{sp}{A SpatialPolygonsDataFrame object}

\item{verbose}{logical. Should R report extra information on progress?}
}
\value{
Color index vector
}
\description{
Generate color indices for shape object with the aim to color neighboring objects with distinct colors.
}
\examples{
sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue");
          cols <- factor(generate_map_colours(sp=sp.suuralue));
}
\author{
Modified from the code by Karl Ove Hufthammer from
\url{http://r-sig-geo.2731867.n2.nabble.com/Colouring-maps-so-that-adjacent-polygons-differ-in-colour-td6237661.html}; modifications by Leo Lahti and Juuso Parkkinen
}
\references{
See citation("gisfin")
}
\keyword{utilities}

