# My Sum.

Compute a row sum and retain `NA`s when all values in the row are `NA`.

## Usage

``` r
mySum(data)
```

## Arguments

- data:

  dataframe

## Value

Modified row sum to set row sum to be missing when all values in the row
are missing (`NA`).

## Details

Compute a row sum and set the row sum to be missing (not zero) when all
values in the row are missing (`NA`).

## See also

Other computations:
[`Mode()`](https://devpsylab.github.io/petersenlab/reference/Mode.md),
[`kish_ess()`](https://devpsylab.github.io/petersenlab/reference/weightedQuantile.md),
[`meanSum()`](https://devpsylab.github.io/petersenlab/reference/meanSum.md)

## Examples

``` r
# Prepare Data
df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))
df[sample(1:nrow(df), size = 100), c("item1","item2","item3")] <- NA

# Calculate Missingness-Adjusted Row Sum
df$sum <- mySum(df)
```
