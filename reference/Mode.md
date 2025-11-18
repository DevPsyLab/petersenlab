# Statistical Mode.

Calculate statistical mode.

## Usage

``` r
Mode(x, multipleModes = "all")
```

## Arguments

- x:

  Numerical vector.

- multipleModes:

  How to handle multiple modes. One of:

  - `"mean"` = if there are multiple modes, take the mean of all modes

  - `"first"` = if there are multiple modes, select the first mode

  - `"all"` = if there are multiple modes, return all modes

## Value

Statistical mode(s).

## Details

Calculates statistical mode(s).

## See also

<https://stackoverflow.com/questions/2547402/how-to-find-the-statistical-mode/8189441#8189441>

Other computations:
[`kish_ess()`](https://devpsylab.github.io/petersenlab/reference/weightedQuantile.md),
[`meanSum()`](https://devpsylab.github.io/petersenlab/reference/meanSum.md),
[`mySum()`](https://devpsylab.github.io/petersenlab/reference/mySum.md)

## Examples

``` r
# Prepare Data
v1 <- c(1, 1, 2, 2, 3)

#Calculate Statistical Mode
Mode(v1)
#> [1] 1 2
Mode(v1, multipleModes = "mean")
#> [1] 1.5
Mode(v1, multipleModes = "first")
#> [1] 1
```
