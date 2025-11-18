# Update Nested Models in Hierarchical Regression.

Wrapper function to ensure the same observations are used for each
updated model as were used in the first model.

## Usage

``` r
update_nested(object, formula., ..., evaluate = TRUE)
```

## Arguments

- object:

  model object to update

- formula.:

  updated model formula

- ...:

  further parameters passed to the fitting function

- evaluate:

  whether to evaluate the model. One of: `TRUE` or `FALSE`

## Value

`lm` model

## Details

Convenience wrapper function to ensure the same observations are used
for each updated model as were used in the first model, to ensure
comparability of models.

## See also

<https://stackoverflow.com/a/37341927>

<https://stackoverflow.com/a/37416336>

<https://stackoverflow.com/a/47195348>

Other multipleRegression:
[`lmCombine()`](https://devpsylab.github.io/petersenlab/reference/lmCombine.md),
[`plot2WayInteraction()`](https://devpsylab.github.io/petersenlab/reference/plot2WayInteraction.md),
[`ppPlot()`](https://devpsylab.github.io/petersenlab/reference/ppPlot.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md)

## Examples

``` r
# Prepare Data
data("mtcars")

dat <- mtcars

# Create some missing values in mtcars
dat[1, "wt"] <- NA
dat[5, "cyl"] <- NA
dat[7, "hp"] <- NA

m1 <- lm(mpg ~ wt + cyl + hp, data = dat)
m2 <- update_nested(m1, . ~ . - wt)  # Remove wt
m3 <- update_nested(m1, . ~ . - cyl) # Remove cyl
m4 <- update_nested(m1, . ~ . - wt - cyl) # Remove wt and cyl
m5 <- update_nested(m1, . ~ . - wt - cyl - hp) # Remove all three variables
# (i.e., model with intercept only)

anova(m1, m2, m3, m4, m5)
#> Analysis of Variance Table
#> 
#> Model 1: mpg ~ wt + cyl + hp
#> Model 2: mpg ~ cyl + hp
#> Model 3: mpg ~ wt + hp
#> Model 4: mpg ~ hp
#> Model 5: mpg ~ 1
#>   Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
#> 1     25  169.38                                  
#> 2     26  280.28 -1   -110.90 16.369 0.0004404 ***
#> 3     26  186.04  0     94.24                     
#> 4     27  443.80 -1   -257.76 38.045 1.892e-06 ***
#> 5     28 1088.40 -1   -644.60 95.141 5.287e-10 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
