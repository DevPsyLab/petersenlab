# Discrimination (IRT) to Standardized Factor Loading.

Convert a discrimination parameter in item response theory to a
standardized factor loading.

## Usage

``` r
discriminationToFactorLoading(a, model = "probit")
```

## Arguments

- a:

  Discrimination parameter in item response theory.

- model:

  Model type. One of:

  - `"logit"`

  - `"probit"`

## Value

Standardized factor loading.

## Details

Convert a discrimination parameter in item response theory to a
standardized factor loading

## See also

<https://aidenloe.github.io/introToIRT.html>
<https://stats.stackexchange.com/questions/228629/conversion-of-irt-logit-discrimination-parameter-to-factor-loading-metric>

Other IRT:
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
discriminationToFactorLoading(0.5)
#> [1] 0.2818611
discriminationToFactorLoading(1.3)
#> [1] 0.6069994
discriminationToFactorLoading(1.3, model = "logit")
#> [1] 0.3880945
```
