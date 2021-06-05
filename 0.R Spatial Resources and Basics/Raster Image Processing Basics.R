# Install the required packages
install.packages(c("raster", "rgdal"))

# Import the packages for raster img analysis
library(raster)     #raster
library(rgdal)      #vector

#Read and plot data (L8 Data)
L8_b1 <- "D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8/168061-L82019/LC08_B1.TIF"

# Have a look at data type
class(L8_b1)

# Transform into raster layer
??raster
L8_b1 <- raster(L8_b1)
L8_b1

L8_b4 <- raster("D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8/168061-L82019/LC08_B4.TIF")
L8_b4

# Plot the raster band on the side pannel
?plot
plot(L8_b1, main = "Landsat 8, Band 1")

# Obtain the dimension(nrow, ncol, bands) of data
?dim
dim(L8_b1)		

# For batch processing, preset your .tif directory
setwd("D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8/168061-L82019")
getwd()

#Bulk read all the .tif raster images in that dir
allBands <- list.files(pattern = ".TIF")
length(allBands)

# select layer8 from list
allBands[[10]]
metaBand8 <- raster(allBands[[10]])
metaBand8

# 1, 2, 3,4,5,6,7 
allBands[[1]] allBands[[4]] allBands[[5]] allBands[[6]] allBands[[7]] allBands[[8]] allBands[[9]]
# Preprocessing : Layerstack, bandSelection, plot
lyrStack <- stack(allBands[1], allBands[4], allBands[5], allBands[6], allBands[7], allBands[8], allBands[9])
# View the metadata of the Layerstacked images
metaLyrStack <- lyrStack
metaLyrStack

# Select RED(B5) from stack
lyrStack[[7]] 
plot(lyrStack[[7]], main = "Landsat 8 Band 5")

# Plot RGB Natural color
plotRGB(lyrStack, 4,3,2, scale=65535, main = "L8 Natural Color: BGR")
plotRGB(lyrStack, 4,3,2, stretch='lin')
?plotRGB
?writeRaster
writeRaster(sfcc, "Landsat_5.tif", format="GTiff", datatype='INT1U', overwrite=TRUE)

#READ LANDSAT 8 Data
setwd("D:/Landsat_image/LC08_L1TP_139046_20150227")
getwd()

#Read bulk data
bands<-list.files(pattern=".TIF")
bands
bands[[4]]      # select Blue band from list


#Layer stack; band selection; plot
sfcc<-stack(bands[4],bands[5],bands[6],bands[7])
sfcc
sfcc[[4]]      # select layer 4 from stack
plot(sfcc[[4]])
plotRGB(sfcc, 4,3,2)
plotRGB(sfcc, 4,3,2, scale=65535)
plotRGB(sfcc, 4,3,2, scale=65535, stretch='lin')
writeRaster(sfcc, "Landsat_8.tif", 
            format="GTiff", datatype='INT2U', overwrite=TRUE)


L8<-brick("Landsat_8.tif")
L8
