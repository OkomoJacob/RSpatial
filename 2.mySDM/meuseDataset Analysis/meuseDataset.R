# Import the 2 packages
library(sp)
library(lattice)

# call the meuse data
data("meuse")
coordinates(meuse) <- c("x", "Y")

# Predict topsoil zinc concentration