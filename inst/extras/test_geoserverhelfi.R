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


## Try GeoserverHelFi Seutukartta

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