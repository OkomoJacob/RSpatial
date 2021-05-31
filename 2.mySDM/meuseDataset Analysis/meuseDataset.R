# Import the 2 packages
library(sp)
library(lattice)

# call the meuse data
data(meuse)
coordinates(meuse) <- c("x", "y")

# Predict topsoil zinc concentration
spplot(meuse, "zinc", do.log = T, colorkey = TRUE)
