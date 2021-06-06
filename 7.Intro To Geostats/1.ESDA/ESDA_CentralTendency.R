#Measures of Cental Tendency

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






