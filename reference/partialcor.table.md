# Partial Correlation Matrix.

Function that creates a partial correlation matrix similar to SPSS
output.

## Usage

``` r
partialcor.table(
  x,
  y,
  z = NULL,
  type = "none",
  dig = 2,
  correlation = "pearson"
)
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

- z:

  Covariate(s) to partial out from association.

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

A partial correlation matrix.

## Details

Co-created by Angela Staples (astaples@emich.edu) and Isaac Petersen
(isaac-t-petersen@uiowa.edu). Creates a partial correlation matrix,
controlling for one or more covariates. For a standard correlation
matrix, see
[cor.table](https://devpsylab.github.io/petersenlab/reference/cor.table.md).

## See also

Other correlations:
[`addText()`](https://devpsylab.github.io/petersenlab/reference/addText.md),
[`cor.table()`](https://devpsylab.github.io/petersenlab/reference/cor.table.md),
[`crossTimeCorrelation()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelation.md),
[`crossTimeCorrelationDF()`](https://devpsylab.github.io/petersenlab/reference/crossTimeCorrelationDF.md),
[`vwReg()`](https://devpsylab.github.io/petersenlab/reference/vwReg.md)

## Examples

``` r
# Prepare Data
data("mtcars")

#Correlation Matrix
partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars$hp)
#>               mpg     cyl    disp
#> 1. mpg.r     1.00 -.59*** -.61***
#> 2. sig         NA     .00     .00
#> 3. n           32      32      32
#> 4. cyl.r  -.59***    1.00  .72***
#> 5. sig        .00      NA     .00
#> 6. n           32      32      32
#> 7. disp.r -.61***  .72***    1.00
#> 8. sig        .00     .00      NA
#> 9. n           32      32      32
partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")])
#>             mpg    cyl   disp
#> 1. mpg.r   1.00  -.31†   -.02
#> 2. sig       NA    .09    .93
#> 3. n         32     32     32
#> 4. cyl.r  -.31†   1.00 .54***
#> 5. sig      .09     NA    .00
#> 6. n         32     32     32
#> 7. disp.r  -.02 .54***   1.00
#> 8. sig      .93    .00     NA
#> 9. n         32     32     32
partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
  dig = 3)
#>              mpg    cyl   disp
#> 1. mpg.r   1.000 -.307†  -.017
#> 2. sig        NA   .087   .926
#> 3. n          32     32     32
#> 4. cyl.r  -.307†  1.000 .542**
#> 5. sig      .087     NA   .001
#> 6. n          32     32     32
#> 7. disp.r  -.017 .542**  1.000
#> 8. sig      .926   .001     NA
#> 9. n          32     32     32
partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
  dig = 3, correlation = "spearman")
#>             mpg    cyl   disp
#> 1. mpg.r  1.000  -.236  -.271
#> 2. sig       NA   .193   .134
#> 3. n         32     32     32
#> 4. cyl.r  -.236  1.000 .509**
#> 5. sig     .193     NA   .003
#> 6. n         32     32     32
#> 7. disp.r -.271 .509**  1.000
#> 8. sig     .134   .003     NA
#> 9. n         32     32     32

partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
  type = "manuscript", dig = 3)
#>            mpg    cyl  disp
#> 1. mpg   1.000             
#> 2. cyl  -.307†  1.000      
#> 3. disp  -.017 .542** 1.000
partialcor.table(mtcars[,c("mpg","cyl","disp")], z = mtcars[,c("hp","wt")],
  type = "manuscriptBig")
#>          mpg  cyl disp
#> 1. mpg  1.00          
#> 2. cyl  -.31 1.00     
#> 3. disp -.02  .54 1.00

table1 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
  z = mtcars[,c("hp","wt")], type = "latex")
table2 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
  z = mtcars[,c("hp","wt")], type = "latexSPSS")
table3 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
  z = mtcars[,c("hp","wt")], type = "manuscriptLatex")
table4 <- partialcor.table(mtcars[,c("mpg","cyl","disp")],
  z = mtcars[,c("hp","wt")], type = "manuscriptBigLatex")

partialcor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")],
  mtcars[,c("hp","wt")])
#>            drat  qsec
#> 1. mpg.r    .24   .21
#> 2. sig      .18   .24
#> 3. n         32    32
#> 4. cyl.r  -.48* -.45*
#> 5. sig      .01   .01
#> 6. n         32    32
#> 7. disp.r -.33†  -.29
#> 8. sig      .07   .11
#> 9. n         32    32
partialcor.table(mtcars[,c("mpg","cyl","disp")], mtcars[,c("drat","qsec")],
  mtcars[,c("hp","wt")], type = "manuscript", dig = 3)
#>            drat    qsec
#> 1. mpg     .241    .215
#> 2. cyl  -.479** -.453**
#> 3. disp  -.328†   -.288
```
