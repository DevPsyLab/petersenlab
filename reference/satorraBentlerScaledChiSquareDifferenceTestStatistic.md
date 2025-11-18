# Satorra-Bentler Scaled Chi-Square Difference Test Statistic.

Function that computes the Satorra-Bentler Scaled Chi-Square Difference
Test statistic.

## Usage

``` r
satorraBentlerScaledChiSquareDifferenceTestStatistic(T0, c0, d0, T1, c1, d1)
```

## Arguments

- T0:

  Value of the chi-square statistic for the nested model.

- c0:

  Value of the scaling correction factor for the nested model.

- d0:

  Number of model degrees of freedom for the nested model.

- T1:

  Value of the chi-square statistic for the comparison model.

- c1:

  Value of the scaling correction factor for the comparison model.

- d1:

  Number of model degrees of freedom for the comparison model.

## Value

Satorra-Bentler Scaled Chi-Square Difference Test statistic.

## Details

Computes the Satorra-Bentler Scaled Chi-Square Difference Test statistic
between two structural equation models.

## See also

Other structural equation modeling:
[`equiv_chi()`](https://devpsylab.github.io/petersenlab/reference/equiv_chi.md),
[`make_esem_model()`](https://devpsylab.github.io/petersenlab/reference/make_esem_model.md),
[`puc()`](https://devpsylab.github.io/petersenlab/reference/puc.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md)

## Examples

``` r
# Fit structural equation model
HS.model <- '
 visual =~ x1 + x2 + x3
 textual =~ x4 + x5 + x6
 speed =~ x7 + x8 + x9
'

fit1 <- lavaan::cfa(HS.model, data = lavaan::HolzingerSwineford1939,
 estimator = "MLR")
fit0 <- lavaan::cfa(HS.model, data = lavaan::HolzingerSwineford1939,
 orthogonal = TRUE, estimator = "MLR")

# Chi-square difference test
# lavaan::anova(fit1, fit0)
satorraBentlerScaledChiSquareDifferenceTestStatistic(
 T0 = lavaan::fitMeasures(fit0)["chisq.scaled"],
 c0 = lavaan::fitMeasures(fit0)["chisq.scaling.factor"],
 d0 = lavaan::fitMeasures(fit0)["df.scaled"],
 T1 = lavaan::fitMeasures(fit1)["chisq.scaled"],
 c1 = lavaan::fitMeasures(fit1)["chisq.scaling.factor"],
 d1 = lavaan::fitMeasures(fit1)["df.scaled"])
#> chisq.scaled 
#>     44.62496 
```
