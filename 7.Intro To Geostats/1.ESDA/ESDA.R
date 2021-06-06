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

Data <- meuse
getOutlier <- function(dt, var){
  var_name <- eval(substitute(var), eval(dt))
    origData <- var_name
  na1 <- sum(is.na(var_namee))  #count missing values
  md1 <- median(var_name, na.rm = T) #Find median without NA value
    m1 <- mean(var_name, na.rm = T)
    windows() #prepare plot window
  par(mfrow = c(2, 2), mai = c(1, 1, 0.25, 0.25), oma = c(0, 0, 3, 0))
    layout(matrix(c(1, 1, 1, 1), nrow = 4, ncol = 1, byrow = TRUE), widths = c(3, 1), heights = c(1, 2))
  
  # First boxplot,Hist with outliers
  boxplot(var_name, main="Unwrangled Data")
  hist(var_name, main="Unwrangled Data", xlab = deparse(substitute(var)), ylab = "Frequency")
  
  #Data points which lie beyond the extremes of the whiskers
  outlier <- boxplot.stats(var_name)$out
  
  # Mean of outliers
  mean <- mean(outlier)
  
  #Replace outliers by NA of dataset using matching %in% test for ease of counting
  newNA <- ifelse(var_name %in% outlier, NA, var_name)
  
    # Tally the new NA
    na2 <- sum(is.na(newNA))
  
    # Replace outliers with median
    var_name <- ifelse(var_name %in% outlier, md1, var_name)
  
  # Cleaned boxplot & Histogram, Outliers removed
  boxplot(var_name, main = "Cleaned Data, OutlierFree")
  hit(var_name, main = "Cleaned Data, No Outliers", xlab = deparse(substitute(var)), ylab = "Frequency")
  title("Outlier Check", outer = TRUE)
  
  # Report ideintified number of outliers
  cat("Outlier Identified: ", na2 - na1, "numbers", "\n")
  
  # compute the proportion of outliers in data rounded to 1 decimal place
  cat("Propotion (%) of outliers:", round((na2 - na1) / sum(!is.na(var_name))*100, 1), "\n")
  cat("Mean of the outliers:", round(mo, 2), "\n")
  m2    <- mean(var_name, na.rm = T)    #Mean after removing outliers
    md2 <- median(var_name, na.rm = T)  #Median after removing outliers
  cat("Mean without removing outliers:", round(m1, 2), "\n")
  cat("Mean if we remove outliers:", round(m2, 2), "\n")
  cat("Median without removing outliers:", round(md1, 2), "\n")
  cat("Median if we remove outliers:", round(md2, 2), "\n")
  #response <- readline(prompt="Do you want to remove outliers and to replace with  data mean? [yes/no]: ") #Interactive input
  response <- "y"
  
  # Conditional Operator
  if(response == "y" | response == "yes"){
    
    originalData <- na.omit(originalData) #remove missing /not applicable values
    #replace outliers with mean
    CleanData <- ifelse(originalData %in% outlier, md1, originalData)
    CleanData[is.na(CleanData)] <- md1  #Replace all missing values with 0
    cat("Outliers successfully replaced with median ", na2 - na1, "\n")
    cat("Missing data successfully replaced with median ", na1, "\n")
    write.csv(CleanData, "CleanedData.csv")
    return(invisible(CleanData))
  }
  if(response == "n" | response == "no"){
    cat(na2 - na1, " outliers retained", "\n")
    write.csv(originalData, "CleanedData.csv")
    return(invisible(originalData))
  }
}
CleanData     <- Data #create another variable to hold cleaned data
CleanData$om    <- Getoutlier(Data, om) # remove outliers from organic matter (OM)

