# Indexes of Effect Size for Measurement Noninvariance in Structural Equation Models.

Function that estimates effect size indices for measurement
noninvariance in structural equation modeling.

## Usage

``` r
measurementNoninvarianceEffectSize(model_unconstrained, model_constrained)
```

## Arguments

- model_unconstrained:

  `lavaan` model object for unconstrained model.

- model_constrained:

  `lavaan` model object for constrained model.

## Value

\\w\\ and \\\Delta \mathrm{M}\_{\mathrm{C}}\\.

## Details

From Newsom (2015): Newsom, J. T. (2015). Longitudinal structural
equation modeling: A comprehensive introduction. Routledge.

## See also

Other structural equation modeling:
[`equiv_chi()`](https://devpsylab.github.io/petersenlab/reference/equiv_chi.md),
[`make_esem_model()`](https://devpsylab.github.io/petersenlab/reference/make_esem_model.md),
[`puc()`](https://devpsylab.github.io/petersenlab/reference/puc.md),
[`satorraBentlerScaledChiSquareDifferenceTestStatistic()`](https://devpsylab.github.io/petersenlab/reference/satorraBentlerScaledChiSquareDifferenceTestStatistic.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md)

## Examples

``` r
# Prepare Data
library("lavaan")
#> This is lavaan 0.6-21
#> lavaan is FREE software! Please report any bugs.

# Model
HS.model <- '
  visual =~ x1 + x2 + x3
            textual =~ x4 + x5 + x6
            speed   =~ x7 + x8 + x9
'

# configural invariance
fit1 <- lavaan::cfa(
  HS.model,
  data = HolzingerSwineford1939,
  group = "school")

# weak invariance
fit2 <- lavaan::cfa(
  HS.model,
  data = HolzingerSwineford1939,
  group = "school",
  group.equal = "loadings")

# strong invariance
fit3 <- lavaan::cfa(
  HS.model,
  data = HolzingerSwineford1939,
  group = "school",
  group.equal = c("intercepts", "loadings"))

# model comparison tests
lavaan::lavTestLRT(fit1, fit2, fit3)
#> 
#> Chi-Squared Difference Test
#> 
#>      Df    AIC    BIC  Chisq Chisq diff    RMSEA Df diff Pr(>Chisq)    
#> fit1 48 7484.4 7706.8 115.85                                           
#> fit2 54 7480.6 7680.8 124.04      8.192 0.049272       6     0.2244    
#> fit3 60 7508.6 7686.6 164.10     40.059 0.194211       6  4.435e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# effect size of measurement noninvariance
measurementNoninvarianceEffectSize(
  model_unconstrained = fit1,
  model_constrained = fit2)
#> $Mc_unconstrained
#> [1] 0.8930742
#> 
#> $Mc_constrained
#> [1] 0.8898172
#> 
#> $Delta_Mc
#> [1] 0.003257042
#> 
#> $w
#> [1] 0.06735059
#> 

measurementNoninvarianceEffectSize(
  model_unconstrained = fit2,
  model_constrained = fit3)
#> $Mc_unconstrained
#> [1] 0.8898172
#> 
#> $Mc_constrained
#> [1] 0.8407132
#> 
#> $Delta_Mc
#> [1] 0.04910401
#> 
#> $w
#> [1] 0.1489336
#> 
```
