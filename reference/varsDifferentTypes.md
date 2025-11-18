# Identify Variables of Different Types.

Identifies the variables in common across two dataframes that have
different types.

## Usage

``` r
varsDifferentTypes(df1, df2)
```

## Arguments

- df1:

  dataframe 1 (object)

- df2:

  dataframe 2 (object)

## Value

Dataframe with columns for the variable name, the variable type in `df1`
and the variable type in `df2`.

## Details

Identifies the variables that have the same name across two dataframes
that have different types, which can pose challenges for merging two
dataframes.

## See also

Other dataManipulation:
[`columnBindFill()`](https://devpsylab.github.io/petersenlab/reference/columnBindFill.md),
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`dropColsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropColsWithAllNA.md),
[`dropRowsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropRowsWithAllNA.md)

## Examples

``` r
# Prepare Data
df1 <- data.frame(
  A = 1:3,
  B = 2:4,
  C = 3:5
)

df2 <- data.frame(
  A = as.character(1:3),
  B = 2:4,
  C = as.factor(3:5)
)

# Check if any rows are not NA
varsDifferentTypes(df1, df2)
#>   column type_df1  type_df2
#> A      A  integer character
#> C      C  integer    factor
```
