install.packages("rcompanion")
library(sp)

pacman::p_load(gstat, sp)
data(meuse)
df <- meuse
knitr::kable(head(df, n=5), align = 'l')

#Load existing/install missing libraries
if (!require("pacman")) install.packages("pacman")
pacman::p_load3
data(meuse)
df <- meuse
knitr::kable(head(df, n=3), align = 'l')


x <- rnorm(100 ,mean=5, sd=0.5) 
histogramPlot <- hist(x,breaks=150,xlim=c(0,20),freq=FALSE)
histogramPlot
abline(v=10, lwd=5)
abline(v=c(4,6,8,12,14,16), lwd=3,lty=3)

# Create a sequence of numbers between -10 and 10 incrementing by 0.2.
x <- seq(-10,10,by = .2)
# Choose the mean as 2.5 and standard deviation as 2. 
y <- pnorm(x, mean = 2.5, sd = 2)
# Plot the graph.
plot(x,y)

# Normal QQ plots
qqnorm(meuse$copper, main='Copper in Meuse River', xlab = 'Copper', ylab = 'Frequency')
qqline(meuse$copper)

# Both Normal and Histogram at once using the rcompanion package
install.packages("rcompanion")
library(rcompanion)
help(plotNormalHistogram)
# Normal Distribution

plotNormalHistogram(meuse$zinc)

# Data transformation
# 1 Log transform
logZinc <- log(meuse$zinc)
plotNormalHistogram(logZinc, "Log Transform")

# 2. Sqrt
sqroot <- sqrt(meuse$zinc)
plotNormalHistogram(sqroot, main = "SquareRoot Transform")

3.