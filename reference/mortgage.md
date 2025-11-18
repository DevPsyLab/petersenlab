# Mortgage Principal and Interest.

Amount of principal and interest payments on a mortgage.

## Usage

``` r
mortgage(balance, interest, term = 30, n = 12)
```

## Arguments

- balance:

  Initial mortgage balance.

- interest:

  Interest rate.

- term:

  Payoff period (in years).

- n:

  Number of payments per year.

## Value

Amount of principal and interest payments.

## Details

Calculates the amount of principal and interest payments on a mortgage.

## Examples

``` r
mortgage(balance = 300000, interest = .05)
#> [1] 1610.465
mortgage(balance = 300000, interest = .04)
#> [1] 1432.246
mortgage(balance = 300000, interest = .06)
#> [1] 1798.652
mortgage(balance = 300000, interest = .05, term = 15)
#> [1] 2372.381
```
