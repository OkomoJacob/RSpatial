#Clear memory
rm(list=ls(all=TRUE))

# Set and get your workong Dir
setwd("D:/STUDY/4.GIS/G I S 4.1/6.RS Applications/Assignments/Tanzania/INPUT/L8_Ngara_TZ_Ag_2020")
getwd()

# Read your wDir Contents
contents <- list.files()
contents
install.packages(c("raster", "RStoolbox"))

# Load your pkges
library(raster)
library(RStoolbox)
## Import meta-data and bands based on MTL file
mtlFile  <- system.file("L8_T1_MTL.txt")
class(mtlFile)
metaData <- readMeta(mtlFile)
lsat     <- stackMeta(mtlFile)


## Convert DN to top of atmosphere reflectance and brightness temperature
lsat_ref <- radCor(lsat, metaData = metaData, method = "apref")

## Correct DN to at-surface-reflecatance with DOS (Chavez decay model)
lsat_sref <- radCor(lsat, metaData = metaData, method = "dos")

## Correct DN to at-surface-reflecatance with simple DOS 
## Automatic haze estimation
hazeDN    <- estimateHaze(lsat, hazeBands = 1:4, darkProp = 0.01, plot = TRUE)
lsat_sref <- radCor(lsat, metaData = metaData, method = "sdos", 
                    hazeValues = hazeDN, hazeBands = 1:4)