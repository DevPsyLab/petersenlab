# Bayes' Theorem.

Estimate marginal and conditional probabilities using Bayes theorem.

## Usage

``` r
pA(pAgivenB, pB, pAgivenNotB)

pB(pBgivenA, pA, pBgivenNotA)

pAgivenB(pBgivenA, pA, pB = NULL, pBgivenNotA = NULL)

pBgivenA(pAgivenB, pB, pA = NULL, pAgivenNotB = NULL)

pAgivenNotB(pAgivenB, pA, pB)

pBgivenNotA(pBgivenA, pA, pB)
```

## Arguments

- pAgivenB:

  The conditional probability of `A` given `B`.

- pB:

  The marginal probability of event `B`.

- pAgivenNotB:

  The conditional probability of `A` given NOT `B`.

- pBgivenA:

  The conditional probability of `B` given `A`.

- pA:

  The marginal probability of event `A`.

- pBgivenNotA:

  The conditional probability of `B` given NOT `A`.

## Value

The requested marginal or conditional probability. One of:

- the marginal probability of `A`

- the marginal probability of `B`

- the conditional probability of `A` given `B`

- the conditional probability of `B` given `A`

- the conditional probability of `A` given NOT `B`

- the conditional probability of `B` given NOT `A`

## Details

Estimates marginal or conditional probabilities using Bayes theorem.

## See also

Other bayesian:
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md)

## Examples

``` r
pA(pAgivenB = .95, pB = .285, pAgivenNotB = .007171515)
#> [1] 0.2758776

pB(pBgivenA = .95, pA = .285, pBgivenNotA = .007171515)
#> [1] 0.2758776

pAgivenB(pBgivenA = .95, pA = .285, pB = .2758776)
#> [1] 0.9814135
pAgivenB(pBgivenA = .95, pA = .285, pBgivenNotA = .007171515)
#> [1] 0.9814134
pAgivenB(pBgivenA = .95, pA = .003, pBgivenNotA = .007171515)
#> [1] 0.285
pAgivenB(pBgivenA = 1/3, pA = 9/10, pBgivenNotA = 1)
#> [1] 0.75

pBgivenA(pAgivenB = .95, pB = .285, pA = .2758776)
#> [1] 0.9814135
pBgivenA(pAgivenB = .95, pB = .285, pAgivenNotB = .007171515)
#> [1] 0.9814134
pBgivenA(pAgivenB = .95, pB = .003, pAgivenNotB = .007171515)
#> [1] 0.285
pBgivenA(pAgivenB = 1/3, pB = 9/10, pAgivenNotB = 1)
#> [1] 0.75

pAgivenNotB(pAgivenB = .95, pB = .003, pA = .01)
#> [1] 0.007171515

pBgivenNotA(pBgivenA = .95, pA = .003, pB = .01)
#> [1] 0.007171515
```
