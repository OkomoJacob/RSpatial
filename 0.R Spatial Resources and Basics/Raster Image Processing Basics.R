# To install packages
install.packages("raster")
install.packages("rgdal")

#Add Library
library(raster)     #raster
library(rgdal)      #vector

#Read and plot data (L8 Data)
a<-"D:/Landsat_image/LT05_L1TP_139046_20050303/LT05_L1TP_139046_20050303_20161128_01_T1_B1.TIF"
a
??raster
a1<-raster(a)
a1

a4<-raster("D:/Landsat_image/LT05_L1TP_139046_20050303/LT05_L1TP_139046_20050303_20161128_01_T1_B4.TIF")
a4
?plot
plot(a4)
?dim
dim(a4)		#dimension of data, row, column and band


#Set Working directory
setwd("D:/Landsat_image/LT05_L1TP_139046_20050303")
getwd()



#Read bulk data
bands<-list.files(pattern=".TIF")
bands
bands[[2]]      # select layer2 from list

band2<-raster(bands[[2]])


#Layer stack; band selection; plot
sfcc<-stack(bands[1],bands[2],bands[3],bands[4],bands[5],bands[7])
sfcc
sfcc[[4]]      # select layer 4 from stack
plot(sfcc[[3]])
plotRGB(sfcc, 4,3,2)
plotRGB(sfcc, 4,3,2, stretch='lin')
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
