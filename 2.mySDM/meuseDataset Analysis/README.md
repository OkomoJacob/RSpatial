## Spatial Analysis on Meuse Dataset

### Introduction of meuse dataset
The Meuse River dataset we used here is included in `sp` package in R, which provides classes and methods for spatial data: `points, lines, polygons and grids`. This data set gives locations and topsoil heavy metal concentrations, along with a number of soil and landscape variables at the observation locations, collected in a flood plain of the river Meuse, near the village of Stein (NL). Heavy metal concentrations are from composite samples of an area of approximately 15m × 15m.

### Non-geostatistical approaches
We can however predict the zinc concentration using non-geostatistical methods, such as [Inverse Distance Weighted Interpolation (IDW)](https://pro.arcgis.com/en/pro-app/latest/help/analysis/geostatistical-analyst/how-inverse-distance-weighted-interpolation-works.htm):
<!-- The IDWW formular -->
<img src=>

The [idp parameter]() in function idw is the inverse (Euclidean) distance weighting power p. Large value of idp is similar to small value of k in k-nearest neighbors (KNN).

<!-- The terminal output -->
<img src =>

Ideally, IDW interpolation (with small `p`) often results in maps that are close to kriged maps when a variogram is isotropic with no or small nugget value (i.e. [strong spatial autocorrrelation]()). Since IDW only use distance information, it ignores the spatial configuration of the samples (e.g. an anisotropic variogram). In addition, since the weights are always between 0 and 1, interpolated values never fall outside the range of data.

We can also predict the zinc concentration using [linear regression models](). One of the important predictors is the distance to the Meuse river. The figure below shows the relationship between the logarithm of topsoil zinc concentration and the distance to the Meuse river.

<!--  -->