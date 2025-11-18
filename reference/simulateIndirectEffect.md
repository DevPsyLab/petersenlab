# Simulate Indirect Effect.

Simulate indirect effect from mediation analyses.

## Usage

``` r
simulateIndirectEffect(
  N = NA,
  x = NA,
  m = NA,
  XcorM = NA,
  McorY = NA,
  corTotal = NA,
  proportionMediated = NA,
  seed = NA
)
```

## Arguments

- N:

  Sample size.

- x:

  Vector for the predictor variable.

- m:

  Vector for the mediating variable.

- XcorM:

  Coefficient of the correlation between the predictor variable and
  mediating variable.

- McorY:

  Coefficient of the correlation between the mediating variable and
  outcome variable.

- corTotal:

  Size of total effect.

- proportionMediated:

  The proportion of the total effect that is mediated.

- seed:

  Seed for replicability.

## Value

- the correlation between the predictor variable (`x`) and the mediating
  variable (`m`).

- the correlation between the mediating variable (`m`) and the outcome
  variable (`Y`).

- the correlation between the predictor variable (`x`) and the outcome
  variable (`Y`).

- the direct correlation between the predictor variable (`x`) and the
  outcome variable (`Y`), while controlling for the mediating variable
  (`m`).

- the indirect correlation between the predictor variable (`x`) and the
  outcome variable (`Y`) through the mediating variable (`m`).

- the total correlation between the predictor variable (`x`) and the
  outcome variable (`Y`): i.e., the sum of the direct correlation and
  the indirect correlation.

- the proportion of the correlation between the predictor variable (`x`)
  and the outcome variable (`Y`) that is mediated through the mediating
  variable (`m`).

## Details

Co-created by Robert G. Moulder Jr. and Isaac T. Petersen

## See also

Other simulation:
[`complement()`](https://devpsylab.github.io/petersenlab/reference/complement.md),
[`simulateAUC()`](https://devpsylab.github.io/petersenlab/reference/simulateAUC.md)

## Examples

``` r
#INSERT
```
