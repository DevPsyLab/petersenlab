# Weighted Quantiles.

Computes weighted quantiles. `whdquantile()` uses a weighted
Harrell-Davis quantile estimator. `wthdquantile()` uses a weighted
trimmed Harrell-Davis quantile estimator. `wquantile()` uses a weighted
traditional quantile estimator.

## Usage

``` r
kish_ess(w)

wquantile_generic(x, w, probs, cdf)

whdquantile(x, w, probs)

wthdquantile(x, w, probs, width = 1/sqrt(kish_ess(w)))

wquantile(x, w, probs, type = 7)
```

## Arguments

- w:

  Numeric vector of weights to give each value. Should be the same
  length as the vector of values.

- x:

  Numeric vector of values of which to determine the quantiles.

- probs:

  Numeric vector of the quantiles to retrieve.

- cdf:

  Cumulative distribution function.

- width:

  Numeric value for the width of the interval in the trimmed
  Harrell-Davis quantile estimator.

- type:

  Numeric value for type of weighted quantile.

## Value

Numeric vector of specified quantiles.

## Details

Computes weighted quantiles according to Akinshin (2023).

## See also

[doi:10.48550/arXiv.2304.07265](https://doi.org/10.48550/arXiv.2304.07265)

Other computations:
[`Mode()`](https://devpsylab.github.io/petersenlab/reference/Mode.md),
[`meanSum()`](https://devpsylab.github.io/petersenlab/reference/meanSum.md),
[`mySum()`](https://devpsylab.github.io/petersenlab/reference/mySum.md)

## Examples

``` r
mydata <- c(1:100, 1000)
mydataWithNAs <- mydata
mydataWithNAs[c(1,5,7)] <- NA
weights <- rep(1, length(mydata))
quantiles <- c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99)

whdquantile(
  x = mydata,
  w = weights,
  probs = quantiles)
#> [1]   1.588365   5.550019  10.600000  25.750000  51.000000  76.250000  91.400042
#> [8]  99.033690 662.561505

wthdquantile(
  x = mydata,
  w = weights,
  probs = quantiles)
#> [1]   1.588098   5.464074  10.330683  25.435245  51.000000  76.564755  91.669317
#> [8]  97.306006 662.576876

wquantile(
  x = mydata,
  w = weights,
  probs = quantiles)
#> [1]   2   6  11  26  51  76  91  96 100

whdquantile(
  x = mydataWithNAs,
  w = weights,
  probs = quantiles)
#> [1]   2.626940   7.830704  13.291418  28.000000  52.500000  77.000000  91.700087
#> [8]  99.966562 674.296651

wthdquantile(
  x = mydataWithNAs,
  w = weights,
  probs = quantiles)
#> [1]   2.620986   7.751954  13.041100  27.691494  52.500000  77.308506  91.958900
#> [8]  97.816240 672.742321

wquantile(
  x = mydataWithNAs,
  w = weights,
  probs = quantiles)
#> [1]   2.97   8.85  13.70  28.25  52.50  76.75  91.30  96.15 127.00
```
