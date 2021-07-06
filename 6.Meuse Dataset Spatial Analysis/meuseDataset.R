# Import the 2 packages
library(sp)
library(lattice)
library(ggplot2)
library(scales)
library(gstat)

# call the meuse data
data(meuse)
coordinates(meuse) <- c("x", "y")

load(system.file("data", "meuse.rda", package = "sp"))

#create a categorical variable
meuse$zinc_cat <-cut(meuse$zinc, breaks = c(0,200,400,800,1200,2000))
zinc.plot <- ggplot(aes(x=x, y=y), data = meuse)

zinc.plot<-zinc.plot+geom_point(aes(color = zinc_cat))

zinc.plot <- zinc.plot+coord_equal()

zinc.plot <- zinc.plot+scale_color_brewer(pallete = "YlGnBu")

zinc.plot






# Predict topsoil zinc concentration using spplot & bubble plots
spplot(meuse, "zinc", do.log = T, colorkey = TRUE)
bubble(meuse, "zinc", do.log = T, key.space = "right")

data("meuse.grid")
coordinates(meuse.grid) <- c("x", "y")
meuse.grid <- as(meuse.grid, "SpatialGridDataFrame")


# Import the gstat pkg to perform the IDW
idw.out <- idw(zinc~1, meuse, meuse.grid, idp=2)

## inverse distance weighted interpolation
as.data.frame(idw.out)[1:5,]

# Linear regression Models for Predictions
xyplot(log(zinc) ~ sqrt(dist), as.data.frame(meuse))

# Fitting the Linear Models
zn.lm <- lm(log(zinc) ~ sqrt(dist), meuse)
meuse$fitted.s <- predict(zn.lm,meuse) - mean(predict(zn.lm,meuse))
meuse$residuals <- residuals(zn.lm)
spplot(meuse, c("fitted.s", "residuals"))

## Estimate spatial correlation: variogram
hscat(log(zinc)~1,meuse,(0:9)*100)

#Experimental Variogram
plot(variogram(log(zinc)~1,meuse),type="h")

# Randomly allocate the zinc concentration to different locations and see the relatively flat experimental variogram, showing no correlations.
data <- meuse
n <- nrow(meuse)
set.seed(15)
ind <- sample(1:n, size=n, replace = F)
data$zinc <- meuse$zinc[ind]
plot(variogram(log(zinc)~1, data), type="l")



















