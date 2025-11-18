# 4-Parameter Logistic Curve.

4-parameter logistic curve for item response theory.

## Usage

``` r
fourPL(a = 1, b, c = 0, d = 1, theta)
```

## Arguments

- a:

  Discrimination parameter (slope).

- b:

  Difficulty (severity) parameter (inflection point).

- c:

  Guessing parameter (lower asymptote).

- d:

  Careless errors parameter (upper asymptote).

- theta:

  Person's level on the construct.

## Value

Probability of item endorsement (or expected value on the item).

## Details

Estimates the probability of item endorsement as function of the
four-parameter logistic (4PL) curve and the person's level on the
construct (theta).

## See also

[doi:10.1177/0146621613475471](https://doi.org/10.1177/0146621613475471)

Other IRT:
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
fourPL(b = 2, theta = -4:4) #1PL
#> [1] 0.002472623 0.006692851 0.017986210 0.047425873 0.119202922 0.268941421
#> [7] 0.500000000 0.731058579 0.880797078
fourPL(b = 2, a = 1.5, theta = -4:4) #2PL
#> [1] 0.0001233946 0.0005527786 0.0024726232 0.0109869426 0.0474258732
#> [6] 0.1824255238 0.5000000000 0.8175744762 0.9525741268
fourPL(b = 2, a = 1.5, c = 0.10, theta = -4:4) #3PL
#> [1] 0.1001111 0.1004975 0.1022254 0.1098882 0.1426833 0.2641830 0.5500000
#> [8] 0.8358170 0.9573167
fourPL(b = 2, a = 1.5, c = 0.10, d = 0.95, theta = -4:4) #4PL
#> [1] 0.1001049 0.1004699 0.1021017 0.1093389 0.1403120 0.2550617 0.5250000
#> [8] 0.7949383 0.9096880
```
