# Install the required packages
install.packages(c("raster", "rgdal"))

# Import the packages for raster img analysis
library(raster)     #raster
library(rgdal)      #vector

#Read and plot data (L8 Data)
L8_b1 <- "D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8/168061-L82019/LC08_B01.TIF"

# Have a look at data type
class(L8_b1)

# Transform into raster layer
??raster
L8_b1 <- raster(L8_b1)
L8_b1

L8_b4 <- raster("D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/INPUT/L8/168061-L82019/LC08_B04.TIF")
L8_b4

# Plot the raster band on the side panel
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
allBands
# select layer8 from list
allBands[[8]]
metaBand8 <- raster(allBands[[10]])
metaBand8

# 1, 2, 3,4,5,6,7 
allBands[[1]] allBands[[2]] allBands[[3]] allBands[[4]] allBands[[5]] allBands[[6]] allBands[[7]]

# Preprocessing : Layerstack(All bands must have same spatial resolutions), bandSelection, plot
lyrStack <- stack(allBands[1], allBands[2], allBands[3], allBands[4], allBands[5], allBands[6], allBands[7])

# View the metadata of the layerstacked images
metaLyrStack <- lyrStack
metaLyrStack

# Select RED(B5) from stack
lyrStack[[4]] 
plot(lyrStack[[7]], main = "Landsat 8 Band 5")

# Plot RGB Natural color
plotRGB(lyrStack, 4,3,2, scale=65535, main = "L8 Natural Color: BGR")

# Apply linear stretch for haze reduction
plotRGB(lyrStack,
        r = 4, g = 3, b = 2, 
        scale=800,
        stretch = "lin")

# What does plotRGB & writeRaster function does?
?plotRGB
?writeRaster

# Save the file to disk
writeRaster(lyrStack, "L8LayerStack.tif", format="GTiff", datatype='INT2U', overwrite=TRUE)

# Load the Layerstacked Image into R Studio
L8<-brick("Landsat_8.tif")
L8
