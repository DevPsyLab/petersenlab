# Obtain standardized regression coefficients from lmer model.

Obtains standardized regression coefficients from the results of a model
fit by the `lme4()` function of the `lmer` package.

## Usage

``` r
lm.beta.lmer(model)
```

## Arguments

- model:

  name of [`lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html) model
  object.

## Value

Standardized regression coefficients of
[`lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html) model object.

## Details

Obtains standardized regression coefficients from the results of a model
fit by the [`lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html) function
of the `lme4` package.

## See also

<https://stats.stackexchange.com/a/123448>

Other mixedModel:
[`lmeSummary()`](https://devpsylab.github.io/petersenlab/reference/lmeSummary.md)

## Examples

``` r
# Fit Model
library("lme4")
#> Loading required package: Matrix

sleepstudy$DaySq <- sleepstudy$Days^2
model <- lme4::lmer(Reaction ~ Days + DaySq + (Days | Subject), sleepstudy)

# Standardized regression coefficients
lm.beta.lmer(model)
#>      Days     DaySq 
#> 0.3801317 0.1611094 
```
