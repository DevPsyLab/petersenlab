# Combine Results from Multiple Regression Imputation Models.

Function that combines [`lm()`](https://rdrr.io/r/stats/lm.html) results
across multiple imputation runs.

## Usage

``` r
lmCombine(model, dig = 3)
```

## Arguments

- model:

  name of [`lm()`](https://rdrr.io/r/stats/lm.html) model object with
  multiply imputed data.

- dig:

  number of decimals to print in output.

## Value

Summary of multiple regression imputation models.

## Details

\[INSERT\].

## See also

Other multipleImputation:
[`imputationCombine()`](https://devpsylab.github.io/petersenlab/reference/imputationCombine.md),
[`imputationModelCompare()`](https://devpsylab.github.io/petersenlab/reference/imputationModelCompare.md),
[`imputationPRV()`](https://devpsylab.github.io/petersenlab/reference/imputationPRV.md)

Other multipleRegression:
[`plot2WayInteraction()`](https://devpsylab.github.io/petersenlab/reference/plot2WayInteraction.md),
[`ppPlot()`](https://devpsylab.github.io/petersenlab/reference/ppPlot.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`update_nested()`](https://devpsylab.github.io/petersenlab/reference/update_nested.md)

## Examples

``` r
#INSERT
```
