# Disattenuation of Observed Correlation Due to Measurement Error.

Estimate the true association between the predictor and criterion after
accounting for the degree to which a true correlation is attenuated due
to measurement error.

## Usage

``` r
disattenuationCorrelation(
  observedAssociation,
  reliabilityOfPredictor,
  reliabilityOfCriterion
)
```

## Arguments

- observedAssociation:

  Magnitude of observed association (*r* value).

- reliabilityOfPredictor:

  Reliability of predictor (from 0 to 1).

- reliabilityOfCriterion:

  Reliability of criterion/outcome (from 0 to 1).

## Value

True association between predictor and criterion.

## Details

Estimate the true association between the predictor and criterion after
accounting for the degree to which a true correlation is attenuated due
to random measurement error (unreliability).

## See also

Other correlation:
[`attenuationCorrelation()`](https://devpsylab.github.io/petersenlab/reference/attenuationCorrelation.md)

## Examples

``` r
disattenuationCorrelation(
  observedAssociation = .7,
  reliabilityOfPredictor = .9,
  reliabilityOfCriterion = .85)
#> [1] 0.8003267
```
