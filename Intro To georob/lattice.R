library(sp)
data(meuse, package="sp")
levels(meuse$ffreq) <- paste("ffreq", levels(meuse$ffreq), sep="")
levels(meuse$soil) <- paste("soil", levels(meuse$soil), sep="")
str(meuse)
library(lattice)
palette(trellis.par.get("superpose.symbol")$col)
plot(zinc~dist, meuse, pch=as.integer(ffreq), col=soil)

legend("topright", col=c(rep(1, nlevels(meuse$ffreq)), 1:nlevels(meuse$soil)),
       pch=c(1:nlevels(meuse$ffreq), rep(1, nlevels(meuse$soil))), bty="n",
       legend=c(levels(meuse$ffreq), levels(meuse$soil)))
              
xyplot(log(zinc)~dist | ffreq, meuse, groups=soil, panel=function(x, y, ...)
  {
  panel.xyplot(x, y, ...)
  panel.loess(x, y, ...)
  }, 
auto.key=TRUE)
