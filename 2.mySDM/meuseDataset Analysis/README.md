## Spatial Analysis on Meuse Dataset

### Introduction of meuse dataset
The Meuse River dataset we used here is included in `sp` package in R, which provides classes and methods for spatial data: `points, lines, polygons and grids`. This data set gives locations and topsoil heavy metal concentrations, along with a number of soil and landscape variables at the observation locations, collected in a flood plain of the river Meuse, near the village of Stein (NL). Heavy metal concentrations are from composite samples of an area of approximately 15m × 15m.

### Non-geostatistical approaches
We can however predict the zinc concentration using non-geostatistical methods, such as [Inverse Distance Weighted Interpolation (IDW)](https://pro.arcgis.com/en/pro-app/latest/help/analysis/geostatistical-analyst/how-inverse-distance-weighted-interpolation-works.htm):
<img src=>

The [idp parameter]() in function idw is the inverse (Euclidean) distance weighting power p. Large value of idp is similar to small value of k in k-nearest neighbors (KNN).