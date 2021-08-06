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
summary(mydata)                                # confirms a spatial points dataframe
head(coordinates(mydata))                      # check the first several coordinates
