##########################################
# Task: Species Distribution Modeling    #
# Created on 19th February 2021          #
# Last edited: 21st February 2021        #
# Authors: Wyclife &  Coding in GEO team #
# Main R package: sdm                    #
##########################################

# Version documentation:

# R         = 4.0.3
# RStudio   = 1.4.1103
# sdm       = 1.0.98
# usdm      = 1.1.18
# dismo     = 1.3.3
# tidyverse = 1.3.0
# mapview   = 2.9.0

library(sdm) # Will give us the sdm()
installAll() # Brings in more methods for sdm package
library(dismo) # Will give us getData()
library(tidyverse) # Will help in data wrangling
library(mapview) # Will help in visualizing data across space
library(usdm) # Will give vifstep for multi-collinearity test

# Plant species to model its potential distribution is Grewia tenax.

# Species occurrence data source: gbif (https://www.gbif.org/).
#There are also:

     # iNaturalist -- https://www.inaturalist.org/
     # VertNet     -- http://vertnet.org/ 
     # BIEN        -- https://bien.nceas.ucsb.edu/bien/ ...among others
     # Museum, field excursions
 
# Climatic predictor variables: worldclim (https://www.worldclim.org/)

# There are also:
     # AfriClim    -- https://webfiles.york.ac.uk/KITE/AfriClim/
     # RCMRD       -- http://geoportal.rcmrd.org/
     # NASA, NOAA, Drone, NEON, humanitarian databases, among others...
     # Field and lab generated variables

# Species occurrence records ----

grewia_gbif <- gbif(genus = 'Grewia', species = 'tenax', 
               download = T, ntries = 10)

# kenya_ext <- extent(33.9, 41.91, -4.71, 5.51) # Can be a sp object in longlat.

africa_ext <- extent(-17, 51, -38, 36) # Extent of the study area

class(grewia_gbif)
head(grewia_gbif)
dim(grewia_gbif)
table(grewia_gbif$basisOfRecord)

# grewia_gbif %>% 
#   group_by(basisOfRecord) %>% 
#   summarise(number = n()) 

grewia_observed <- grewia %>% 
  filter(basisOfRecord %in% c("HUMAN_OBSERVATION", 
                              "LIVING_SPECIMEN", 
                              'PRESERVED_SPECIMEN'))

nrow(grewia_observed)
ncol(grewia_observed)

grewia_coords <- grewia_observed %>% 
  select(lon, lat)

# head(grewia_coords)
# dim(grewia_coords)
# colnames(grewia_coords)

# Adding species presence variable to the data.frame

grewia_coords$species <- 1
head(grewia_coords)

# Removing where lon or lat are NAs ----

# grewia_coords %>%
#   na.omit() %>%
#   nrow()

grewia_complete <- grewia_coords %>%
  drop_na() 

# Having the data as a spatialpointsdataframe

coordinates(grewia_complete) <- c('lon', 'lat')

class(grewia_complete)

# Environmental data ----

clim <- getData('worldclim', var = 'bio', res = 10)

clim

class(clim)

plot(clim[[1]])

points(grewia_complete) # Throws the points on the raster

# Clipping occurrence data and cropping predictor variables to study area
# drawExtent()... we can create an extent using this fn

grewia_complete_crop <- crop(grewia_complete, africa_ext) # Crops spp occurrence

plot(clim[[1]])

points(grewia_complete_crop) # Adds cropped spp occurrence onto the raster

clim_crop <- crop(clim, africa_ext) # Crops climate data

plot(clim_crop[[1]])
points(grewia_complete_crop)

# Developing the SDM----

# Testing for collinearity
# pairs(clim_crop), you can try this, it is taking sometime to work

pairs(clim_crop, maxpixels = 200) # This is making it faster for now

# ncell(clim_crop[[1]])...Checking for the number of cells in a layer

# vif()
# vifstep() 
# vifcor()

# Picking the climate variables at exact occurrence points. Extract

occur_clim <- as.data.frame(raster::extract(x = clim_crop, 
                                            y = grewia_complete_crop))

# class(occur_clim)
# head(occur_clim)

vifstep(occur_clim)

clim_crop_noncor <- exclude(clim_crop, vifstep(occur_clim))

# plot(clim_crop_noncor)...only nine variables left.

sdmdata <- sdmData(formula = species ~., train = grewia_complete_crop, 
                   predictors = clim_crop_noncor) # Creates sdmdata object
sdmdata

sdmdata <- sdmData(species ~., grewia_complete_crop, 
                   predictors = clim_crop_noncor,
                   bg = list(method = 'gRandom', n = 1000)) # Add bg points
sdmdata

getmethodNames() # List of available methods for sdm. Currently 21.

# You can use several of the methods as need may be. Clear understanding of 
# selected methods is important

grewia_model <- sdm(species ~., data = sdmdata, 
                    methods = c('rf', 'glm', 'svm'),
                    replication = c('sub', 'boot'), test.p = 30, n = 3)

# What can we get from the model output?
getModelInfo(grewia_model) # Info about the run models

roc(grewia_model) # Generates roc curves

roc(grewia_model, smooth = TRUE) # Smooths out the curves

gui(grewia_model) # Some good output

rcurve(grewia_model) # Response curves

getVarImp(grewia_model) # Prints relative importance of the predictors used

getVarImp(grewia_model, id = 1) # For specific model id

plot(getVarImp(grewia_model)) # Box plot of the relative variable importance

plot(getVarImp(grewia_model, method = 'rf')) # For specific method

niche(clim_crop_noncor, grewia_ensemble, # Range of 2D predictors for spp
      n = c('bio9', 'bio16'), 
      col = colorRampPalette(c('white', 'green', 'red'))(200))

# grewia_model@models$species$rf$`1`@varImportance....some info

grewia_predicted <- predict(grewia_model, clim_crop, 
                            filename = 'predicted_grewia.img' )

grewia_predicted

names(grewia_predicted) # All the 18 model outputs

plot(grewia_predicted[[c(1, 7, 13)]])

# Creating an ensemble of the models generated 

grewia_ensemble <- ensemble(grewia_model, clim_crop, 
                            filename = 'grewia_ens.img',
                            setting = list(id = c(1:6), 
                                           method = 'weighted', 
                                           stat = 'tss',
                                           opt = 2))

grewia_ensemble

names(grewia_ensemble) # Only one model output

plot(grewia_ensemble)

coloring <- colorRampPalette(c('white', 'green', 'red'))

plot(grewia_ensemble, col = coloring(100))

# View the plot on world map background

mapview(grewia_ensemble, col = coloring(100))

# Add occurrence records on the map

mapview(grewia_ensemble, col = coloring(100)) + grewia_complete_crop

# At what threshold do we conclude presence of a species?

sdmdata_df <- as.data.frame(sdmdata)

# head(sdmdata_df)
sdmdata_df <- data.frame(species = sdmdata_df$species, 
                         coordinates(sdmdata))
# head(sdmdata_df)
# tail(sdmdata_df)

# Use the lonlat in the df to extract values from ensemble layer

evaluation <- evaluates(sdmdata_df$species, 
          raster::extract(grewia_ensemble,
                          sdmdata_df[,c('lon', "lat")]))
evaluation
evaluation@statistics

threshold <- evaluation@threshold_based$threshold[2]

classified <- raster(grewia_ensemble)

classified[] <- ifelse(grewia_ensemble[] >= threshold, 1, 0)

plot(classified)

# Thank you for your attention