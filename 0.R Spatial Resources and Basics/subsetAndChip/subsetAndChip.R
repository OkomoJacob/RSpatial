# Install the required packages
# Landsat| Subset| Crop| Musk| Mosaic| DN value| Pixel Value| Multispectral| for loop| R
rm(list = ls(all=TRUE)) #clear memory
install.packages(c("raster", "rgdal"))

# Import the packages for raster img analysis
library(raster)     #raster
library(rgdal)      #vector

setwd("D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8NgaraTiffs")
getwd()
content <- list.files()
length(content)
# Read and plot data (L8 Data)

layerStacked <- stack("L8NgLayerStack.tif")
layerStacked

# plot a single band
plot(layerStacked[[5]], main = "NIR Band")

# Subset Starts Here
# 1. By custom extent
rectExtnt = extent(214885, 352615, -206315, -120085)  #(xmin, xmax, ymin, ymax)
rectExtnt
plot(rectExtnt, add = TRUE)
# Crop
layerStacked <-crop(layerStacked, rectExtnt)
plotRGB(layerStacked, 4,3,2, scale=65535, stretch = 'lin', main = "RGB Croped")

# 2. By shapefile
list.files()

# load shp
shp <- readOGR("shapefiles - Reprj/Ngara.shp")
shp
plotRGB(layerStacked, 4,3,2, scale=65535, stretch = 'lin', main = "RGB Croped")
plot(shp, add = TRUE)
croppedLyrStck <- crop(layerStacked, shp)
croppedLyrStck

#Plot cropped Area
