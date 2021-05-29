# Import the geostats libraries
library(sp)
library(lattice)

#call the meuse R data
data(meuse, package="sp")

#ffreq = flooding freeny

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
