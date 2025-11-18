# Any Rows Not NA.

Check if any rows for a column are not `NA`.

## Usage

``` r
not_all_na(x)
```

## Arguments

- x:

  vector or column

## Value

`TRUE` or `FALSE`

## Details

Determine whether any rows for a column (or vector) are not missing
(`NA`).

## See also

Other dataEvaluations:
[`dropColsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropColsWithAllNA.md),
[`dropRowsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropRowsWithAllNA.md),
[`is.nan.data.frame()`](https://devpsylab.github.io/petersenlab/reference/is.nan.data.frame.md),
[`not_any_na()`](https://devpsylab.github.io/petersenlab/reference/not_any_na.md)

## Examples

``` r
# Prepare Data
data("USArrests")

# Check if any rows are not NA
not_all_na(USArrests$Murder)
#> [1] TRUE
```
