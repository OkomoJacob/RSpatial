# Raster, NDVI, NDVI Threshold 
rm(list = ls(all=TRUE)) #clear memory
library(raster)
library(rgdal)

# import default proj dir and Check path contants
path <- setwd("D:/STUDYTanzania/Vegetation Raster Indicies/")
path
contents <- length(list.files(path))
contents
# Load the tiff in here
aoiRaster <- "S2Ngara.tif"
aoiRaster

# Stack and Denote as Multiraster data
aoiRaster <-stack(aoiRaster)
aoiRaster

plot(aoiRaster[[5]])

# 1. NDVI = ((NIR-RED)/(NIR+RED))
plotRGB(aoiRaster, 6,2,1, scale = 65535, stretch = 'lin')
ndvi <- (aoiRaster[[4]]-aoiRaster[[3]])/(aoiRaster[[4]]+aoiRaster[[3]])
ndvi
plot(ndvi)

# 2. GNDVI = ((NIR-G)/(NIR+G))
gndvi <- (aoiRaster[[4]]-aoiRaster[[2]])/(aoiRaster[[4]]+aoiRaster[[2]])
gndvi
plot(gndvi)

# 3. EVI = 2.5*((NIR-RED)/((NIR+(6*RED)-(7.5*BLUE))+1))
eviNum <- aoiRaster[[4]]-aoiRaster[[3]]
eviDen <- (aoiRaster[[4]]+(6*aoiRaster[[3]])-(7.5*aoiRaster[[1]])+1)
evi <- 2.5*(eviNum/eviDen)
evi

# 4 AVI = [NIR*(1-RED)*(NIR-RED)]^(1/3)
aviFunc <- (aoiRaster[[4]]*(1-aoiRaster[[3]])*(aoiRaster[[4]]-aoiRaster[[3]]))
avi <- aviFunc^(1/3)
avi
plot(avi)

# 5 SAVI = ((NIR-RED)/(NIR+RED+0.5))*(1.5)
savi <- ((aoiRaster[[4]]-aoiRaster[[3]])/(aoiRaster[[4]]+aoiRaster[[3]]+0.428))*1.428
savi
plot(savi)

# 6 NDMI = ((NIR-SWIR)/(NIR+SWIR)
ndmi <- (aoiRaster[[4]]-aoiRaster[[6]])/(aoiRaster[[4]]+aoiRaster[[6]])
ndmi
plot(ndmi)

# 7 MSI = (MidIR/NIR)
msi <- (aoiRaster[[6]]/aoiRaster[[4]])
msi
plot(msi)

# 8 GCI = (NIR/Green)-1
gci <- ((aoiRaster[[4]]/aoiRaster[[2]])-1)
gci
plot(gci)

# 9 NBRI = (NIR-SWIR2)/(NIR+SWIR2)
nbri <- ((aoiRaster[[4]]-aoiRaster[[7]])/(aoiRaster[[4]]+aoiRaster[[7]]))
nbri
plot(nbri)

#10 BSI = (((RED+SWIR1)-(NIR+Blue))/((Red+SWIR1)+(NIR+Blue)))
bsi <- ((aoiRaster[[6]]+aoiRaster[[3]])-(aoiRaster[[4]]+aoiRaster[[1]])/
          (aoiRaster[[6]]+aoiRaster[[3]])+(aoiRaster[[4]]+aoiRaster[[1]]))
bsi
plot(bsi)

#11 NDWI = ((NIR-SIR)/(NIR+SWIR))
ndwi <- ((aoiRaster[[2]]-aoiRaster[[4]])/(aoiRaster[[2]]+aoiRaster[[4]]))
ndwi
plot(ndwi)

#12 NDSI = (Green-SIR)/(Green+SWIR))
ndsi <- ((aoiRaster[[2]]-aoiRaster[[6]])/(aoiRaster[[2]]+aoiRaster[[6]]))
ndsi
plot(ndsi)

# 13.NDGI = ((Green-Red)/(Green+Red))
ndgi <- ((aoiRaster[[2]]-aoiRaster[[3]])/(aoiRaster[[2]]+aoiRaster[[3]]))
ndgi
plot(ndgi)

# 14.ARVI = ((NIR-(2*Red)+Blue)/(NIR+(2*Red)+Blue))
arvi <- ((aoiRaster[[4]]-(2*aoiRaster[[3]])+aoiRaster[[1]])/(aoiRaster[[4]]+(2*aoiRaster[[3]])+aoiRaster[[1]]))
arvi
plot(arvi)

# 15. SIPI = (NIR-Blue)/(NIR-Red)
sipi <- ((aoiRaster[[4]]-aoiRaster[[1]])/(aoiRaster[[4]]-aoiRaster[[3]]))
sipi
plot(sipi)

# Save file on disk
saveFile <- writeRaster(ndvi, "plotted.tif", format = "GTiff", datatype = "FLT4S", overwrite = TRUE)
