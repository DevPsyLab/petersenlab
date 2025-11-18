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
#>               a           b          c           d
#> [1,]  0.6289820 -0.52201251  0.3629513 -0.09744510
#> [2,]  2.0650249 -0.05260191 -1.3045435 -0.93584735
#> [3,] -1.6309894  0.54299634  0.7377763 -0.01595031
#> [4,]  0.5124269 -0.91407483  1.8885049 -0.82678895
#> [5,] -1.8630115  0.46815442         NA          NA
```
