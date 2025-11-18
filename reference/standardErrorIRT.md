# Standard Error of Measurement (IRT).

Estimate the standard error of measurement in item response theory.

## Usage

``` r
standardErrorIRT(information)
```

## Arguments

- information:

  Test information.

## Value

Standard error of measurement for that amount of test information.

## Details

Estimate the standard error of measurement in item response theory using
the test information (i.e., the sum of all items' information).

## See also

[doi:10.1177/0146621613475471](https://doi.org/10.1177/0146621613475471)

Other IRT:
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
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

# Calculate standard error of measurement
standardErrorIRT(items$testInformation)
#> [1] 3.1220949 2.2478963 1.6396572 1.3436736 1.1732756 0.9381903 0.8450600
#> [8] 1.3489596 3.0432995
```
