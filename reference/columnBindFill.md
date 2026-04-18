# Column Bind and Fill.

Column bind dataframes and fill with `NA`s.

## Usage

``` r
columnBindFill(...)
```

## Arguments

- ...:

  Names of multiple dataframes.

## Value

Dataframe with columns binded together.

## Details

Binds columns of two or more dataframes together, and fills in missing
rows.

## See also

<https://stackoverflow.com/questions/7962267/cbind-a-dataframe-with-an-empty-dataframe-cbind-fill/7962286#7962286>

Other dataManipulation:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`dropColsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropColsWithAllNA.md),
[`dropRowsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropRowsWithAllNA.md),
[`varsDifferentTypes()`](https://devpsylab.github.io/petersenlab/reference/varsDifferentTypes.md)

## Examples

``` r
# Prepare Data
df1 <- data.frame(a = rnorm(5), b = rnorm(5))
df2 <- data.frame(c = rnorm(4), d = rnorm(4))

# Column Bind and Fill
columnBindFill(df1, df2)
#>                 a          b          c           d
#> [1,] -1.400043517  1.1484116 -0.5536994  0.51242695
#> [2,]  0.255317055 -1.8218177  0.6289820 -1.86301149
#> [3,] -2.437263611 -0.2473253  2.0650249 -0.52201251
#> [4,] -0.005571287 -0.2441996 -1.6309894 -0.05260191
#> [5,]  0.621552721 -0.2827054         NA          NA
```
