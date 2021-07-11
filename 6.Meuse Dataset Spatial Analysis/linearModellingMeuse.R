# 1.----- STEP 1 Introduction ---------------- #

# Lineaar Modelling of spatila Data  to explain the distribution of zinc concentration within the site.
# Clear memory and load aster data packages
rm(list = ls(all=TRUE))

#.------- STEP 2. R geostatistics packages-----#

library(sp) # Contains the Meuse data
library(lattice) #plotting graphics
library(ggplot2)
library(scales)
library(gstat)
library(sf)
library(GGally)
library(cowplot) #To plot the correlations

# 3. Spatial Data frames
data(meuse)## loading data
# Transform into a collection of simple features(SF) with attributes and geometries in the form of a df.
summary(meuse)
class(meuse)

meuse = st_as_sf(meuse,coords=c("x","y"),remove=FALSE)
# Descriptive statistics of the meuse dataset

#.------- STEP 3. View the spatial dataset on Meuse Map -- #
#1. Loading gridded data
data(meuse.grid) 
coordinates(meuse.grid) = c("x", "y")
gridded(meuse.grid) = TRUE
class(meuse.grid)

#2. Transform gridded data into Spatial Pixels
meuse.grid = as(meuse.grid, "SpatialPixels") 

#3. loading Meuse river data
data(meuse.riv) 
meuse.lst = list(Polygons(list(Polygon(meuse.riv)),"meuse.riv"))

#4. Plot Zinc concentration on the floodplain along the Meuse River.
meuse.sr = SpatialPolygons(meuse.lst) 
image(meuse.grid, col = "yellowgreen")

#5. plot the river data
plot(meuse.sr, col = "grey", add = TRUE)

#6. plot the zinc dataset
plot(meuse[,c('zinc')], add = TRUE, cex=1.5)
#7. Add title
title("Meuse Data")

# ---------- STEP 4 ----------------- #
# Perform ESDA to visualize the data so that we can assess how to look at the problem.
#1.Transforming back the sf object into a data frame
st_geometry(meuse) = NULL 

#2. Print correlations between quantitative variables, 
ggpairs(meuse[,3:9])

## We can see that Zinc has the highest R2 values, therefore we go for it in this spatial modeling

# --------------- STEP 5 SPREAD, LOG Transform, Representation of VARIATION---------------- #
# Create a new grid function to plot the zinc statistics individually, : zinc, 
# Relationships between zinc concentration and the qualitative variables flood frequency, soil type, lime class and LULCC
#3. Plot zinc against elevation and log zinc against elev
plot_grid(
  ggplot(meuse, aes(y = zinc, x = elev)) + geom_point(),
  ggplot(meuse, aes(y = log(zinc), x = elev)) + geom_point(),
  nrow = 1, ncol = 2)

#3. Plot zinc against lag and log zinc against lag and log zinc against sqrt()
plot_grid(
  ggplot(meuse, aes(y = zinc, x = dist)) + geom_point(),
  ggplot(meuse, aes(y = log(zinc), x = dist)) + geom_point(),
  ggplot(meuse, aes(y = log(zinc), x = sqrt(dist))) + geom_point(),
  nrow = 1, ncol = 3)

#3. Plot representation of variation using the Boxplot
plot_grid(
  ggplot(meuse, aes(y = log(zinc), x = ffreq)) + geom_boxplot(),
  ggplot(meuse, aes(y = log(zinc), x = soil)) + geom_boxplot(),
  ggplot(meuse, aes(y = log(zinc), x = lime)) + geom_boxplot(),
  ggplot(meuse, aes(y = log(zinc), x = landuse)) + geom_boxplot(),
  nrow = 2, ncol = 2)

# --------------- STEP 6 LINEAR MODELLING-------------

#3 quantitative variables (elevation over thesite, squared distance to the river, organic matter content) AND
#3 qualitative variables (frequency of flooding, soil type, and presence or absence of limestone) affect the zinc concentration on the study plain.

# Randomly allocate the zinc concentration to different locations and see the relatively flat experimental variogram, showing no correlations.
# Model how IDW affects the distance
levels(meuse$ffreq) <- paste("ffreq", levels(meuse$ffreq), sep="")
levels(meuse$soil) <- paste("soil", levels(meuse$soil), sep="")
str(meuse)

palette(trellis.par.get("superpose.symbol")$col)
plot(zinc~dist, meuse, pch=as.integer(ffreq), col=soil)

# Add lattice legend at the topright
legend("topright", col=c(rep(1, nlevels(meuse$ffreq)), 1:nlevels(meuse$soil)),
       pch=c(1:nlevels(meuse$ffreq), rep(1, nlevels(meuse$soil))), bty="n",
       legend=c(levels(meuse$ffreq), levels(meuse$soil)))

xyplot(log(zinc)~dist | ffreq, meuse, groups=soil, panel=function(x, y, ...)
{
  panel.xyplot(x, y, ...)
  panel.loess(x, y, ...)
}, 
auto.key=TRUE)