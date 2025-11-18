# Plot 2-way interaction.

Generates a plot of a 2-way interaction.

## Usage

``` r
plot2WayInteraction(
  predictor,
  outcome,
  moderator,
  predictorLabel = "predictor",
  outcomeLabel = "outcome",
  moderatorLabel = "moderator",
  varList,
  varTypes,
  values = NA,
  interaction = "normal",
  legendLabels = NA,
  legendLocation = "topright",
  ylim = NA,
  pvalues = TRUE,
  data
)
```

## Arguments

- predictor:

  character name of predictor variable (variable on x-axis).

- outcome:

  character name of outcome variable (variable on y-axis).

- moderator:

  character name of moderator variable (variable on z-axis).

- predictorLabel:

  label on x-axis of plot

- outcomeLabel:

  label on y-axis of plot

- moderatorLabel:

  label on z-axis of plot

- varList:

  names of predictor variables in model

- varTypes:

  types of predictor variables in model; one of:

  - `"mean"` = plots at mean of variable – should be used for ALL
    covariates (apart from main predictor and moderator)

  - `"sd"` = plots at +/- 1 sd of variable (for most continuous
    predictors and moderators)

  - `"binary"` = plots at values of 0,1 (for binary predictors and
    moderators)

  - `"full"` = plots full range of variable (for variables like age when
    on x-axis)

  - `"values"` = allows plotting moderator at specific values (e.g.,
    `0`, `1`, `2`)

  - `"factor"` = plots moderator at different categories (e.g., `TRUE`,
    `FALSE`)

- values:

  specifies values at which to plot moderator (must specify varType =
  `"values"`)

- interaction:

  one of:

  - `"normal"` = standard interaction

  - `"meancenter"` = calculates the interaction from a mean-centered
    predictor and moderator (subtracting each individual's value from
    the variable mean to set the mean of the variable to zero)

  - `"orthogonalize"` = makes the interaction orthogonal to the
    predictor and moderator by regressing the interaction on the
    predictor and outcome and saving the residual

- legendLabels:

  vector of 2 labels for the two levels of the moderator; leave as `NA`
  to see the actual levels of the moderator

- legendLocation:

  one of: `"topleft"`, `"topright"`, `"bottomleft"`, or `"bottomright"`

- ylim:

  vector of min and max values on y-axis (e,g., `0`, `10`)

- pvalues:

  whether to include p-values of each slope in plot (`TRUE` or `FALSE`)

- data:

  name of data object

## Value

Plot of two-way interaction.

## Details

Generates a plot of a 2-way interaction: the association between a
predictor and an outcome at two levels of the moderator.

## See also

Other plot:
[`addText()`](https://devpsylab.github.io/petersenlab/reference/addText.md),
[`ppPlot()`](https://devpsylab.github.io/petersenlab/reference/ppPlot.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

Other multipleRegression:
[`lmCombine()`](https://devpsylab.github.io/petersenlab/reference/lmCombine.md),
[`ppPlot()`](https://devpsylab.github.io/petersenlab/reference/ppPlot.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`update_nested()`](https://devpsylab.github.io/petersenlab/reference/update_nested.md)

## Examples

``` r
# Prepare Data
predictor <- rnorm(1000, 10, 3)
moderator <- rnorm(1000, 50, 10)
outcome <- (1.7 * predictor) + (1.3 * moderator) +
  (1.5 * predictor * moderator) + rnorm(1000, sd = 3)
covariate <- rnorm(1000)
df <- data.frame(predictor, moderator, outcome, covariate)

# Linear Regression
lmModel <- lm(outcome ~ predictor + moderator + predictor:moderator,
  data = df, na.action = "na.exclude")
summary(lmModel)
#> 
#> Call:
#> lm(formula = outcome ~ predictor + moderator + predictor:moderator, 
#>     data = df, na.action = "na.exclude")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.0946  -1.9719  -0.0184   2.1292   8.7541 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.202401   1.687107   -0.12    0.905    
#> predictor            1.746065   0.162076   10.77   <2e-16 ***
#> moderator            1.313694   0.033490   39.23   <2e-16 ***
#> predictor:moderator  1.498472   0.003229  464.12   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.011 on 996 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.917e+06 on 3 and 996 DF,  p-value: < 2.2e-16
#> 

# 1. Plot 2-Way Interaction
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

# 2. Specify y-axis Range
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),                                  #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

# 3. Add Variable Labels
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",                        #new
                    outcomeLabel = "Aggression",                      #new
                    moderatorLabel = "Gender",                        #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

# 4. Change Legend Labels
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",
                    outcomeLabel = "Aggression",
                    moderatorLabel = "Gender",
                    legendLabels = c("Boys","Girls"),                 #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

# 5. Move Legend Location
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",
                    outcomeLabel = "Aggression",
                    moderatorLabel = "Gender",
                    legendLabels = c("Boys","Girls"),
                    legendLocation = "topleft",                       #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

#6. Turn Off p-Values
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",
                    outcomeLabel = "Aggression",
                    moderatorLabel = "Gender",
                    legendLabels = c("Boys","Girls"),
                    legendLocation = "topleft",
                    pvalues = FALSE,                                  #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelData, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -0.148179   1.685545  -0.088   0.9300    
#> predictor            1.741212   0.161923  10.753   <2e-16 ***
#> moderator            1.312322   0.033463  39.218   <2e-16 ***
#> covariate           -0.177163   0.099470  -1.781   0.0752 .  
#> predictor:moderator  1.498591   0.003226 464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

#7. Get Regression Output from Mean-Centered Predictor and Moderator
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",
                    outcomeLabel = "Aggression",
                    moderatorLabel = "Gender",
                    legendLabels = c("Boys","Girls"),
                    legendLocation = "topleft",
                    interaction = "meancenter",                       #new
                    data = df)

#> 
#> Call:
#> lm(formula = modelFormula, data = modelDataMC, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                       Estimate Std. Error  t value Pr(>|t|)    
#> (Intercept)         824.418640   0.095168 8662.737   <2e-16 ***
#> predictor            76.574370   0.031503 2430.722   <2e-16 ***
#> moderator            16.166946   0.009438 1713.016   <2e-16 ***
#> covariate            -0.177163   0.099470   -1.781   0.0752 .  
#> predictor:moderator   1.498591   0.003226  464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 

#8. Get Regression Output from Orthogonalized Interaction Term
plot2WayInteraction(predictor = "predictor",
                    outcome = "outcome",
                    moderator = "moderator",
                    varList = c("predictor","moderator","covariate"),
                    varTypes = c("sd","binary","mean"),
                    ylim = c(10,50),
                    predictorLabel = "Stress",
                    outcomeLabel = "Aggression",
                    moderatorLabel = "Gender",
                    legendLabels = c("Boys","Girls"),
                    legendLocation = "topleft",
                    interaction = "orthogonalize",                    #new
                    data = df)
#> 
#> Call:
#> lm(formula = modelFormulaOrtho, data = modelDataOrtho, na.action = "na.omit")
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.1626  -1.9447  -0.0294   2.1367   9.2048 
#> 
#> Coefficients:
#>                       Estimate Std. Error   t value Pr(>|t|)    
#> (Intercept)         -7.356e+02  5.786e-01 -1271.510   <2e-16 ***
#> predictor            7.554e+01  3.142e-02  2403.950   <2e-16 ***
#> moderator            1.623e+01  9.437e-03  1719.400   <2e-16 ***
#> covariate           -1.772e-01  9.947e-02    -1.781   0.0752 .  
#> predictorXmoderator  1.499e+00  3.226e-03   464.558   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 3.008 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.193e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 
```
