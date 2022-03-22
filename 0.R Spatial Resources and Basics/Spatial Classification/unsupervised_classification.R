# set the working directories for our files
setwd('D:/Remote sensing/Remote sensing')
library(raster)

# set the extent
e<-extent(838332.7134,862990.3004,-51152.68162,-22688.83612)


#load the raster files
b1<- raster('Band 1.tif')
b2<- raster('Band 2.tif')
b3<- raster('Band 3.tif')
b4<- raster('Band 4.tif')
b5<- raster('Band 5.tif')
b6<- raster('Band 6.tif')
b7<- raster('Band 7.tif')

landsat<-stack(b1,b2,b3,b4,b5,b6,b7)

#crop the image with the given coordinates
landsatcrop=crop(landsat,e)

#TRUE COLOR COMPOSITE
#png(filename="truecolcrop.png", width=480,height=480)
truecol<-stack(b4,b3,b2)
lantrue=crop(truecol,e)
plotRGB(lantrue,axes=TRUE,stretch='lin',main="TRUE COLOUR COMPOSITE")
#dev.off()

#FALSE COLOR COMPOSITE
#png(filename='falsecol.png',width=480,height=480)
falsecol<-stack(b6,b4,b3)
lanfalse=crop(falsecol,e)
writeRaster(lanfalse, filename="falsecrop-landsat.tif", overwrite=TRUE)
plotRGB(lanfalse,axes=TRUE,stretch='lin',main="False colour composite")
#dev.off()

#CALCULATE NDWI
ndwi<-(landsatcrop[[3]]-landsatcrop[[5]])/(landsatcrop[[3]]+landsatcrop[[5]])

#plot NDWI
#png(filename='NDWI.png',height=300,width=300)
plot(ndwi,main="NDWI")
#dev.off()

#convert ndwi to a matrix that we are going to use in the classification
nr<-getValues(ndwi)
str(nr)

#Set random points
set.seed(99)
#create 4 clusters, 500 iterations,starting with 5 random sets using 'Lloyd' algorithm
kmncluster<-kmeans(na.omit(nr),centers=4, iter.max=500,nstart=2,algorithm='Lloyd')
str(kmncluster)

#use the ndwi object to set the cluster values to a new cluster
knr<-setValues(ndwi,kmncluster$cluster)
#you can also do it like this
knr<-raster(ndwi)
values(knr)<-kmncluster$cluster
knr



# Define a color vector for 10 clusters (learn more about setting the color later)
mycolor <- c('green','brown','red','blue')


#read CSV file
list.files()
data<-read.csv(file = 'Sample_points.csv')
head(data)

#plot the classification
png(filename='LULClandsat.png')
plot(knr, main='LAND USE LAND COVER (Landsat)',col=mycolor, axes=TRUE)
legend(x='bottom',y='left', legend=c('Vegetation','Bareland ','Urban','Water'),
       col=mycolor,text.col = 'black',pch=15,cex=0.7,inset=0.01)
points(data$X,data$Y,pch=19,col='white',cex=0.7)
text(data$X,data$Y, labels=data$ID,cex=0.9,col='black',offset=0.2, font=2,pos=4)
dev.off()



