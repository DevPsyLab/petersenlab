# Accuracy at a Given Cutoff.

Find the accuracy at a given cutoff. Actuals should be binary, where `1`
= present and `0` = absent.

## Usage

``` r
accuracyAtCutoff(
  predicted = NULL,
  actual = NULL,
  cutoff = NULL,
  TP = NULL,
  TN = NULL,
  FP = NULL,
  FN = NULL,
  UH = NULL,
  UM = NULL,
  UCR = NULL,
  UFA = NULL
)
```

## Arguments

- predicted:

  vector of continuous predicted values.

- actual:

  vector of binary actual values (`1` = present and `0` = absent).

- cutoff:

  numeric value at or above which the target condition is considered
  present.

- TP:

  number of true positive cases.

- TN:

  number of true negative cases.

- FP:

  number of false positive cases.

- FN:

  number of false negative cases.

- UH:

  (optional) utility of hits (true positives), specified as a value from
  0-1, where 1 is the most highly valued and 0 is the least valued.

- UM:

  (optional) utility of misses (false negatives), specified as a value
  from 0-1, where 1 is the most highly valued and 0 is the least valued.

- UCR:

  (optional) utility of correct rejections (true negatives), specified
  as a value from 0-1, where 1 is the most highly valued and 0 is the
  least valued.

- UFA:

  (optional) utility of false positives (false positives), specified as
  a value from 0-1, where 1 is the most highly valued and 0 is the least
  valued.

## Value

- `cutoff` = the cutoff specified

- `TP` = true positives

- `TN` = true negatives

- `FP` = false positives

- `FN` = false negatives

- `SR` = selection ratio

- `BR` = base rate

- `percentAccuracy` = percent accuracy

- `percentAccuracyByChance` = percent accuracy by chance

- `percentAccuracyPredictingFromBaseRate` = percent accuracy from
  predicting from the base rate

- `RIOC` = relative improvement over chance

- `relativeImprovementOverPredictingFromBaseRate` = relative improvement
  over predicting from the base rate

- `SN` = sensitivty

- `SP` = specificity

- `TPrate` = true positive rate

- `TNrate` = true negative rate

- `FNrate` = false negative rate

- `FPrate` = false positive rate

- `HR` = hit rate

- `FAR` = false alarm rate

- `PPV` = positive predictive value

- `NPV` = negative predictive value

- `FDR` = false discovery rate

- `FOR` = false omission rate

- `youdenJ` = Youden's J statistic

- `balancedAccuracy` = balanced accuracy

- `f1Score` = F1-score

- `mcc` = Matthews correlation coefficient

- `diagnosticOddsRatio` = diagnostic odds ratio

- `positiveLikelihoodRatio` = positive likelihood ratio

- `negativeLikelhoodRatio` = negative likelihood ratio

- `dPrimeSDT` = d-Prime index from signal detection theory

- `betaSDT` = beta index from signal detection theory

- `cSDT` = c index from signal detection theory

- `aSDT` = a index from signal detection theory

- `bSDT` = b index from signal detection theory

- `informationGain` = information gain

- `overallUtility` = overall utility (if utilities were specified)

- `differenceBetweenPredictedAndObserved` = difference between predicted
  and observed values

## Details

Compute accuracy indices of predicted values in relation to actual
values at a given cutoff by specifying either a) the predicted values,
actual values, and cutoff value, or b) the number of true positives
(TP), true negatives (TN), false positives (FPs), and false negatives
(FN). The target condition is considered present at or above the cutoff
value. Optionally, you can also specify the utility of hits, misses,
correct rejections, and false alarms to calculate the overall utility of
the cutoff. To compute accuracy at each possible cutoff, see
[accuracyAtEachCutoff](https://devpsylab.github.io/petersenlab/reference/accuracyAtEachCutoff.md).

## See also

Other accuracy:
[`accuracyAtEachCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtEachCutoff.md),
[`accuracyOverall()`](https://devpsylab.github.io/petersenlab/reference/accuracyOverall.md),
[`nomogrammer()`](https://devpsylab.github.io/petersenlab/reference/nomogrammer.md),
[`optimalCutoff()`](https://devpsylab.github.io/petersenlab/reference/optimalCutoff.md),
[`posttestOdds()`](https://devpsylab.github.io/petersenlab/reference/posttest.md)

## Examples

``` r
# Prepare Data
data("USArrests")
USArrests$highMurderState <- NA
USArrests$highMurderState[which(USArrests$Murder >= 10)] <- 1
USArrests$highMurderState[which(USArrests$Murder < 10)] <- 0

# Calculate Accuracy
accuracyAtCutoff(predicted = USArrests$Assault,
  actual = USArrests$highMurderState, cutoff = 200)
#>   cutoff TP TN FP FN   SR   BR percentAccuracy percentAccuracyByChance
#> 1    200 15 30  4  1 0.38 0.32              90                   54.32
#>   percentAccuracyPredictingFromBaseRate      RIOC
#> 1                                    68 0.8991935
#>   relativeImprovementOverPredictingFromBaseRate     SN        SP TPrate
#> 1                                       0.34375 0.9375 0.8823529 0.9375
#>      TNrate FNrate    FPrate     HR       FAR       PPV       NPV       FDR
#> 1 0.8823529 0.0625 0.1176471 0.9375 0.1176471 0.7894737 0.9677419 0.2105263
#>          FOR   youdenJ balancedAccuracy   f1Score       mcc diagnosticOddsRatio
#> 1 0.03225806 0.8198529        0.9099265 0.8571429 0.7879121               112.5
#>   positiveLikelihoodRatio negativeLikelihoodRatio dPrimeSDT   betaSDT
#> 1                 7.96875              0.07083333  2.720952 0.6234551
#>         cSDT      aSDT bSDT informationGain
#> 1 -0.1736446 0.9476103 0.85       0.4947688
#>   differenceBetweenPredictedAndObserved
#> 1                                 207.8

accuracyAtCutoff(predicted = USArrests$Assault,
  actual = USArrests$highMurderState, cutoff = 200,
  UH = 1, UM = 0, UCR = .9, UFA = 0)
#>   cutoff TP TN FP FN   SR   BR percentAccuracy percentAccuracyByChance
#> 1    200 15 30  4  1 0.38 0.32              90                   54.32
#>   percentAccuracyPredictingFromBaseRate      RIOC
#> 1                                    68 0.8991935
#>   relativeImprovementOverPredictingFromBaseRate     SN        SP TPrate
#> 1                                       0.34375 0.9375 0.8823529 0.9375
#>      TNrate FNrate    FPrate     HR       FAR       PPV       NPV       FDR
#> 1 0.8823529 0.0625 0.1176471 0.9375 0.1176471 0.7894737 0.9677419 0.2105263
#>          FOR   youdenJ balancedAccuracy   f1Score       mcc diagnosticOddsRatio
#> 1 0.03225806 0.8198529        0.9099265 0.8571429 0.7879121               112.5
#>   positiveLikelihoodRatio negativeLikelihoodRatio dPrimeSDT   betaSDT
#> 1                 7.96875              0.07083333  2.720952 0.6234551
#>         cSDT      aSDT bSDT informationGain overallUtility
#> 1 -0.1736446 0.9476103 0.85       0.4947688           0.84
#>   differenceBetweenPredictedAndObserved
#> 1                                 207.8

accuracyAtCutoff(TP = 30, TN = 20, FP = 15, FN = 35,
  UH = 1, UM = 0, UCR = .9, UFA = 0)
#>   TP TN FP FN   SR   BR percentAccuracy percentAccuracyByChance
#> 1 30 20 15 35 0.45 0.65              50                    48.5
#>   percentAccuracyPredictingFromBaseRate       RIOC
#> 1                                    65 0.02097902
#>   relativeImprovementOverPredictingFromBaseRate        SN        SP    TPrate
#> 1                                          -Inf 0.4615385 0.5714286 0.4615385
#>      TNrate    FNrate    FPrate        HR       FAR       PPV       NPV
#> 1 0.5714286 0.5384615 0.4285714 0.4615385 0.4285714 0.6666667 0.3636364
#>         FDR       FOR    youdenJ balancedAccuracy   f1Score        mcc
#> 1 0.3333333 0.6363636 0.03296703        0.5164835 0.5454545 0.03160698
#>   diagnosticOddsRatio positiveLikelihoodRatio negativeLikelihoodRatio
#> 1            1.142857                1.076923               0.9423077
#>    dPrimeSDT  betaSDT      cSDT      aSDT     bSDT informationGain
#> 1 0.08345375 1.011607 0.1382855 0.5260989 1.051383    0.0007217625
#>   overallUtility
#> 1           0.48
```
