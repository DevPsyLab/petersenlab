# Add Correlation to Scatterplot.

Add correlation text to scatterplot.

## Usage

``` r
addText(
  x,
  y,
  xcoord = NULL,
  ycoord = NULL,
  size = 1,
  col = NULL,
  method = "pearson"
)
```

## Arguments

- x:

  vector of the variable for the x-axis.

- y:

  vector of the variable for the y-axis.

- xcoord:

  x-coordinate for the location of the text.

- ycoord:

  y-coordinate for the location of the text.

- size:

  size of the text font.

- col:

  color of the text font.

- method:

  method for calculating the association. One of:

  - `"pearson"` = Pearson product moment correlation coefficient

  - `"spearman"` = Spearman's rho

  - `"kendall"` = Kendall's tau

## Value

Correlation coefficient, degrees of freedom, and p-value printed on
scatterplot.

## Details

Adds a correlation coefficient and associated p-value to a scatterplot.

## See also

Other plot:
[`plot2WayInteraction()`](https://devpsylab.github.io/petersenlab/reference/plot2WayInteraction.md),
[`ppPlot()`](https://devpsylab.github.io/petersenlab/reference/ppPlot.md),
[`semPlotInteraction()`](https://devpsylab.github.io/petersenlab/reference/semPlotInteraction.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

Other correlations:
[`cor.table()`](https://devpsylab.github.io/petersenlab/reference/cor.table.md),
[`crossTimeCorrelation()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelation.md),
[`crossTimeCorrelationDF()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelationDF.md),
[`partialcor.table()`](https://devpsylab.github.io/petersenlab/reference/partialcor.table.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

## Examples

``` r
# Prepare Data
data("USArrests")

# Scatterplot
plot(USArrests$Assault, USArrests$Murder)
addText(x = USArrests$Assault, y = USArrests$Murder)
```
