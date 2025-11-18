# Mean Sum.

Compute a missingness-adjusted row sum.

## Usage

``` r
meanSum(x)
```

## Arguments

- x:

  Matrix or dataframe with participants in the rows and items in the
  columns.

## Value

Missingness-adjusted row sum.

## Details

Take row mean across columns (items) and then multiply by number of
items to account for missing (`NA`) values.

## See also

Other computations:
[`Mode()`](https://devpsylab.github.io/petersenlab/reference/Mode.md),
[`kish_ess()`](https://devpsylab.github.io/petersenlab/reference/weightedQuantile.md),
[`mySum()`](https://devpsylab.github.io/petersenlab/reference/mySum.md)

## Examples

``` r
# Prepare Data
df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))

# Calculate Missingness-Adjusted Row Sum
df$missingnessAdjustedSum <- meanSum(df)
```
