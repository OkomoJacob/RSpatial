#Measures of Cental Tendency
rm(list=ls(all=TRUE)) # Clear memory
library(gstat)
#Load existing/install missing libraries
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gstat,sp)
data(meuse)
df <- meuse
knitr::kable(head(df, n=3), align = 'l')

# 1. Mean of Copper metal
vMean   <- mean(df$copper)
cat("The mean is ", vMean)

# 2. Median of Copper metal
vMedian <- median(df$copper)
cat("The median is ", vMedian)

#3. Mode
library(modeest)
attach(df)
getmode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
vMode <- getmode(copper)
cat("The mode is", vMode)

# Measures of Dispersion
# Variance 
data(meuse)
varCop <- var(copper)
cat("The variance is: ", varCop)

# Standard deviation
stdDev <- sd(copper)
cat("The Std Deviation is: ", stdDev)

# Covariance
coVar <- cov(copper, lead)
cat("The covariance btn Cu & Pb is: ", coVar)

# correlation
corL <- cor(copper, lead)
cat("The correlatio btn Cu & Pb  is: ", corL)

# Kurtosis and skewness
pacman::p_load(e1071)
Kurt <- kurtosis(copper)

# Distribution

histogram <- hist(copper, prob=TRUE,breaks=20,main="Normal Distr curve + Hist", xlab= "Copper")
histogram
normalCurve <- curve(dnorm(x, mean=mean(copper), sd=sd(copper)), add=TRUE)
normalCurve

abline(v=mean(copper), col="red")
text(mean(copper),0.04,"Mean", col = "red", adj = c(0, -.1))
abline(v=median(copper), col="blue")
text(median(copper),0.04,"Median", col = "blue", adj = c(1, -.1))

# Co-efficient of variation
# ----------------------------------
# Write the function to compute the coefficient of variation
cv <- function(x) sd(x)/mean(x)

cvCu <- cv(meuse$copper)
cat("The coeff of variation of Cu : ",cvCu)
# lapply(meuse,cv)
# Obtain the dimension of the data
dim(meuse)
# Obtain the names of the variables
names(meuse)

#Create data
a <- seq(1,29)+4*runif(29,0.4)
b <- seq(1,29)^2+runif(29,0.98)

#Divide the screen in 2 columns and 2 lines
par(mfrow=c(2,2))

#Add a plot in each sub-screen !
plot(histogram, pch=20)
hist(histogram)
boxplot(meuse$zinc, ylab="zinc", )

#Extract the values of potential outliers based on IQR
boxplot.stats(meuse$zinc)$out

#Extract the row number corresponding to these outliers

out <- boxplot.stats(meuse$zinc)$out
out_ind <- which(meuse$zinc %in% c(out))
out_ind                 
