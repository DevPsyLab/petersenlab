# NOTIN Operator.

NOTIN operator.

## Usage

``` r
x %ni% table
```

## Arguments

- x:

  vector or `NULL`: the values to be matched. Long vectors are
  supported.

- table:

  vector or `NULL`: the values to be matched against. Long vectors are
  supported.

## Value

Vector of `TRUE` and `FALSE`, indicating whether values in one vector
are not in another vector.

## Details

Determine whether values in one vector are not in another vector.

## See also

<https://www.r-bloggers.com/2018/07/the-notin-operator/>
<https://stackoverflow.com/questions/71309487/r-package-documentation-undocumented-arguments-in-documentation-object-for-a?noredirect=1>

## Examples

``` r
# Prepare Data
v1 <- c("Sally","Tom","Barry","Alice")
listToCheckAgainst <- c("Tom","Alice")

v1 %ni% listToCheckAgainst
#> [1]  TRUE FALSE  TRUE FALSE
v1[v1 %ni% listToCheckAgainst]
#> [1] "Sally" "Barry"
```
