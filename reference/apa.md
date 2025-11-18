# APA Format

Format decimals and leading zeroes. Adapted from the MOTE package.

## Usage

``` r
apa(value, decimals = 3, leading = TRUE)
```

## Arguments

- value:

  A set of numeric values, either a single number, vector, or set of
  columns.

- decimals:

  The number of decimal points desired in the output.

- leading:

  Logical value: `TRUE` for leading zeroes on decimals and `FALSE` for
  no leading zeroes on decimals. The default is `TRUE`.

## Value

Value(s) in the format specified, with the number of decimals places
indicated and with or without a leading zero, as indicated.

## Details

Formats decimals and leading zeroes for creating reports in scientific
style, to be consistent with American Psychological Association (APA)
format. This function creates "pretty" character vectors from numeric
variables for printing as part of a report. The value can take a single
number, matrix, vector, or multiple columns from a data frame, as long
as they are numeric. The values will be coerced into numeric if they are
characters or logical values, but this process may result in an error if
values are truly alphabetical.

## See also

<https://github.com/doomlab/MOTE>

Other formatting:
[`pValue()`](https://devpsylab.github.io/petersenlab/reference/pValue.md),
[`specify_decimal()`](https://devpsylab.github.io/petersenlab/reference/specify_decimal.md),
[`suppressLeadingZero()`](https://devpsylab.github.io/petersenlab/reference/suppressLeadingZero.md)

## Examples

``` r
apa(value = 0.54674, decimals = 3, leading = TRUE)
#> [1] "0.547"
```
