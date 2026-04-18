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
#> -10.0469  -1.9395  -0.0028   2.0349   8.8112 
#> 
#> Coefficients:
#>                      Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.292154   1.653594  -0.781    0.435    
#> predictor            1.844856   0.159356  11.577   <2e-16 ***
#> moderator            1.335923   0.032719  40.830   <2e-16 ***
#> predictor:moderator  1.496369   0.003161 473.359   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.975 on 996 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 3.024e+06 on 3 and 996 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                     Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         -1.23944    1.65299   -0.75    0.454    
#> predictor            1.84174    0.15927   11.56   <2e-16 ***
#> moderator            1.33465    0.03271   40.80   <2e-16 ***
#> covariate           -0.14444    0.09758   -1.48    0.139    
#> predictor:moderator  1.49645    0.00316  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                       Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)         824.867155   0.094035 8771.96   <2e-16 ***
#> predictor            76.623395   0.031112 2462.79   <2e-16 ***
#> moderator            16.165927   0.009308 1736.77   <2e-16 ***
#> covariate            -0.144440   0.097581   -1.48    0.139    
#> predictor:moderator   1.496454   0.003160  473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
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
#> -10.1060  -1.8959  -0.0078   2.0585   9.1758 
#> 
#> Coefficients:
#>                       Estimate Std. Error  t value Pr(>|t|)    
#> (Intercept)         -7.361e+02  5.694e-01 -1292.82   <2e-16 ***
#> predictor            7.583e+01  3.107e-02  2440.90   <2e-16 ***
#> moderator            1.618e+01  9.308e-03  1738.64   <2e-16 ***
#> covariate           -1.444e-01  9.758e-02    -1.48    0.139    
#> predictorXmoderator  1.496e+00  3.160e-03   473.59   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 2.973 on 995 degrees of freedom
#> Multiple R-squared:  0.9999, Adjusted R-squared:  0.9999 
#> F-statistic: 2.271e+06 on 4 and 995 DF,  p-value: < 2.2e-16
#> 
```
