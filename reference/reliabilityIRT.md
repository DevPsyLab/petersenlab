# Reliability (IRT).

Estimate the reliability in item response theory.

## Usage

``` r
reliabilityIRT(information, varTheta = 1)
```

## Arguments

- information:

  Test information.

- varTheta:

  Variance of theta.

## Value

Reliability for that amount of test information.

## Details

Estimate the reliability in item response theory using the test
information (i.e., the sum of all items' information).

## See also

<https://groups.google.com/g/mirt-package/c/ZAgpt6nq5V8/m/R3OEeEqdAQAJ>

Other IRT:
[`calc_grm_probs()`](https://devpsylab.github.io/petersenlab/reference/itemInformationGRM.md),
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
# Calculate information for 4 items
item1 <- itemInformation(b = -2, a = 0.6, theta = -4:4)
item2 <- itemInformation(b = -1, a = 1.2, theta = -4:4)
item3 <- itemInformation(b = 1, a = 1.5, theta = -4:4)
item4 <- itemInformation(b = 2, a = 2, theta = -4:4)

items <- data.frame(item1, item2, item3, item4)

# Calculate test information
items$testInformation <- rowSums(items)

# Estimate reliability
reliabilityIRT(items$testInformation)
#> [1] 0.09304510 0.16520630 0.27111469 0.35644794 0.42077350 0.53185802 0.58338755
#> [8] 0.35464868 0.09745001
```
