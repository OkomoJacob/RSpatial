#Measures of Cental Tendency

#EDA to check the trend, normality, deviations: Histograms, boxplots,measure of central tendency, dispersion
rm(list = ls(all=TRUE)) #clear memory

#Load existing/install missing pckges, use :: to access a specific fxn from a package
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gstat, sp)
data(meuse)
df <- meuse
knitr::kable(head(df, n=5), align = 'l')

# outlier Detection
##-> boxplot.stats()$cut, to identify and remove data 1.5<x>1.5 , where x is the IQR
# Meuse Data

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