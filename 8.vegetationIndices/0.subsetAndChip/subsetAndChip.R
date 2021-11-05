# Install the required packages
install.packages("stars")

# Import the packages for raster img analysis
library(raster)     #raster
library(rgdal)      #vector
setwd("D:/STUDY/4.GIS/G I S 4.1/6.RS Applications/Assignments/Tanzania/OUTPUT")
getwd()

#Read contents
contents <- list.files()
contents

# Load the Layerstacked Image into R Studio
raster <- brick("L8LayerStack.tif",scale = 65535, stretch = 'lin')
raster

#readshapefile
shp <- readOGR("Ngara/Ngara.shp")

# plot
plotRGB(raster, stretch = 'lin')

plotRGB(shp, add = T)
