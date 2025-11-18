# PP Plot.

Normal Probability (P-P) Plot.

## Usage

``` r
ppPlot(model)
```

## Arguments

- model:

  The model object of a linear regression model fit using the
  [`lm()`](https://rdrr.io/r/stats/lm.html) function.

## Value

Normal probability (P-P) plot.

## Details

A normal probability (P-P) plot compares the empirical cumulative
distribution to the theoretical cumulative distribution.

## See also

<https://www.r-bloggers.com/2009/12/r-tutorial-series-graphic-analysis-of-regression-assumptions/>

Other plot:
[`addText()`](https://devpsylab.github.io/petersenlab/reference/addText.md),
[`plot2WayInteraction()`](https://devpsylab.github.io/petersenlab/reference/plot2WayInteraction.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

Other multipleRegression:
[`lmCombine()`](https://devpsylab.github.io/petersenlab/reference/lmCombine.md),
[`plot2WayInteraction()`](https://devpsylab.github.io/petersenlab/reference/plot2WayInteraction.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`update_nested()`](https://devpsylab.github.io/petersenlab/reference/update_nested.md)

## Examples

``` r
# Prepare Data
predictor1 <- rnorm(100)
predictor2 <- rnorm(100)
outcome <- rnorm(100)

# Fit Model
lmModel <- lm(outcome ~ predictor1 + predictor2)

# P-P Plot
ppPlot(lmModel)

```
