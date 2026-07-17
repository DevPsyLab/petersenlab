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
mplusRotationArgs <- list(
  "geomin",
  rstarts = 30,
  row_weights = "none",
  algorithm = "gpa",
  orthogonal = FALSE,
  std_ov = TRUE, # row standard = correlation
  geomin_epsilon = 0.0001
)

efa_fit <- lavaan::sem(
  efa_syntax,
  data = HolzingerSwineford1939,
  information = "observed",
  missing = "ML",
  estimator = "MLR",
  rotation = mplusRotationArgs,
  # mimic Mplus
  meanstructure = TRUE)
#> Error: lavaan->lav_options_check():  
#>    Some option(s) unknown: "" !

# Extract Factor Loadings
esem_loadings <- lavaan::parameterEstimates(
  efa_fit,
  standardized = TRUE
) |>
  dplyr::filter(efa == "efa1") |>
  dplyr::select(lhs, rhs, est) |>
  dplyr::rename(item = rhs, latent = lhs, loading = est)
#> Error in eval(sc, envir = parent.frame()): object 'efa_fit' not found

# Specify Anchor Item for Each Latent Factor
anchors <- c(f1 = "x3", f2 = "x5", f3 = "x7")

# Generate ESEM Syntax
esemModel_syntax <- make_esem_model(esem_loadings, anchors)
#> Error: object 'esem_loadings' not found

# Fit ESEM Model
lavaan::sem(
  esemModel_syntax,
  data = HolzingerSwineford1939,
  missing = "ML",
  estimator = "MLR")
#> Error in eval(sc, parent.frame()): object 'esemModel_syntax' not found
```
