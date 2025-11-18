# Correlation Matrix.

Function that creates a correlation matrix similar to SPSS output.

## Usage

``` r
cor.table(x, y, type = "none", dig = 2, correlation = "pearson")
```

## Arguments

- x:

  Variable or set of variables in the form of a vector or dataframe to
  correlate with `y` (if `y` is specified) in an any asymmetric
  correlation matrix or with itself in a symmetric correlation matrix
  (if `y` is not specified).

- y:

  (optional) Variable or set of variables in the form of a vector or
  dataframe to correlate with `x`.

- type:

  Type of correlation matrix to print. One of:

  - `"none"` = correlation matrix with *r*, *n*, *p*-values

  - `"latex"` = generates latex code for correlation matrix with only
    *r*-values

  - `"latexSPSS"` = generates latex code for full SPSS-style correlation
    matrix

  - `"manuscript"` = only *r*-values, 2 digits; works with `x` only
    (cannot enter variables for `y`)

  - `"manuscriptBig"` = only *r*-values, 2 digits, no asterisks; works
    with `x` only (cannot enter variables for `y`)

  - `"manuscriptLatex"` = generates latex code for: only *r*-values, 2
    digits; works with `x` only (cannot enter variables for `y`)

  - `"manuscriptBigLatex"` = generates latex code for: only *r*-values,
    2 digits, no asterisks; works with `x` only (cannot enter variables
    for `x`)

- dig:

  Number of decimals to print.

- correlation:

  Method for calculating the association. One of:

  - `"pearson"` = Pearson product moment correlation coefficient

  - `"spearman"` = Spearman's rho

  - `"kendall"` = Kendall's tau

## Value

A correlation matrix.

## Details

Co-created by Angela Staples (astaples@emich.edu) and Isaac Petersen
(isaac-t-petersen@uiowa.edu). For a partial correlation matrix, see
[partialcor.table](https://devpsylab.github.io/petersenlab/reference/partialcor.table.md).

## See also

Other correlations:
[`addText()`](https://devpsylab.github.io/petersenlab/reference/addText.md),
[`crossTimeCorrelation()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelation.md),
[`crossTimeCorrelationDF()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelationDF.md),
[`partialcor.table()`](https://devpsylab.github.io/petersenlab/reference/partialcor.table.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

## Examples

``` r
# Prepare Data
data("mtcars")

# Correlation Matrix
cor.table(mtcars[,c("mpg","cyl","disp")])
#>               mpg     cyl    disp
#> 1. mpg.r     1.00 -.85*** -.85***
#> 2. sig         NA     .00     .00
#> 3. n           32      32      32
#> 4. cyl.r  -.85***    1.00  .90***
#> 5. sig        .00      NA     .00
#> 6. n           32      32      32
#> 7. disp.r -.85***  .90***    1.00
#> 8. sig        .00     .00      NA
#> 9. n           32      32      32
cor.table(mtcars[,c("mpg","cyl","disp")])
#>               mpg     cyl    disp
#> 1. mpg.r     1.00 -.85*** -.85***
#> 2. sig         NA     .00     .00
#> 3. n           32      32      32
#> 4. cyl.r  -.85***    1.00  .90***
#> 5. sig        .00      NA     .00
#> 6. n           32      32      32
#> 7. disp.r -.85***  .90***    1.00
#> 8. sig        .00     .00      NA
#> 9. n           32      32      32
cor.table(mtcars[,c("mpg","cyl","disp")], dig = 3)
#>                mpg      cyl     disp
#> 1. mpg.r     1.000 -.852*** -.848***
#> 2. sig          NA     .000     .000
#> 3. n            32       32       32
#> 4. cyl.r  -.852***    1.000  .902***
#> 5. sig        .000       NA     .000
#> 6. n            32       32       32
#> 7. disp.r -.848***  .902***    1.000
#> 8. sig        .000     .000       NA
#> 9. n            32       32       32
cor.table(mtcars[,c("mpg","cyl","disp")], dig = 3, correlation = "spearman")
#>                mpg      cyl     disp
#> 1. mpg.r     1.000 -.911*** -.909***
#> 2. sig          NA     .000     .000
#> 3. n            32       32       32
#> 4. cyl.r  -.911***    1.000  .928***
#> 5. sig        .000       NA     .000
#> 6. n            32       32       32
#> 7. disp.r -.909***  .928***    1.000
#> 8. sig        .000     .000       NA
#> 9. n            32       32       32

cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscript", dig = 3)
#>              mpg     cyl  disp
#> 1. mpg     1.000              
#> 2. cyl  -.852***   1.000      
#> 3. disp -.848*** .902*** 1.000
cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptBig")
#>          mpg  cyl disp
#> 1. mpg  1.00          
#> 2. cyl  -.85 1.00     
#> 3. disp -.85  .90 1.00

table1 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "latex")
table2 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "latexSPSS")
table3 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptLatex")
table4 <- cor.table(mtcars[,c("mpg","cyl","disp")], type = "manuscriptBigLatex")

cor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")])
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#>              drat    qsec
#> 1. mpg.r   .68***    .42*
#> 2. sig        .00     .02
#> 3. n           32      32
#> 4. cyl.r  -.70*** -.59***
#> 5. sig        .00     .00
#> 6. n           32      32
#> 7. disp.r -.71***   -.43*
#> 8. sig        .00     .01
#> 9. n           32      32
cor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")], type = "manuscript", dig = 3)
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#> Warning: NAs introduced by coercion
#>             drat     qsec
#> 1. mpg   .681***    .419*
#> 2. cyl  -.700*** -.591***
#> 3. disp -.710***   -.434*
```
