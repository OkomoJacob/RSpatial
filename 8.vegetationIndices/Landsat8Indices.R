# Raster, NDVI, NDVI Threshold 
rm(list = ls(all=TRUE)) #clear memory
library(raster)
library(rgdal)

# import default proj dir and Check path contants
path <- setwd("C:/Users/okomo/workingDirHere")
path <-getwd()
path
contents <- length(list.files(path))
contents

aoiRaster <- ".tif"
aoiRaster

# Denote as Multiraster data
aoiRaster <-stack(aoiRaster)
aoiRaster

# 1. NDVI = ((NIR-RED)/(NIR+RED))
ndvi <- (aoiRaster[[5]]-aoiRaster[[4]])/(aoiRaster[[5]]+aoiRaster[[4]])
ndvi
plot(ndvi)

# 2. GNDVI = ((NIR-G)/(NIR+G))
gndvi <- (aoiRaster[[5]]-aoiRaster[[3]])/(aoiRaster[[5]]+aoiRaster[[3]])
gndvi
plot(gndvi)

# 3. EVI = 2.5*((NIR-RED)/((NIR+6*RED-7.5*BLUE)+1))
eviNum <- aoiRaster[[5]]-aoiRaster[[4]]
eviDen <- (aoiRaster[[5]]+6*aoiRaster[[4]]-7.5*aoiRaster[[2]]+1)
evi <- 2.5*(eviNum/eviDen)
evi
plot(evi)

# 4. AVI = [NIR*(1-RED)*(NIR-RED)]^(1/3)
aviFunc <- (aoiRaster[[5]]*(1-aoiRaster[[4]])*(aoiRaster[[5]]-aoiRaster[[4]]))
avi <- aviFunc^(1/3)
avi
plot(avi)

# 5. SAVI = ((NIR-RED)/(NIR+RED+0.5))*(1.5)
savi <- ((aoiRaster[[5]]-aoiRaster[[4]])/(aoiRaster[[5]]+aoiRaster[[4]]+0.5))*1.5
savi
plot(savi)

# 6. NDMI = ((NIR-SWWIR)/(NIR+SWIR)
ndmi <- (aoiRaster[[5]]-aoiRaster[[6]])/(aoiRaster[[5]]+aoiRaster[[6]])
ndmi
plot(ndmi)

# 7. MSI = (MidIR/NIR)
msi <- (aoiRaster[[6]]/aoiRaster[[5]])
msi
plot(msi)

# 8. GCI = (NIR/Green)-1
gci <- ((aoiRaster[[5]]/aoiRaster[[3]])-1)
gci
plot(gci)

# 9. NBRI = (NIR-SWIR2)/(NIR+SWIR2)
nbri <- ((aoiRaster[[5]]-aoiRaster[[7]])/(aoiRaster[[5]]+aoiRaster[[7]]))
nbri
plot(nbri)

# 10. BSI = (((RED+SWIR1)-(NIR+Blue))/((Red+SWIR1)+(NIR+Blue)))
bsi <- ((aoiRaster[[4]]+aoiRaster[[6]])-(aoiRaster[[5]]+aoiRaster[[2]])/
          (aoiRaster[[6]]+aoiRaster[[4]])+(aoiRaster[[5]]+aoiRaster[[2]]))
bsi
plot(bsi)

# 11. NDWI = ((NIR-SIR)/(NIR+SWIR))
ndwi <- ((aoiRaster[[3]]-aoiRaster[[5]])/(aoiRaster[[3]]+aoiRaster[[5]]))
ndwi
plot(ndwi)

# 12. NDSI = (Green-SIR)/(Green+SWIR))
ndsi <- ((aoiRaster[[3]]-aoiRaster[[6]])/(aoiRaster[[3]]+aoiRaster[[6]]))
ndsi
plot(ndsi)

# 13.NDGI = ((Green-Red)/(Green+Red))
ndgi <- ((aoiRaster[[3]]-aoiRaster[[4]])/(aoiRaster[[3]]+aoiRaster[[4]]))
ndgi
plot(ndgi)

# 14.ARVI = ((NIR-(2*Red)+Blue)/(NIR+(2*Red)+Blue))
arvi <- ((aoiRaster[[5]]-(2*aoiRaster[[4]])+aoiRaster[[2]])/(aoiRaster[[5]]+(2*aoiRaster[[4]])+aoiRaster[[2]]))
arvi
plot(arvi)

# 15. SIPI = (NIR-Blue)/(NIR-Red)
sipi <- ((aoiRaster[[5]]-aoiRaster[[2]])/(aoiRaster[[5]]-aoiRaster[[4]]))
sipi
plot(sipi)

# Save file on disk
saveFile <- writeRaster(ndvi, "ngaraNDVI.tiff", format = "GTiff", datatype = "FLT4S", overwrite = TRUE)
