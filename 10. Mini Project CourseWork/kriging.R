# Clear memory
rm(list=ls(all=TRUE))
## Load the required libraries¶
library(gstat)                              # geostatistical methods by Edzer Pebesma
library(sp)                                 # spatial points addition to regular data frames
library(plyr)                               # manipulating data by Hadley Wickham

#Set the working directory
setwd("D:/STUDY/4.GIS/G I S 4.1/2.Geostats/0x520x/10. Mini Project CourseWork")
getwd()

# Specify the 2D grid parameters
nx = 400                                       # number of cells in the x direction
ny = 400                                       # number of cells in the y direction
xmin = 5.0                                     # x coordinate of lower, left cell center 
ymin = 5.0                                     # y coordinate of lower, left cell center 
xsize = 10.0                                   # extent of cells in x direction
ysize = 10.0                                   # extent of cells in y direction

# Declare functions
nscore <- function(x) {                        # by Ashton Shortridge, 2008
  # Takes a vector of values x and calculates their normal scores. Returns 
  # a list with the scores and an ordered table of original values and
  # scores, which is useful as a back-transform table. See backtr().
  nscore <- qqnorm(x, plot.it = FALSE)$x  # normal score 
  trn.table <- data.frame(x=sort(x),nscore=sort(nscore))
  return (list(nscore=nscore, trn.table=trn.table))
}

# This function builds a spatial points dataframe with the locations for estimation 
addcoord <- function(nx,xmin,xsize,ny,ymin,ysize) { # Michael Pyrcz, March, 2018                      
  # makes a 2D dataframe with coordinates based on GSLIB specification
  coords = matrix(nrow = nx*ny,ncol=2)
  ixy = 1
  for(iy in 1:nx) {
    for(ix in 1:ny) {
      coords[ixy,1] = xmin + (ix-1)*xsize  
      coords[ixy,2] = ymin + (iy-1)*ysize 
      ixy = ixy + 1
    }
  }
  coords.df = data.frame(coords)
  colnames(coords.df) <- c("X","Y")
  coordinates(coords.df) =~X+Y
  return (coords.df)
}

#Read the data table
mydata = read.csv("finalData/Ghaziabad.csv")          # read in comma delimited data file
head(mydata)                                # preview first several rows in the console

# Data preparation and cleaning
# Define the X and Y coordinates to convert the dataframe to a spatial points dataframe

class(mydata)                              # confirms that it is a dataframe
coordinates(mydata) = ~X+Y                 # indicate the X, Y spatial coordinates
# Check the dataset summary statistics and visualizing 1st few samples
summary(mydata)                            # confirms a spatial points dataframe
head(coordinates(mydata))                  # check the first several coordinates


# For of the experimental variograms we often work with Gaussian transformed data.This gives a better simulation
npor.trn = nscore(mydata$PM2_5)               # normal scores transform
mydata[["NPM2.5"]]<-npor.trn$nscore # append the normal scores transform 
head(mydata)                                  # check the result

# summary statistics of the new variable.
summary(mydata$NPM2.5)

# Visualize the original PM2.5 data distribution VS distribution of the normal score transform PM2.5 data
par(mfrow=c(2,2))                              # set up a 2x2 matrix of plots 
hist(mydata$PM2_5,main="Particulate Matter 2.5",xlab="PM 2.5 ug/m3",nclass = 15) # histogram
plot(ecdf(mydata$PM2_5),main="NPM2_5",xlab="PM 2.5 ug/m3",ylab="Cumulative Probability") # CDF
hist(mydata$NPM2.5,main="N[PM2.5 ug/m3]",xlab="N[PM 2.5 ug/m3]",nclass = 15) # histogram
plot(ecdf(mydata$NPM2.5),main="N[PM 2.5 ug/m3]",xlab="N[PM 2.5 ug/m3]",ylab="Cumulative Probability") #CDF

# Spatial visualization
cuts = c(.05,.07,.09,.11,.13,.15,.17,.19,.21,.23)
cuts.var = c(0.05,.1,.15,.20,.25,.3,.35,.4,.45,.5,.55,.6,.65,.7,.75,.8,.85,.9,.95)

# Now the bubble plot.

  bubble(mydata, "porosity", fill = FALSE, maxsize = 2, main ="Porosity (%)", identify = FALSE,xlab = "X (m)", ylab = "Y (m)")

spplot(mydata, "PM2_5", do.log = TRUE,      # location map of porosity data
       key.space=list(x=.85,y=0.97,corner=c(0,1)),cuts = cuts,
       scales=list(draw=T),xlab = "X (m)", ylab = "Y (m)",main ="NPM2.5 ug/m3")

# Modeling spatial continuity
# We will use the anisotropic variogram models

por.vm.ani <- vgm(psill = 0.6, "Exp", 800, anis = c(035, 0.5),nugget=0.4)
por.vm.ani                                     # check the variogram model parameters

# Visualize our anisotropic experimental and model variograms.
name = c("035","125")                          # make name matrix
color = c("blue","red")                        # make color matrix

por.vg.035 = variogram(NPM2.5~1,mydata,cutoff = 3000,width =500,alpha = 35.0,tol.hor=22.5) # 035 directional 
por.vg.125 = variogram(NPM2.5~1,mydata,cutoff = 3000,width =500,alpha = 125.0,tol.hor=22.5) # 125 directional

plot(por.vg.035$dist,por.vg.035$gamma,main="NPM2.5 Anisotropic Variogram",xlab="  Lag Distance (m) ",ylab=" Semivariogram ",pch=16,col=color[1],ylim=c(0,1.2))
points(por.vg.125$dist,por.vg.125$gamma,pch=16,col=color[2])
abline(h = 1.0)

unit_vector = c(sin(35*pi/180),cos(35*pi/180),0) # unit vector for 035 azimuth
vm.ani.035 <- variogramLine(por.vm.ani,maxdist=3000,min=0.0001,n=100,dir=unit_vector,covariance=FALSE) # model at 035
lines(vm.ani.035$dist,vm.ani.035$gamma,col=color[1]) # include variogram model 

unit_vector = c(sin(55*pi/180),-1*cos(35*pi/180),0) # unit vector for 125 azimuth
vm.ani.125 <- variogramLine(por.vm.ani,maxdist=3000,min=0.0001,n=100,dir=unit_vector,covariance=FALSE) # model at 125 
lines(vm.ani.125$dist,vm.ani.125$gamma,col=color[2]) # include variogram model
legend(2000,.8,name, cex=0.8, col=color,pch=c(16,16,16),lty=c(1,1,1)) # add legend
