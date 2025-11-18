# Cross-Time Correlations.

Calculate the association of a variable across multiple time points.

## Usage

``` r
crossTimeCorrelation(id = "tcid", time = "age", variable, data)
```

## Arguments

- id:

  Name of variable indicating the participant ID.

- time:

  Name of variable indicating the timepoint.

- variable:

  Name of variable to estimate the cross-time correlation.

- data:

  Dataframe.

## Value

output of [`cor.test()`](https://rdrr.io/r/stats/cor.test.html)

## Details

Calculate the association of a variable across multiple time points. It
is especially useful when there are three or more time points.

## See also

Other correlations:
[`addText()`](https://devpsylab.github.io/petersenlab/reference/addText.md),
[`cor.table()`](https://devpsylab.github.io/petersenlab/reference/cor.table.md),
[`crossTimeCorrelationDF()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelationDF.md),
[`partialcor.table()`](https://devpsylab.github.io/petersenlab/reference/partialcor.table.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

## Examples

``` r
# Prepare Data
df <- expand.grid(ID = 1:100, time = c(1, 2, 3))
df <- df[order(df$ID),]
row.names(df) <- NULL
df$score <- rnorm(nrow(df))

# Cross-Time Correlation
crossTimeCorrelation(id = "ID", time = "time", variable = "score", data = df)
#> 
#>  Pearson's product-moment correlation
#> 
#> data:  fullMatrix$time1 and fullMatrix$time2
#> t = -0.088467, df = 198, p-value = 0.9296
#> alternative hypothesis: true correlation is not equal to 0
#> 95 percent confidence interval:
#>  -0.1449016  0.1325697
#> sample estimates:
#>          cor 
#> -0.006286946 
#> 
```
