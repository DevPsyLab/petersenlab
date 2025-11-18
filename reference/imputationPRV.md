# Proportional Reduction of Variance from Imputation Models.

Calculate the proportional reduction of variance in imputation models.

## Usage

``` r
imputationPRV(baseline, full, baselineTime = 1, fullTime = 1)
```

## Arguments

- baseline:

  The baseline model object fit with the imputed data.

- full:

  The full model object fit with the imputed data.

- baselineTime:

  The position of the random effect of time (random slopes) among the
  random slopes in the baseline model. For example:

  - `0` = no random slopes

  - `1` = time is the 1st random effect

  - `2` = time is the second random effect

- fullTime:

  The position of the random effect of time (random slopes) among the
  random slopes in the full model. For example:

  - `0` = no random slopes

  - `1` = time is the 1st random effect

  - `2` = time is the second random effect

## Value

The proportional reduction of variance from a baseline mixed-effects
model to a full mixed effects model.

## Details

\[INSERT\].

## See also

Other multipleImputation:
[`imputationCombine()`](https://devpsylab.github.io/petersenlab/reference/imputationCombine.md),
[`imputationModelCompare()`](https://devpsylab.github.io/petersenlab/reference/imputationModelCompare.md),
[`lmCombine()`](https://devpsylab.github.io/petersenlab/reference/lmCombine.md)

## Examples

``` r
#INSERT
```
