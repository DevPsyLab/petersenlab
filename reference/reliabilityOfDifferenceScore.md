# Reliability of Difference Score.

Estimate the reliability of a difference score.

## Usage

``` r
reliabilityOfDifferenceScore(x, y, reliabilityX, reliabilityY)
```

## Arguments

- x:

  Vector of one variable that is used in the computation of difference
  score.

- y:

  Vector of second variable that is used in the computation of the
  difference score.

- reliabilityX:

  The reliability of the `x` variable.

- reliabilityY:

  The reliability of the `y` variable.

## Value

Reliability of the difference score that is computed from the difference
of `x` and `y`.

## Details

Estimates the reliability of a difference score.

## See also

Other reliability:
[`reliabilityOfProductTerm()`](https://devpsylab.github.io/petersenlab/reference/reliabilityOfProductTerm.md),
[`repeatability()`](https://devpsylab.github.io/petersenlab/reference/repeatability.md)

## Examples

``` r
v1 <- rnorm(1000, mean = 100, sd = 15)
v2 <- v1 + rnorm(1000, mean = 1, sd = 15)
reliabilityOfDifferenceScore(x = v1, y = v2,
 reliabilityX = .7, reliabilityY = .8)
#> [1] 0.322694
```
