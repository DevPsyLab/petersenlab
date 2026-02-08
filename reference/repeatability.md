# Repeatability.

Estimate the repeatability of a measure's scores across two time points.

## Usage

``` r
repeatability(measure1, measure2)
```

## Arguments

- measure1:

  Vector of scores from the measure at time 1.

- measure2:

  Vector of scores from the measure at time 2.

## Value

Dataframe with the coefficient of repeatability (`CR`), bias, the lower
limit of agreement (`lowerLOA`), and the upper limit of agreement
(`upperLOA`). Also generates a Bland-Altman plot with a solid black
reference line (indicating a difference of zero), a dashed red line
indicating the bias, and dashed blue lines indicating the limits of
agreement.

## Details

Estimates the coefficient of repeatability (CR), bias, and the lower and
upper limits of agreement (LOA).

## See also

Other reliability:
[`reliabilityOfDifferenceScore()`](https://devpsylab.github.io/petersenlab/reference/reliabilityOfDifferenceScore.md),
[`reliabilityOfProductTerm()`](https://devpsylab.github.io/petersenlab/reference/reliabilityOfProductTerm.md)

## Examples

``` r
v1 <- rnorm(1000, mean = 100, sd = 15)
v2 <- v1 + rnorm(1000, mean = 1, sd = 3)
repeatability(v1, v2)

#>        cr     bias  lowerLOA upperLOA
#> 1 5.76795 1.049423 -4.718527 6.817373
```
