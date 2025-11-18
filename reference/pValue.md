# p-values.

Suppress the leading zero when printing p-values.

## Usage

``` r
pValue(value, digits = 3)
```

## Arguments

- value:

  The p-value.

- digits:

  Number of decimal digits for printing the p-value.

## Value

p-value.

## Details

\[INSERT\].

## See also

Other formatting:
[`apa()`](https://devpsylab.github.io/petersenlab/reference/apa.md),
[`specify_decimal()`](https://devpsylab.github.io/petersenlab/reference/specify_decimal.md),
[`suppressLeadingZero()`](https://devpsylab.github.io/petersenlab/reference/suppressLeadingZero.md)

## Examples

``` r
pValue(0.70)
#> [1] "=.700"
pValue(0.04)
#> [1] "=.040"
pValue(0.00002)
#> [1] "< .001"
```
