## Spatial Analysis on Meuse Dataset

### Introduction of meuse dataset
The Meuse River dataset we used here is included in `sp` package in R, which provides classes and methods for spatial data: `points, lines, polygons and grids`. This data set gives locations and topsoil heavy metal concentrations, along with a number of soil and landscape variables at the observation locations, collected in a flood plain of the river Meuse, near the village of Stein (NL). Heavy metal concentrations are from composite samples of an area of approximately 15m × 15m.
<!-- Intro -->
###### Predicting Zinc concentration from the Meuse River Dataset
<img src = https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/plots/spplot_zinc_conc.png> + <img src = https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/plots/bubble_zinc.png>

### Non-geostatistical approaches
We can however predict the zinc concentration using non-geostatistical methods, such as [Inverse Distance Weighted Interpolation (IDW)](https://pro.arcgis.com/en/pro-app/latest/help/analysis/geostatistical-analyst/how-inverse-distance-weighted-interpolation-works.htm):
<!-- The IDWW formular -->
<img src= https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/images/IDW%20interpolation.PNG>

The [idp parameter]() in function idw is the inverse (Euclidean) distance weighting power p. Large value of idp is similar to small value of k in k-nearest neighbors (KNN).

<!-- The terminal output -->
<img src = https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/images/asDataFrame.PNG>

Ideally, IDW interpolation (with small `p`) often results in maps that are close to kriged maps when a variogram is isotropic with no or small nugget value (i.e. [strong spatial autocorrrelation]()). Since IDW only use distance information, it ignores the spatial configuration of the samples (e.g. an anisotropic variogram). In addition, since the weights are always between 0 and 1, interpolated values never fall outside the range of data.

We can also predict the zinc concentration using [linear regression models](). One of the important predictors is the distance to the Meuse river. The figure below shows the relationship between the logarithm of topsoil zinc concentration and the distance to the Meuse river.

<!-- Img logZinc_vs_IDW -->
<img src = https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/plots/logZinc_vs_IDW.png>

### [Fitting the Linear Model]()

Further ESDA actually show that eEven after removing the trend from variable `dist`, there is still some spatial autocorrelation left on the residuals (e.g. neighboring points tends to have similar residual values.),just as the first law of Geography indicates.

<!-- Img -->
<img src = https://github.com/OkomoJacob/0x520x/blob/main/2.mySDM/meuseDataset%20Analysis/plots/fittedS_vs_Residual_plots.png>

### Estimate spatial correlation: variogram
The spatial correlatin can be observed by looking at the lagged scatter plot.
When lag is between 100 meters, the correlation is quite strong (i.e. correlation is 0.722). However, the spatial correlation becomes very close to 0 when lagged distance is beyond 500 meters.


### Acknowledgements & References
1. [Spatial Analysis on Meuse Dataset](http://statweb.lsu.edu/faculty/li/IIT/spatial.html) <br>
2. []()
