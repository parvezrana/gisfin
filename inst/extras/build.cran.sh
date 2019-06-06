# ~/bin/R CMD BATCH document.R
~/bin/R-3.5.1/bin/R CMD build ../../ # --no-build-vignettes
~/bin/R-3.5.1/bin/R CMD check --as-cran gisfin_0.9.27.tar.gz
~/bin/R-3.5.1/bin/R CMD INSTALL gisfin_0.9.27.tar.gz
