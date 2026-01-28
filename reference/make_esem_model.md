# Make ESEM Model.

Make `lavaan` syntax for exploratory structural equation model (ESEM).

## Usage

``` r
make_esem_model(loadings, anchors)
```

## Arguments

- loadings:

  Dataframe with three columns from exploratory factor analysis (EFA):

  - `latent` = name of the latent factor(s)

  - `item` = name of the item(s)/indicator(s)

  - `loading` = parameter estimate of the factor loading item factor
    loading on the latent factor

- anchors:

  Dataframe whose names are the latent factors and whose values are the
  names of the anchor item for each latent factor.

## Value

`lavaan` model syntax.

## Details

Makes syntax for exploratory structural equation model (ESEM) to be fit
in `lavaan`.

## See also

<https://msilvestrin.me/post/esem/>

Other structural equation modeling:
[`equiv_chi()`](https://devpsylab.github.io/petersenlab/reference/equiv_chi.md),
[`measurementNoninvarianceEffectSize()`](https://devpsylab.github.io/petersenlab/reference/measurementNoninvarianceEffectSize.md),
[`puc()`](https://devpsylab.github.io/petersenlab/reference/puc.md),
[`satorraBentlerScaledChiSquareDifferenceTestStatistic()`](https://devpsylab.github.io/petersenlab/reference/satorraBentlerScaledChiSquareDifferenceTestStatistic.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md)

## Examples

``` r
# Prepare Data
data("HolzingerSwineford1939", package = "lavaan")

# Specify EFA Syntax
efa_syntax <- '
  # EFA Factor Loadings
  efa("efa1")*f1 +
  efa("efa1")*f2 +
  efa("efa1")*f3 =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
'

# Fit EFA Model
mplusRotationArgs <- list(rstarts = 30,
  row.weights = "none",
  algorithm = "gpa",
  orthogonal = FALSE,
  jac.init.rot = TRUE,
  std.ov = TRUE, # row standard = correlation
  geomin.epsilon = 0.0001)

efa_fit <- lavaan::sem(
  efa_syntax,
  data = HolzingerSwineford1939,
  information = "observed",
  missing = "ML",
  estimator = "MLR",
  rotation = "geomin",
  # mimic Mplus
  meanstructure = TRUE,
  rotation.args = mplusRotationArgs)

# Extract Factor Loadings
esem_loadings <- lavaan::parameterEstimates(
  efa_fit,
  standardized = TRUE
) |>
  dplyr::filter(efa == "efa1") |>
  dplyr::select(lhs, rhs, est) |>
  dplyr::rename(item = rhs, latent = lhs, loading = est)

# Specify Anchor Item for Each Latent Factor
anchors <- c(f1 = "x3", f2 = "x5", f3 = "x7")

# Generate ESEM Syntax
esemModel_syntax <- make_esem_model(esem_loadings, anchors)

# Fit ESEM Model
lavaan::sem(
  esemModel_syntax,
  data = HolzingerSwineford1939,
  missing = "ML",
  estimator = "MLR")
#> lavaan 0.6-21 ended normally after 150 iterations
#> 
#>   Estimator                                         ML
#>   Optimization method                           NLMINB
#>   Number of model parameters                        42
#> 
#>   Number of observations                           301
#>   Number of missing patterns                         1
#> 
#> Model Test User Model:
#>                                               Standard      Scaled
#>   Test Statistic                                22.897      23.785
#>   Degrees of freedom                                12          12
#>   P-value (Chi-square)                           0.029       0.022
#>   Scaling correction factor                                  0.963
#>     Yuan-Bentler correction (Mplus variant)                       
```
