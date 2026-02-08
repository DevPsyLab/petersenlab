# Item Information in logistic item response theory model.

Item information in logistic model in item response theory.

## Usage

``` r
itemInformation(a = 1, b, c = 0, d = 1, theta)
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

Amount of item information.

## Details

Estimates the amount of information in a logistic item response theory
model provided by a given item as function of the item parameters and
the person's level on the construct (theta).

## See also

[doi:10.1177/0146621613475471](https://doi.org/10.1177/0146621613475471)

Other IRT:
[`calc_grm_probs()`](https://devpsylab.github.io/petersenlab/reference/itemInformationGRM.md),
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
itemInformation(b = 2, theta = -4:4) #1PL
#> [1] 0.002466509 0.006648057 0.017662706 0.045176660 0.104993585 0.196611933
#> [7] 0.250000000 0.196611933 0.104993585
itemInformation(b = 2, a = 1.5, theta = -4:4) #2PL
#> [1] 0.0002776035 0.0012430644 0.0055496459 0.0244490169 0.1016474844
#> [6] 0.3355795172 0.5625000000 0.3355795172 0.1016474844
itemInformation(b = 2, a = 1.5, c = 0.10, theta = -4:4) #3PL
#> [1] 3.079509e-07 6.153641e-06 1.208112e-04 2.200035e-03 3.040755e-02
#> [6] 2.085541e-01 4.602273e-01 2.954296e-01 9.102953e-02
itemInformation(b = 2, a = 1.5, c = 0.10, d = 0.95, theta = -4:4) #4PL
#> [1] 2.746997e-07 5.490237e-06 1.078762e-04 1.971020e-03 2.750508e-02
#> [6] 1.903184e-01 4.074248e-01 2.218341e-01 4.038413e-02
```
