#Measures of Cental Tendency

library(gstat)
rm(list=ls(all=TRUE)) # Clear memory
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

histogram <- hist(copper, prob=TRUE,breaks=20,main="Normal distribution curve over histogram", xlab= "Copper")
histogram
curve(dnorm(x, mean=mean(copper), sd=sd(copper)), add=TRUE)
abline(v=mean(copper), col="red")
text(mean(copper),0.04,"Mean", col = "red", adj = c(0, -.1))
abline(v=median(copper), col="blue")
text(median(copper),0.04,"Median", col = "blue", adj = c(1, -.1))

# Coeff of variation
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
