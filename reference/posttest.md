# Posttest Odds & Probability.

Estimate posttest odds and posttest probability.

## Usage

``` r
posttestOdds(
  TP,
  TN,
  FP,
  FN,
  pretestProb = NULL,
  SN = NULL,
  SP = NULL,
  likelihoodRatio = NULL
)

posttestProbability(
  TP,
  TN,
  FP,
  FN,
  pretestProb = NULL,
  SN = NULL,
  SP = NULL,
  likelihoodRatio = NULL
)
```

## Arguments

- TP:

  Number of true positive cases.

- TN:

  Number of true negative cases.

- FP:

  Number of false positive cases.

- FN:

  Number of false negative cases.

- pretestProb:

  Pretest probability (prevalence/base rate/prior probability) of
  characteristic, as a number between 0 and 1.

- SN:

  Sensitivity of the test at a given cut point, as a number between 0
  and 1.

- SP:

  Specificity of the test at a given cut point, as a number between 0
  and 1.

- likelihoodRatio:

  Likelihood ratio of the test at a given cut point.

## Value

The requested posttest odds or pottest probability.

## Details

Estimates posttest odds or posttest probability.

## See also

Other accuracy:
[`accuracyAtCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtCutoff.md),
[`accuracyAtEachCutoff()`](https://devpsylab.github.io/petersenlab/reference/accuracyAtEachCutoff.md),
[`accuracyOverall()`](https://devpsylab.github.io/petersenlab/reference/accuracyOverall.md),
[`nomogrammer()`](https://devpsylab.github.io/petersenlab/reference/nomogrammer.md),
[`optimalCutoff()`](https://devpsylab.github.io/petersenlab/reference/optimalCutoff.md)

## Examples

``` r
posttestOdds(
  TP = 26,
  TN = 56,
  FP = 14,
  FN = 14)
#> [1] 1.857143

posttestOdds(
  pretestProb = 0.3636364,
  SN = 0.65,
  SP = 0.80)
#> [1] 1.857143

posttestOdds(
  pretestProb = 0.3636364,
  likelihoodRatio = 3.25)
#> [1] 1.857143

posttestProbability(
  TP = 26,
  TN = 56,
  FP = 14,
  FN = 14)
#> [1] 0.65

posttestProbability(
  pretestProb = 0.3636364,
  SN = 0.65,
  SP = 0.80)
#> [1] 0.65

posttestProbability(
  pretestProb = 0.3636364,
  likelihoodRatio = 3.25)
#> [1] 0.65
```
