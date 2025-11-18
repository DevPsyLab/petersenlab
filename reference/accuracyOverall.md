# Overall Accuracy.

Find overall accuracy.

## Usage

``` r
accuracyOverall(predicted, actual, dropUndefined = FALSE)

wisdomOfCrowd(predicted, actual, dropUndefined = FALSE)
```

## Arguments

- predicted:

  vector of continuous predicted values.

- actual:

  vector of actual values.

- dropUndefined:

  `TRUE` or `FALSE`, indicating whether to drop any undefined values
  calculated with the accuracy indices.

## Value

- `ME` = mean error

- `MAE` = mean absolute error

- `MdAE` = median absolute error

- `MSE` = mean squared error

- `RMSE` = root mean squared error

- `MPE` = mean percentage error

- `MAPE` = mean absolute percentage error

- `sMAPE` = symmetric mean absolute percentage error

- `MASE` = mean absolute scaled error

- `RMSLE` = root mean squared log error

- `rsquared` = *R*-squared

- `rsquaredAsPredictor` = *R*-squared using the values as a predictor

- `rsquaredAdjAsPredictor` = adjusted *R*-squared using the values as a
  predictor

- `rsquaredPredictiveAsPredictor` = predictive *R*-squared using the
  values as a predictor

## Details

Compute overall accuracy estimates of predicted values in relation to
actual values. Estimates of overall accuracy span all cutoffs. Some
accuracy estimates can be undefined under various circumstances.
Optionally, you can drop undefined values in the calculation of accuracy
indices. Note that dropping undefined values changes the meaning of
these indices. Use this option at your own risk!

## See also

Mean absolute scaled error (MASE):  
<https://stats.stackexchange.com/questions/108734/alternative-to-mape-when-the-data-is-not-a-time-series>  
<https://stats.stackexchange.com/questions/322276/is-mase-specified-only-to-time-series-data>  
<https://stackoverflow.com/questions/31197726/calculate-mase-with-cross-sectional-non-time-series-data-in-r>  
<https://stats.stackexchange.com/questions/401759/how-can-mase-mean-absolute-scaled-error-score-value-be-interpreted-for-non-tim>  

Predictive R-squared:  
<https://www.r-bloggers.com/2014/05/can-we-do-better-than-r-squared/>  

Other accuracy:
[`accuracyAtCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtCutoff.md),
[`accuracyAtEachCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtEachCutoff.md),
[`nomogrammer()`](https://devpsylab.github.io/petersenlab/reference/nomogrammer.md),
[`optimalCutoff()`](https://devpsylab.github.io/petersenlab/reference/optimalCutoff.md),
[`posttestOdds()`](https://devpsylab.github.io/petersenlab/reference/posttest.md)

## Examples

``` r
# Prepare Data
data("USArrests")

# Calculate Accuracy
accuracyOverall(predicted = USArrests$Assault, actual = USArrests$Murder)
#>        ME     MAE   MdAE      MSE    RMSE       MPE     MAPE    sMAPE    MASE
#> 1 162.972 162.972 152.85 32814.24 181.147 -2382.823 2382.823 91.16591 44.6861
#>      RMSLE  rsquared rsquaredAsPredictor rsquaredAdjAsPredictor
#> 1 2.990233 -1764.055           0.6430008              0.6355633
#>   rsquaredPredictiveAsPredictor
#> 1                     0.6163406
wisdomOfCrowd(predicted = USArrests$Assault, actual = 200)
#> Warning: essentially perfect fit: summary may be unreliable
#> Warning: essentially perfect fit: summary may be unreliable
#> Warning: ANOVA F-tests on an essentially perfect fit are unreliable
#> Warning: essentially perfect fit: summary may be unreliable
#> Warning: essentially perfect fit: summary may be unreliable
#> Warning: ANOVA F-tests on an essentially perfect fit are unreliable
#>                   ME   MAE  MdAE       MSE     RMSE   MPE  MAPE     sMAPE MASE
#> individual    -29.24 76.32 79.50 7661.2400 87.52851 14.62 38.16 23.239460  Inf
#> crowdAveraged -29.24 29.24 29.24  854.9776 29.24000 14.62 14.62  7.886503  Inf
#>                   RMSLE bracketingRate
#> individual    0.6310922      0.4808163
#> crowdAveraged 0.1572068      0.4808163
```
