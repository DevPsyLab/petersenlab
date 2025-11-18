# Not Any NA.

Check if all rows for a column are `NA`.

## Usage

``` r
not_any_na(x)
```

## Arguments

- x:

  column vector

## Value

`TRUE` or `FALSE`, indicating whether the whole column does not have any
missing values (`NA`).

## Details

\[INSERT\].

## See also

Other dataEvaluations:
[`dropColsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropColsWithAllNA.md),
[`dropRowsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropRowsWithAllNA.md),
[`is.nan.data.frame()`](https://devpsylab.github.io/petersenlab/reference/is.nan.data.frame.md),
[`not_all_na()`](https://devpsylab.github.io/petersenlab/reference/not_all_na.md)

## Examples

``` r
# Prepare Data
df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))
df[sample(1:nrow(df), size = 100), "item2"] <- NA
df[,"item3"] <- NA

# Check if Not Any NA
not_any_na(df$item1)
#> [1] TRUE
not_any_na(df$item2)
#> [1] FALSE
not_any_na(df$item3)
#> [1] FALSE
```
