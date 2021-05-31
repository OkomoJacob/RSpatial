# Import the 2 packages
library(sp)
library(lattice)

# call the meuse data
data(meuse)
coordinates(meuse) <- c("x", "y")

# Predict topsoil zinc concentration using spplot & bubble plots
spplot(meuse, "zinc", do.log = T, colorkey = TRUE)
bubble(meuse, "zinc", do.log = T, key.space = "right")
