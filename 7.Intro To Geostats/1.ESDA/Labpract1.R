# Clear memory
rm(list=ls(all=TRUE))

# Load SP packages
library(lattice)
library(gstat)
library(sp)
load(system.file("data", "meuse.rda", package = "sp"))
print(meuse)
summary(meuse$zinc)

#Plotting histogram
hist(meuse$zinc,xlab = "zinc", main= "Histogram of Zinc",breaks=10)

#set number of bins
#plotting Boxplot
boxplot(meuse$zinc, ylab="zinc")

#extract the values of potential outliers based on IQR
boxplot.stats(meuse$zinc)$out

#Extract the row number corresponding to these outliers

out <- boxplot.stats(meuse$zinc)$out
out_ind <- which(meuse$zinc %in% c(out))
out_ind                 

#verify rows in the dataset
meuse[out_ind,]

#print the values of the outliers directly

boxplot(meuse$zinc, ylab="zinc" ,main = "Zinc")


#Assignment
#1.Look at how to plot all the four transforms in one plot i.e log, sqrt, Angular, logit in one space