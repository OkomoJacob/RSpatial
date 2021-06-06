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
vMode <- getmode(copper)
cat("The mode is", vMode)

#4. Measures of Dispersion











