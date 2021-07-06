# Clear memory
rm(list=ls(all=TRUE))
#Load existing/install missing libraries
if (!require("pacman", "rcompanion")) install.packages("pacman", "rcompanion")


library(sp)
library(rcompanion)
pacman::p_load(gstat, sp)
data <- data(meuse)
df <- meuse
knitr::kable(head(df, n=3), align = 'l')

x <- rnorm(100 ,mean=5, sd=0.5) 
histogramPlot <- hist(x,breaks=150,xlim=c(0,20),freq=FALSE)
histogramPlot
abline(v=10, lwd=5)
abline(v=c(4,6,8,12,14,16), lwd=3,lty=3)

# Create a sequence of numbers between -10 and 10 increamenting by 0.2.
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
help(plotNormalHistogram)
# Normal Distribution

plotNormalHistogram(
  meuse$zinc, 
  main = "Original Data",
  prob = FALSE,
  col = "gray",
  linecol = "blue",
  )

# Data transformation
#Divide the screen in 2 columns and 2 lines
par(mfrow=c(2,2))
# Plot original Data
plotNormalHistogram(meuse$zinc, main = "Original Data")

# 1 Log transform(NB : log(0) is infinity, so avoid that by adding 1 to 0 numbers)
logZinc <- log(meuse$zinc + 1)
plotNormalHistogram(logZinc, main = "Log Transform")

# 2. Sqrt
sqroot <- sqrt(meuse$zinc)
plotNormalHistogram(sqroot, main = "Sqrt Transform")

# 3. Angular
angular <- asin(sqrt(meuse$zinc / max(meuse$zinc)))
plotNormalHistogram(angular,col = "yellow", main = "Angular Trnsfrm")

# 3. Angular as a %
angular <- asin(sqrt(meuse$zinc / 100)*2/pi)
plotNormalHistogram(angular, main = "Angular Trnsfrm")

# 4. Logit transform
logit <- log10(meuse$zinc/(1--meuse$zinc))
plotNormalHistogram(logit, main = "Logit(10) Trnsfrm")  

logit <- log(meuse$zinc/(1--meuse$zinc))
plotNormalHistogram(logit, main = "Logit Trnsfrm")  
#plotNormalHistogram(logit, main = "Logit Transform")

# Measure of Central Tendency
# 1 Mean of 
logZinc <- log(meuse$zinc + 1)
mlogZinc <- mean(logZinc)
plotNormalHistogram(logZinc, main = "Log Transform")

# 2. Sqrt
sqroot <- sqrt(meuse$zinc)
msqrt <- mean(sqroot)
plotNormalHistogram(sqroot, main = "Sqrt Transform")

# 3. Angular
angular <- asin(sqrt(meuse$zinc / max(meuse$zinc)))
plotNormalHistogram(angular, main = "Angular Trnsfrm")

# 3. Angular as a %
angular <- asin(sqrt(meuse$zinc / 100)*2/pi)
plotNormalHistogram(angular, main = "Angular Trnsfrm")

# 4. Logit transform
logit <- log10(meuse$zinc/(1--meuse$zinc))
plotNormalHistogram(logit, main = "Logit(10) Trnsfrm")  
