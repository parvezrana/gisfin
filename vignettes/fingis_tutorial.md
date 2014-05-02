<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->


```r
opts_knit$set(upload.fun = imgur_upload, base.url = NULL)  # upload all images to imgur.com
# opts_chunk$set(fig.width=5, fig.height=5, cache=TRUE)
```


Finland GIS R tools
===========

This is an [rOpenGov](https://github.com/rOpenGov/fingis) R package
providing tools for Finnish GIS data.

## Available data

The following data sets are currently available:
* [Helsinki region aluejakokartat](#helsinki-region-aluejakokartat)
* [Maanmittauslaitos](#maanmittauslaitos)
* [Geocoding](#geocoding)

### Installation

Note! The fingis package uses the rgdal library, which depends on the GDAL spatial framework. Installing this might be tricky. If you encounter problems, please contact us by email: louhos@googlegroups.com.

Some rgdal installation tips for various platforms:
* Windows: Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html)
* OSX: Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html). Check also [KyngChaos Wiki](http://www.kyngchaos.com/software/frameworks) 
* Linux: Try the installation scripts [here](https://github.com/louhos/takomo/tree/master/installation/) (not necessarily up-to-date!)

Release version for general users (NOT AVAILABLE YET):


Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("fingis", "ropengov")
library(fingis)
```


Further installation and development instructions at the [Github
page](https://github.com/rOpenGov/fingis).

### Helsinki region aluejakokartat

Retrieve Helsinki region aluejakokartat (district maps.)

List available maps


```r
map.list <- get_Helsinki_aluejakokartat()
map.list
```

```
## [1] "kunta"             "pienalue"          "pienalue_piste"   
## [4] "suuralue"          "suuralue_piste"    "tilastoalue"      
## [7] "tilastoalue_piste" "aanestysalue"
```


Retrieve 'suuralue' spatial object and plot it with the plot_shape() function.


```r
sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier = "suuralue")
plot_shape(sp = sp.suuralue, varname = "Name", type = "discrete", plot = FALSE)
```

![plot of chunk hkk-suuralue1](http://i.imgur.com/RckepmJ.png) 


Retrieval 'suuralue_piste' spatial object, containing the center points of the districts, and plot with spplot().


```r
sp.suuralue.piste <- get_Helsinki_aluejakokartat(map.specifier = "suuralue_piste")
sp::spplot(obj = sp.suuralue.piste, zcol = "Name")
```

![plot of chunk hkk-suuralue2](http://i.imgur.com/UevJThW.png) 


Use the sp2df() function to tranform the spatial objects into data frames. Plot with ggplot2, using blank theme with get_theme_map(). 


```r
# Get data frames
df.suuralue <- sp2df(sp.suuralue, "Name")
df.suuralue.piste <- sp2df(sp.suuralue.piste, "Name")

# Set map theme
theme_set(get_theme_map())
# Plot regions, add labels using the points data
ggplot(df.suuralue, aes(x = long, y = lat, fill = Name)) + geom_polygon() + 
    geom_text(data = df.suuralue.piste, aes(label = Name)) + theme(legend.position = "none")
```

![plot of chunk hkk-suuralue3](http://i.imgur.com/fG3teDC.png) 


Add background map from OpenStreetMap using the [ggmap](https://sites.google.com/site/davidkahle/ggmap) package.


```r
# Add background map from OpenStreetMap using ggmap
library(ggmap)
# Get bounding box from sp.suuralue
hel.bbox <- as.vector(sp.suuralue@bbox)
# Get map using openstreetmap
hel.map <- ggmap::get_map(location = hel.bbox, source = "osm")
# Plot transparent districts on top the background map
ggmap(hel.map) + geom_polygon(data = df.suuralue, aes(x = long, y = lat, fill = Name), 
    alpha = 0.5) + geom_text(data = df.suuralue.piste, aes(x = long, y = lat, 
    label = Name)) + theme(legend.position = "none")
```

![plot of chunk hkk-suuralue4](http://i.imgur.com/Jc3OIhQ.png) 


Retrieve and plot äänetysaluejako (election districts).


```r
sp.aanestys <- get_Helsinki_aluejakokartat(map.specifier = "aanestysalue")
plot_shape(sp.aanestys, "KUNTA", type = "discrete", plot = FALSE)
```

![plot of chunk hkk-aanestysalue](http://i.imgur.com/Ta4c0MO.png) 


### Other Helsinki region spatial data

To be added

### Maanmittauslaitos

Spatial data from  Maanmittauslaitos (MML, Land Survey Finland). These data are preprocessed into RData format (FIXME: add description).

List available data sets


```r
list_mml_datasets()
```

```
## $`1_milj_Shape_etrs_shape`
##  [1] "AVI1_l"   "AVI1_p"   "airport"  "asemat"   "cityp"    "coast_l" 
##  [7] "coast_p"  "dcont_l"  "dcont_p"  "forest"   "hcont_l"  "hcont_p" 
## [13] "hpoint"   "kunta1_l" "kunta1_p" "lake_l"   "lake_p"   "maaku1_l"
## [19] "maaku1_p" "namep"    "pelto"    "railway"  "river"    "rivera_l"
## [25] "rivera_p" "road"     "suot"     "taajama" 
## 
## $`4_5_milj_shape_etrs-tm35fin`
##  [1] "AVI1_l"   "AVI1_p"   "AVI4_l"   "AVI4_p"   "airport"  "asemat"  
##  [7] "cityp"    "coast"    "coast_l"  "coast_p"  "dcont_l"  "dcont_p" 
## [13] "forest"   "hcont_l"  "hcont_p"  "hpoint"   "kunta1_l" "kunta1_p"
## [19] "kunta4_l" "kunta4_p" "lake"     "lake_l"   "lake_p"   "maaku1_l"
## [25] "maaku1_p" "maaku4_l" "maaku4_p" "namep"    "pelto"    "railway" 
## [31] "rajamuu"  "river"    "rivera_l" "rivera_p" "road"     "suot"    
## [37] "taajama" 
## 
## $`2012`
## character(0)
## 
## $`Maastotietokanta-tiesto1`
## [1] "N61_v"
## 
## $`Maastotietokanta-tiesto2`
## [1] "N62_p" "N62_s" "N62_t" "N62_v"
## 
## $`Yleiskartta-1000`
##  [1] "AmpumaRaja"          "HallintoAlue"        "HallintoalueRaja"   
##  [4] "KaasuJohto"          "KarttanimiPiste500"  "KarttanimiPiste1000"
##  [7] "KorkeusAlue"         "KorkeusViiva500"     "KorkeusViiva1000"   
## [10] "LentokenttaPiste"    "LiikenneAlue"        "MaaAlue"            
## [13] "Maasto1Reuna"        "Maasto2Alue"         "MetsaRaja"          
## [16] "PeltoAlue"           "RautatieViiva"       "SahkoLinja"         
## [19] "SuojaAlue"           "SuojametsaRaja"      "SuojeluAlue"        
## [22] "TaajamaAlue"         "TaajamaPiste"        "TieViiva"           
## [25] "VesiAlue"            "VesiViiva"          
## 
## $`Yleiskartta-4500`
##  [1] "HallintoAlue"        "HallintoalueRaja"    "KarttanimiPiste2000"
##  [4] "KarttanimiPiste4500" "KarttanimiPiste8000" "KorkeusAlue"        
##  [7] "KorkeusViiva"        "Maasto1Reuna"        "RautatieViiva"      
## [10] "TaajamaPiste2000"    "TaajamaPiste4500"    "TaajamaPiste8000"   
## [13] "TieViiva2000"        "TieViiva4500"        "TieViiva8000"       
## [16] "VesiAlue"            "VesiViiva2000"       "VesiViiva4500"      
## [19] "VesiViiva8000"
```


Retrieve regional borders for Finland.


```r
# Get a specific map
sp.mml <- get_MML(map.id = "Yleiskartta-4500", data.id = "HallintoAlue")

# Investigate available variables in this map
head(as.data.frame(sp.mml))
```

```
##   Kohderyhma Kohdeluokk Enklaavi AVI Maakunta Kunta
## 0         71      84200        1   1       01   078
## 1         71      84200        1   1       01   149
## 2         71      84200        1   7       21   318
## 3         71      84200        1   1       01   710
## 4         71      84200        1   1       01   235
## 5         71      84200        1   7       21   062
##                            AVI_ni1
## 0 Etelä-Suomen aluehallintovirasto
## 1 Etelä-Suomen aluehallintovirasto
## 2       Ahvenanmaan valtionvirasto
## 3 Etelä-Suomen aluehallintovirasto
## 4 Etelä-Suomen aluehallintovirasto
## 5       Ahvenanmaan valtionvirasto
##                                    AVI_ni2            Maaku_ni1
## 0 Regionförvaltningsverket i Södra Finland              Uusimaa
## 1 Regionförvaltningsverket i Södra Finland              Uusimaa
## 2              Statens ämbetsverk på Åland Ahvenanmaan maakunta
## 3 Regionförvaltningsverket i Södra Finland              Uusimaa
## 4 Regionförvaltningsverket i Södra Finland              Uusimaa
## 5              Statens ämbetsverk på Åland Ahvenanmaan maakunta
##          Maaku_ni2  Kunta_ni1 Kunta_ni2 Kieli_ni1 Kieli_ni2
## 0           Nyland      Hanko     Hangö     Suomi    Ruotsi
## 1           Nyland       Ingå     Inkoo    Ruotsi     Suomi
## 2 Landskapet Åland      Kökar       N_A    Ruotsi       N_A
## 3           Nyland   Raseborg Raasepori    Ruotsi     Suomi
## 4           Nyland Kauniainen Grankulla     Suomi    Ruotsi
## 5 Landskapet Åland      Föglö       N_A    Ruotsi       N_A
##                             AVI.FI Kieli.FI          Maakunta.FI
## 0 Etelä-Suomen aluehallintovirasto    Suomi              Uusimaa
## 1 Etelä-Suomen aluehallintovirasto   Ruotsi              Uusimaa
## 2       Ahvenanmaan valtionvirasto   Ruotsi Ahvenanmaan maakunta
## 3 Etelä-Suomen aluehallintovirasto   Ruotsi              Uusimaa
## 4 Etelä-Suomen aluehallintovirasto    Suomi              Uusimaa
## 5       Ahvenanmaan valtionvirasto   Ruotsi Ahvenanmaan maakunta
##     Kunta.FI
## 0      Hanko
## 1      Inkoo
## 2      Kökar
## 3  Raasepori
## 4 Kauniainen
## 5      Föglö
```


Plot provinces (maakunnat).


```r
# Plot the shape file, colour provinces
plot_shape(sp = sp.mml, varname = "Maakunta", type = "discrete", plot = FALSE)
```

![plot of chunk MML_province](http://i.imgur.com/gaW04kE.png) 


Plot municipalities (kunnat).


```r
# Plot the shape file, colour municipalities
plot_shape(sp = sp.mml, varname = "Kunta", type = "discrete", plot = FALSE)
```

![plot of chunk MML_municipality](http://i.imgur.com/WIIAUKC.png) 


### Geocoding

Get geocodes for given location (address etc.) using one of the available services. Please read carefully the usage policies for the different services:
* [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
* [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
* [Google](http://code.google.com/apis/maps/documentation/geocoding/)

The function get_geocode() returns both latitude and longitude for the first hit, and the raw output (varies depending on the service used).


```r
gc1 <- get_geocode("Mannerheimintie 100, Helsinki", service = "okf")
unlist(gc1[1:2])
```

```
##   lat   lon 
## 60.17 24.94
```

```r
gc2 <- get_geocode("Mannerheimintie 100, Helsinki", service = "openstreetmap")
unlist(gc2[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```

```r
gc3 <- get_geocode("Mannerheimintie 100, Helsinki", service = "google")
unlist(gc3[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```


### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite this R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2014). fingis R package. URL:
https://github.com/rOpenGov/fingis'.


### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.3 (2014-03-06)
## Platform: x86_64-apple-darwin10.8.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] mapproj_1.2-2      maps_2.3-6         ggmap_2.3         
##  [4] rgeos_0.3-4        maptools_0.8-29    knitr_1.5         
##  [7] fingis_0.9.9       RColorBrewer_1.0-5 XML_3.95-0.2      
## [10] ggplot2_0.9.3.1    spdep_0.5-71       Matrix_1.1-2-2    
## [13] RCurl_1.95-4.1     bitops_1.0-6       rjson_0.2.13      
## [16] roxygen2_3.1.0     rgdal_0.8-16       sp_1.0-14         
## 
## loaded via a namespace (and not attached):
##  [1] boot_1.3-10         brew_1.0-6          coda_0.16-1        
##  [4] codetools_0.2-8     colorspace_1.2-4    deldir_0.1-5       
##  [7] dichromat_2.0-0     digest_0.6.4        evaluate_0.5.1     
## [10] foreign_0.8-60      formatR_0.10        grid_3.0.3         
## [13] gtable_0.1.2        labeling_0.2        lattice_0.20-27    
## [16] LearnBayes_2.12     MASS_7.3-30         munsell_0.4.2      
## [19] nlme_3.1-115        plyr_1.8.1          png_0.1-7          
## [22] proto_0.3-10        Rcpp_0.11.1         reshape2_1.2.2     
## [25] RgoogleMaps_1.2.0.5 RJSONIO_1.0-3       scales_0.2.3       
## [28] splines_3.0.3       stringr_0.6.2       tools_3.0.3
```

