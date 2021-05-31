# Import the 2 packages
library(sp)
library(lattice)

# call the meuse data
data(meuse)
coordinates(meuse) <- c("x", "y")

# Predict topsoil zinc concentration using spplot & bubble plots
spplot(meuse, "zinc", do.log = T, colorkey = TRUE)
bubble(meuse, "zinc", do.log = T, key.space = "right")

data("meuse.grid")
coordinates(meuse.grid) <- c("x", "y")
meuse.grid <- as(meuse.grid, "SpatialGridDataFrame")
library(gstat)

# Import the gstat pkg to perform the IDW
idw.out <- idw(zinc~1, meuse, meuse.grid, idp=2)

## inverse distance weighted interpolation
as.data.frame(idw.out)[1:5,]

# Linear regression Models for Predictions
xyplot(log(zinc) ~ sqrt(dist), as.data.frame(meuse))

# Fitting the Linear Models
zn.lm <- lm(log(zinc) ~ sqrt(dist), meuse)















