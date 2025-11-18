# Summarize mixed effects model.

Summarizes the results of a model fit by the `lme()` function of the
`nlme` package.

## Usage

``` r
lmeSummary(model, dig = 3)
```

## Arguments

- model:

  name of [`lme()`](https://rdrr.io/pkg/nlme/man/lme.html) model object.

- dig:

  number of decimals to print in output.

## Value

Output summary of [`lme()`](https://rdrr.io/pkg/nlme/man/lme.html) model
object.

## Details

Summarizes the results of a model fit by the
[`lme()`](https://rdrr.io/pkg/nlme/man/lme.html) function of the `nlme`
package. Includes summary of parameters, pseudo-r-squared, and whether
model is positive definite.

## See also

Other mixedModel:
[`lm.beta.lmer()`](https://devpsylab.github.io/petersenlab/reference/lm.beta.lmer.md)

## Examples

``` r
# Fit Model
library("nlme")
#> 
#> Attaching package: ‘nlme’
#> The following object is masked from ‘package:lme4’:
#> 
#>     lmList
model <- lme(distance ~ age + Sex, data = Orthodont, random = ~ 1 + age)

# Model Summary
summary(model)
#> Linear mixed-effects model fit by REML
#>   Data: Orthodont 
#>        AIC      BIC    logLik
#>   449.2339 467.8116 -217.6169
#> 
#> Random effects:
#>  Formula: ~1 + age | Subject
#>  Structure: General positive-definite, Log-Cholesky parametrization
#>             StdDev    Corr  
#> (Intercept) 2.7970227 (Intr)
#> age         0.2264274 -0.766
#> Residual    1.3100398       
#> 
#> Fixed effects:  distance ~ age + Sex 
#>                 Value Std.Error DF   t-value p-value
#> (Intercept) 17.635200 0.8862449 80 19.898788   0.000
#> age          0.660185 0.0712532 80  9.265338   0.000
#> SexFemale   -2.145492 0.7574539 25 -2.832504   0.009
#>  Correlation: 
#>           (Intr) age   
#> age       -0.838       
#> SexFemale -0.348  0.000
#> 
#> Standardized Within-Group Residuals:
#>         Min          Q1         Med          Q3         Max 
#> -3.08141704 -0.45675583  0.01552695  0.44704158  3.89437694 
#> 
#> Number of Observations: 108
#> Number of Groups: 27 
lmeSummary(model)
#> [[1]]
#>             [,1]                    
#> modelPosDef "Positive Definite: Yes"
#> modelFit    "Pseudo R-square: 0.868"
#> 
#> [[2]]
#>              Value Std.Error DF t-value p-value
#> (Intercept) 17.635     0.886 80  19.899   0.000
#> age          0.660     0.071 80   9.265   0.000
#> SexFemale   -2.145     0.757 25  -2.833   0.009
#> 
```
