# Attenuation of True Correlation Due to Measurement Error.

Estimate the observed association between the predictor and criterion
after accounting for the degree to which a true correlation is
attenuated due to measurement error.

## Usage

``` r
attenuationCorrelation(
  trueAssociation,
  reliabilityOfPredictor,
  reliabilityOfCriterion
)
```

## Arguments

- trueAssociation:

  Magnitude of true association (*r* value).

- reliabilityOfPredictor:

  Reliability of predictor (from 0 to 1).

- reliabilityOfCriterion:

  Reliability of criterion/outcome (from 0 to 1).

## Value

Observed correlation between predictor and criterion.

## Details

Estimate the association that would be observed between the predictor
and criterion after accounting for the degree to which a true
correlation is attenuated due to random measurement error
(unreliability).

## See also

Other correlation:
[`disattenuationCorrelation()`](https://devpsylab.github.io/petersenlab/reference/disattenuationCorrelation.md)

## Examples

``` r
attenuationCorrelation(
  trueAssociation = .7,
  reliabilityOfPredictor = .9,
  reliabilityOfCriterion = .85)
#> [1] 0.6122499
```
