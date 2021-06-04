#EDA to check the trend, normality, deviations: Histograms, boxplots,measure of central tendency, dispersion
rm(list = ls(all=TRUE)) #clear memory

#Load existing/install missing pckges
if (!require("pacman")) install.packages("pacman")
pacman::p_load(gstat, sp)
data(meuse)
df <- meuse
knitr::kable(head(df, n=5), align = 'l')

#Outlier Detection
##-> boxplot.stats()$cut