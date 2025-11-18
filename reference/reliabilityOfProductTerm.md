# Reliability of Product Term.

Estimate the reliability of a product term (assuming the individual
indices are centered for the computation of the product term).

## Usage

``` r
reliabilityOfProductTerm(x, y, reliabilityX, reliabilityY)
```

## Arguments

- x:

  Vector of one variable that is used in the computation of the product
  term.

- y:

  Vector of second variable that is used in the computation of the
  product term.

- reliabilityX:

  The reliability of the `x` variable.

- reliabilityY:

  The reliability of the `y` variable.

## Value

Reliability of the product term that is computed from the multiplication
of `x` and `y`.

## Details

Estimates the reliability of a product term (assuming the individual
indices are centered for the computation of the product term).

## See also

Other reliability:
[`reliabilityOfDifferenceScore()`](https://devpsylab.github.io/petersenlab/reference/reliabilityOfDifferenceScore.md),
[`repeatability()`](https://devpsylab.github.io/petersenlab/reference/repeatability.md)

## Examples

``` r
v1 <- rnorm(1000, mean = 100, sd = 15)
v2 <- rnorm(1000, mean = 1, sd = 15)
reliabilityOfProductTerm(x = v1, y = v2,
 reliabilityX = .7, reliabilityY = .8)
#> [1] 0.5601278
```
