# Optimal Cutoff.

Find the optimal cutoff for different aspects of accuracy. Actuals
should be binary, where `1` = present and `0` = absent.

## Usage

``` r
optimalCutoff(predicted, actual, UH = NULL, UM = NULL, UCR = NULL, UFA = NULL)
```

## Arguments

- predicted:

  vector of continuous predicted values.

- actual:

  vector of binary actual values (`1` = present and `0` = absent).

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

The optimal cutoff and optimal accuracy index at that cutoff based on:

- `percentAccuracy` = percent accuracy

- `percentAccuracyByChance` = percent accuracy by chance

- `RIOC` = relative improvement over chance

- `relativeImprovementOverPredictingFromBaseRate` = relative improvement
  over predicting from the base rate

- `PPV` = positive predictive value

- `NPV` = negative predictive value

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

- `differenceBetweenPredictedAndObserved` = difference between predicted
  and observed values

- `informationGain` = information gain

- `overallUtility` = overall utility (if utilities were specified)

## Details

Identify the optimal cutoff for different aspects of accuracy of
predicted values in relation to actual values by specifying the
predicted values and actual values. Optionally, you can specify the
utility of hits, misses, correct rejections, and false alarms to
calculate the overall utility of each possible cutoff.

## See also

Other accuracy:
[`accuracyAtCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtCutoff.md),
[`accuracyAtEachCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtEachCutoff.md),
[`accuracyOverall()`](https://devpsylab.github.io/petersenlab/reference/accuracyOverall.md),
[`nomogrammer()`](https://devpsylab.github.io/petersenlab/reference/nomogrammer.md),
[`posttestOdds()`](https://devpsylab.github.io/petersenlab/reference/posttest.md)

## Examples

``` r
# Prepare Data
data("USArrests")
USArrests$highMurderState <- NA
USArrests$highMurderState[which(USArrests$Murder >= 10)] <- 1
USArrests$highMurderState[which(USArrests$Murder < 10)] <- 0

# Determine Optimal Cutoff
optimalCutoff(predicted = USArrests$Assault,
  actual = USArrests$highMurderState)
#> [[1]]
#>   percentAccuracyCutoff percentAccuracyOptimal
#> 1                   188                     90
#> 2                   201                     90
#> 3                   211                     90
#> 
#> [[2]]
#>   percentAccuracyByChanceCutoff percentAccuracyByChanceOptimal
#> 1                        337.01                             68
#> 
#> [[3]]
#>    RIOCCutoff RIOCOptimal
#> 1          46           1
#> 2          48           1
#> 3          53           1
#> 4          56           1
#> 5          57           1
#> 6          72           1
#> 7          81           1
#> 8          83           1
#> 9          86           1
#> 10        102           1
#> 11        106           1
#> 12        109           1
#> 13        110           1
#> 14        113           1
#> 15        115           1
#> 16        120           1
#> 17        145           1
#> 18        149           1
#> 19        151           1
#> 20        156           1
#> 21        159           1
#> 22        161           1
#> 23        174           1
#> 24        178           1
#> 25        188           1
#> 
#> [[4]]
#>   relativeImprovementOverPredictingFromBaseRateCutoff
#> 1                                                 188
#> 2                                                 201
#> 3                                                 211
#>   relativeImprovementOverPredictingFromBaseRateOptimal
#> 1                                              0.34375
#> 2                                              0.34375
#> 3                                              0.34375
#> 
#> [[5]]
#>   PPVCutoff PPVOptimal
#> 1       300          1
#> 2       335          1
#> 3       337          1
#> 
#> [[6]]
#>    NPVCutoff NPVOptimal
#> 1         46          1
#> 2         48          1
#> 3         53          1
#> 4         56          1
#> 5         57          1
#> 6         72          1
#> 7         81          1
#> 8         83          1
#> 9         86          1
#> 10       102          1
#> 11       106          1
#> 12       109          1
#> 13       110          1
#> 14       113          1
#> 15       115          1
#> 16       120          1
#> 17       145          1
#> 18       149          1
#> 19       151          1
#> 20       156          1
#> 21       159          1
#> 22       161          1
#> 23       174          1
#> 24       178          1
#> 25       188          1
#> 
#> [[7]]
#>   youdenJCutoff youdenJOptimal
#> 1           188      0.8529412
#> 
#> [[8]]
#>   balancedAccuracyCutoff balancedAccuracyOptimal
#> 1                    188               0.9264706
#> 
#> [[9]]
#>   f1ScoreCutoff f1ScoreOptimal
#> 1           188      0.8648649
#> 
#> [[10]]
#>   mccCutoff mccOptimal
#> 1       188  0.8061389
#> 
#> [[11]]
#>   diagnosticOddsRatioCutoff diagnosticOddsRatioOptimal
#> 1                       201                      112.5
#> 
#> [[12]]
#>   positiveLikelihoodRatioCutoff positiveLikelihoodRatioOptimal
#> 1                           249                          12.75
#> 
#> [[13]]
#>    negativeLikelihoodRatioCutoff negativeLikelihoodRatioOptimal
#> 1                             46                              0
#> 2                             48                              0
#> 3                             53                              0
#> 4                             56                              0
#> 5                             57                              0
#> 6                             72                              0
#> 7                             81                              0
#> 8                             83                              0
#> 9                             86                              0
#> 10                           102                              0
#> 11                           106                              0
#> 12                           109                              0
#> 13                           110                              0
#> 14                           113                              0
#> 15                           115                              0
#> 16                           120                              0
#> 17                           145                              0
#> 18                           149                              0
#> 19                           151                              0
#> 20                           156                              0
#> 21                           159                              0
#> 22                           161                              0
#> 23                           174                              0
#> 24                           178                              0
#> 25                           188                              0
#> 
#> [[14]]
#>   dPrimeSDTCutoff dPrimeSDTOptimal
#> 1             201         2.720952
#> 
#> [[15]]
#>    betaSDTCutoff betaSDTOptimal
#> 1             46              0
#> 2             48              0
#> 3             53              0
#> 4             56              0
#> 5             57              0
#> 6             72              0
#> 7             81              0
#> 8             83              0
#> 9             86              0
#> 10           102              0
#> 11           106              0
#> 12           109              0
#> 13           110              0
#> 14           113              0
#> 15           115              0
#> 16           120              0
#> 17           145              0
#> 18           149              0
#> 19           151              0
#> 20           156              0
#> 21           159              0
#> 22           161              0
#> 23           174              0
#> 24           178              0
#> 25           188              0
#> 
#> [[16]]
#>   cSDTCutoff cSDTOptimal
#> 1        204  0.01824103
#> 
#> [[17]]
#>   aSDTCutoff aSDTOptimal
#> 1        188   0.9632353
#> 
#> [[18]]
#>   bSDTCutoff bSDTOptimal
#> 1         46  0.02857143
#> 
#> [[19]]
#>   differenceBetweenPredictedAndObservedCutoff
#> 1                                          45
#> 2                                          46
#> 3                                          48
#> 4                                          53
#> 5                                          56
#>   differenceBetweenPredictedAndObservedOptimal
#> 1                                         49.6
#> 2                                         49.6
#> 3                                         49.6
#> 4                                         49.6
#> 5                                         49.6
#> 
#> [[20]]
#>   informationGainCutoff informationGainOptimal
#> 1                   201              0.4947688
#> 
optimalCutoff(predicted = USArrests$Assault,
  actual = USArrests$highMurderState,
  UH = 1, UM = 0, UCR = .9, UFA = 0)
#> [[1]]
#>   percentAccuracyCutoff percentAccuracyOptimal
#> 1                   188                     90
#> 2                   201                     90
#> 3                   211                     90
#> 
#> [[2]]
#>   percentAccuracyByChanceCutoff percentAccuracyByChanceOptimal
#> 1                        337.01                             68
#> 
#> [[3]]
#>    RIOCCutoff RIOCOptimal
#> 1          46           1
#> 2          48           1
#> 3          53           1
#> 4          56           1
#> 5          57           1
#> 6          72           1
#> 7          81           1
#> 8          83           1
#> 9          86           1
#> 10        102           1
#> 11        106           1
#> 12        109           1
#> 13        110           1
#> 14        113           1
#> 15        115           1
#> 16        120           1
#> 17        145           1
#> 18        149           1
#> 19        151           1
#> 20        156           1
#> 21        159           1
#> 22        161           1
#> 23        174           1
#> 24        178           1
#> 25        188           1
#> 
#> [[4]]
#>   relativeImprovementOverPredictingFromBaseRateCutoff
#> 1                                                 188
#> 2                                                 201
#> 3                                                 211
#>   relativeImprovementOverPredictingFromBaseRateOptimal
#> 1                                              0.34375
#> 2                                              0.34375
#> 3                                              0.34375
#> 
#> [[5]]
#>   PPVCutoff PPVOptimal
#> 1       300          1
#> 2       335          1
#> 3       337          1
#> 
#> [[6]]
#>    NPVCutoff NPVOptimal
#> 1         46          1
#> 2         48          1
#> 3         53          1
#> 4         56          1
#> 5         57          1
#> 6         72          1
#> 7         81          1
#> 8         83          1
#> 9         86          1
#> 10       102          1
#> 11       106          1
#> 12       109          1
#> 13       110          1
#> 14       113          1
#> 15       115          1
#> 16       120          1
#> 17       145          1
#> 18       149          1
#> 19       151          1
#> 20       156          1
#> 21       159          1
#> 22       161          1
#> 23       174          1
#> 24       178          1
#> 25       188          1
#> 
#> [[7]]
#>   youdenJCutoff youdenJOptimal
#> 1           188      0.8529412
#> 
#> [[8]]
#>   balancedAccuracyCutoff balancedAccuracyOptimal
#> 1                    188               0.9264706
#> 
#> [[9]]
#>   f1ScoreCutoff f1ScoreOptimal
#> 1           188      0.8648649
#> 
#> [[10]]
#>   mccCutoff mccOptimal
#> 1       188  0.8061389
#> 
#> [[11]]
#>   diagnosticOddsRatioCutoff diagnosticOddsRatioOptimal
#> 1                       201                      112.5
#> 
#> [[12]]
#>   positiveLikelihoodRatioCutoff positiveLikelihoodRatioOptimal
#> 1                           249                          12.75
#> 
#> [[13]]
#>    negativeLikelihoodRatioCutoff negativeLikelihoodRatioOptimal
#> 1                             46                              0
#> 2                             48                              0
#> 3                             53                              0
#> 4                             56                              0
#> 5                             57                              0
#> 6                             72                              0
#> 7                             81                              0
#> 8                             83                              0
#> 9                             86                              0
#> 10                           102                              0
#> 11                           106                              0
#> 12                           109                              0
#> 13                           110                              0
#> 14                           113                              0
#> 15                           115                              0
#> 16                           120                              0
#> 17                           145                              0
#> 18                           149                              0
#> 19                           151                              0
#> 20                           156                              0
#> 21                           159                              0
#> 22                           161                              0
#> 23                           174                              0
#> 24                           178                              0
#> 25                           188                              0
#> 
#> [[14]]
#>   dPrimeSDTCutoff dPrimeSDTOptimal
#> 1             201         2.720952
#> 
#> [[15]]
#>    betaSDTCutoff betaSDTOptimal
#> 1             46              0
#> 2             48              0
#> 3             53              0
#> 4             56              0
#> 5             57              0
#> 6             72              0
#> 7             81              0
#> 8             83              0
#> 9             86              0
#> 10           102              0
#> 11           106              0
#> 12           109              0
#> 13           110              0
#> 14           113              0
#> 15           115              0
#> 16           120              0
#> 17           145              0
#> 18           149              0
#> 19           151              0
#> 20           156              0
#> 21           159              0
#> 22           161              0
#> 23           174              0
#> 24           178              0
#> 25           188              0
#> 
#> [[16]]
#>   cSDTCutoff cSDTOptimal
#> 1        204  0.01824103
#> 
#> [[17]]
#>   aSDTCutoff aSDTOptimal
#> 1        188   0.9632353
#> 
#> [[18]]
#>   bSDTCutoff bSDTOptimal
#> 1         46  0.02857143
#> 
#> [[19]]
#>   differenceBetweenPredictedAndObservedCutoff
#> 1                                          45
#> 2                                          46
#> 3                                          48
#> 4                                          53
#> 5                                          56
#>   differenceBetweenPredictedAndObservedOptimal
#> 1                                         49.6
#> 2                                         49.6
#> 3                                         49.6
#> 4                                         49.6
#> 5                                         49.6
#> 
#> [[20]]
#>   informationGainCutoff informationGainOptimal
#> 1                   201              0.4947688
#> 
#> [[21]]
#>   overallUtilityCutoff overallUtilityOptimal
#> 1                  188                 0.842
#> 
```
