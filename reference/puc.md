# Percent of Uncontaminated Correlations (PUC).

Percent of uncontaminated correlations (PUC) from bifactor model.

## Usage

``` r
puc(numItems, numSpecificFactors)
```

## Arguments

- numItems:

  Number of items (or indicators).

- numSpecificFactors:

  Number of specific factors.

## Value

Percent of Uncontaminated Correlations (PUC).

## Details

Estimates the percent of uncontaminated correlations (PUC) from a
bifactor model. The PUC represents the percentage of correlations (i.e.,
covariance terms) that reflect variance from only the general factor
(i.e., not variance from a specific factor). Correlations that are
explained by the specific factors are considered "contaminated" by
multidimensionality.

## See also

[doi:10.31234/osf.io/6tf7j](https://doi.org/10.31234/osf.io/6tf7j)
[doi:10.1177/0013164412449831](https://doi.org/10.1177/0013164412449831)
[doi:10.1037/met0000045](https://doi.org/10.1037/met0000045)

Other structural equation modeling:
[`equiv_chi()`](https://devpsylab.github.io/petersenlab/reference/equiv_chi.md),
[`make_esem_model()`](https://devpsylab.github.io/petersenlab/reference/make_esem_model.md),
[`measurementNoninvarianceEffectSize()`](https://devpsylab.github.io/petersenlab/reference/measurementNoninvarianceEffectSize.md),
[`satorraBentlerScaledChiSquareDifferenceTestStatistic()`](https://devpsylab.github.io/petersenlab/reference/satorraBentlerScaledChiSquareDifferenceTestStatistic.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md)

## Examples

``` r
puc(
  numItems = 9,
  numSpecificFactors = 3
)
#> [1] 0.75

mydata <- data.frame(
  numItems = c(9,18,18,36,36,36),
  numSpecificFactors = c(3,3,6,3,6,12)
)

puc(
  numItems = mydata$numItems,
  numSpecificFactors = mydata$numSpecificFactors
)
#> [1] 0.7500000 0.7058824 0.8823529 0.6857143 0.8571429 0.9428571
```
