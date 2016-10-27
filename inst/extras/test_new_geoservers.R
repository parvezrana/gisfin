# Script for testing new geoserver functionalities: GeoserverHelFi and KarttaHelFi

library(gisfin)
library(raster)

# ## Example from GeoStatFi, works
# 
# request <- gisfin::GeoStatFiWFSRequest$new()$getPopulationLayers()
# client <- gisfin::GeoStatFiWFSClient$new(request)
# layers <- client$listLayers()
# layers
# 
# request$getPopulation(layers[11])
# request
# # http://geo.stat.fi/geoserver/vaestoruutu/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=vaestoruutu:vaki2005_5km 
# client <- gisfin::GeoStatFiWFSClient$new(request)
# population <- client$getLayer(layers[11])


## Try GeoserverHelFi Seutukartta #######

# Listing available layers works
request <- gisfin::GeoserverHelFiWFSRequest$new()$getSeutukarttaLayers()
client <- gisfin::GeoserverHelFiWFSClient$new(request)
layers <- client$listLayers()
layers

# This works
request$getSeutukartta(layers[11])
client <- gisfin::GeoserverHelFiWFSClient$new(request)
seutukartta_temp1 <- client$getLayer(layers[11])

# This does not
request$getSeutukartta(layers[1])
client <- gisfin::GeoserverHelFiWFSClient$new(request)
seutukartta_temp2 <- client$getLayer(layers[1])

# Same with getHKR

# This works
request <- gisfin::GeoserverHelFiWFSRequest$new()$getHKRLayers()
client <- gisfin::GeoserverHelFiWFSClient$new(request)
layers <- client$listLayers()
layers

# This works
request$getHKR(layers[1])
client <- gisfin::GeoserverHelFiWFSClient$new(request)
hkr_ylre_temp1 <- client$getLayer(layers[1])

# This does not
# This I would like to work (ylre_katualue and ylre_katuosat)
request$getHKR(layers[3])
client <- gisfin::GeoserverHelFiWFSClient$new(request)
hkr_ylre_temp2 <- client$getLayer(layers[3])
# Error in ogrInfo(dsn = dsn, layer = layer, encoding = encoding, use_iconv = use_iconv,  : 
#                    Multiple incompatible geometries: wkbLineString:wkbPolygon

                 
# This I would like to work (ylre_katualue and ylre_katuosat)
request$getHKR(layers[4])
client <- gisfin::GeoserverHelFiWFSClient$new(request)
hkr_ylre_temp2 <- client$getLayer(layers[3])


## Try KarttaHelFi Rakennukset #######

# Listing available layers works
request <- gisfin::KarttaHelFiWFSRequest$new()$getAvoindataLayers()
client <- gisfin::KarttaHelFiWFSClient$new(request)
layers <- client$listLayers()
layers

# This works
request$getAvoindata("avoindata:Rakennukset")
client <- gisfin::KarttaHelFiWFSClient$new(request)
rakennukset <- client$getLayer("avoindata:Rakennukset")

request$getAvoindata("avoindata:Rakennukset_rekisterialueet")
client <- gisfin::KarttaHelFiWFSClient$new(request)
rakennukset_rekisterialueet <- client$getLayer("avoindata:Rakennukset_rekisterialueet")


request$getAvoindata("avoindata:Helsinki_osoiteluettelo")
client <- gisfin::KarttaHelFiWFSClient$new(request)
hki_osoiteluettelo <- client$getLayer("avoindata:Helsinki_osoiteluettelo")

request$getAvoindata("avoindata:PKS_osoiteluettelo")
client <- gisfin::KarttaHelFiWFSClient$new(request)
pks_osoiteluettelo <- client$getLayer("avoindata:PKS_osoiteluettelo")

# library("dplyr")
# library("tidyr")
# rakennukset_rekisterialueet@data %>%
#   tbl_df %>%
#   summarise_each(funs(length(which(!is.na(.)))), gml_id:c_hissi) %>%
#   gather() %>%
#   View
# rakennukset_temp1@data %>%
#   tbl_df %>%
#   filter(!is.na(ratu)) %>%
#   head(100) %>%
#   View()

## Espoo ######
request <- gisfin::KartatEspooFiWFSRequest$new()$getGISLayers()
client <- gisfin::KartatEspooFiWFSClient$new(request)
layers <- client$listLayers()
layers

request$getGIS("GIS:Rakennukset")
client <- gisfin::KartatEspooFiWFSClient$new(request)
gis_rakennukset <- client$getLayer("GIS:Rakennukset")


# http://geo.stat.fi/geoserver/vaestoruutu/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=vaestoruutu:vaki2005_5km
# http://kartat.espoo.fi/TeklaOgcWeb/WFS.ashx?REQUEST=GetCapabilities&SERVICE=WFS&VERSIO
# http://kartat.espoo.fi/TeklaOgcWeb/WFS.ashx?request=GetFeature&typeName=akaava:Erityisalue&SERVICE=WFS&VERSIO



