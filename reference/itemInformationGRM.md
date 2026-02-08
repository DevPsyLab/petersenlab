# Item Information in graded response model in item response theory.

Item information in graded response model in item response theory.

## Usage

``` r
calc_grm_probs(a, b_thresholds, theta)

itemInformationGRM(a, b_thresholds, theta)

get_thresholds(x)
```

## Arguments

- a:

  Discrimination parameter (slope).

- b_thresholds:

  Difficulty (severity) parameters (inflection point). Can be provided
  either as a vector (for a given item) or as a list (for multiple
  items).

- theta:

  Person's level on the construct.

- x:

  Dataframe.

## Value

`calc_grm_probs()` returns the probability of each response category;
`itemInformationGRM()` returns the amount of item information.

## Details

Estimates the amount of information provided by a given item in a graded
response model in item response theory as function of the item
parameters and the person's level on the construct (theta).

## See also

Other IRT:
[`deriv_d_negBinom()`](https://devpsylab.github.io/petersenlab/reference/itemInformationZINB.md),
[`discriminationToFactorLoading()`](https://devpsylab.github.io/petersenlab/reference/discriminationToFactorLoading.md),
[`fourPL()`](https://devpsylab.github.io/petersenlab/reference/fourPL.md),
[`itemInformation()`](https://devpsylab.github.io/petersenlab/reference/itemInformation.md),
[`reliabilityIRT()`](https://devpsylab.github.io/petersenlab/reference/reliabilityIRT.md),
[`standardErrorIRT()`](https://devpsylab.github.io/petersenlab/reference/standardErrorIRT.md),
[`test_info_4PL()`](https://devpsylab.github.io/petersenlab/reference/testInformation.md)

## Examples

``` r
calc_grm_probs(
 a = 1,
 b_thresholds = 0,
 theta = -4:4
)
#> [[1]]
#>             [,1]       [,2]
#>  [1,] 0.98201379 0.01798621
#>  [2,] 0.95257413 0.04742587
#>  [3,] 0.88079708 0.11920292
#>  [4,] 0.73105858 0.26894142
#>  [5,] 0.50000000 0.50000000
#>  [6,] 0.26894142 0.73105858
#>  [7,] 0.11920292 0.88079708
#>  [8,] 0.04742587 0.95257413
#>  [9,] 0.01798621 0.98201379
#> 

calc_grm_probs(
 a = 1,
 b_thresholds = c(-1, 1),
 theta = -4:4
)
#> [[1]]
#>              [,1]       [,2]        [,3]
#>  [1,] 0.952574127 0.04073302 0.006692851
#>  [2,] 0.880797078 0.10121671 0.017986210
#>  [3,] 0.731058579 0.22151555 0.047425873
#>  [4,] 0.500000000 0.38079708 0.119202922
#>  [5,] 0.268941421 0.46211716 0.268941421
#>  [6,] 0.119202922 0.38079708 0.500000000
#>  [7,] 0.047425873 0.22151555 0.731058579
#>  [8,] 0.017986210 0.10121671 0.880797078
#>  [9,] 0.006692851 0.04073302 0.952574127
#> 

itemInformationGRM(
 a = 1,
 b_thresholds = 0,
 theta = -4:4
)
#> [[1]]
#> [1] 0.01766271 0.04517666 0.10499359 0.19661193 0.25000000 0.19661193 0.10499359
#> [8] 0.04517666 0.01766271
#> 

itemInformationGRM(
 a = 1,
 b_thresholds = c(-1, 1),
 theta = -4:4
)
#> [[1]]
#> [1] 0.045176660 0.104993585 0.196611933 0.250000000 0.196611933 0.104993585
#> [7] 0.045176660 0.017662706 0.006648057
#> 

itemParameters <- data.frame(
 item = c(1, 2, 3),
 a = c(0.5, 1, 1.5),
 b1 = c(-1, 0, 1),
 b2 = c(0, 1, 2),
 b3 = c(1, 2, 3)
)

calc_grm_probs(
 a = itemParameters$a,
 b_thresholds = get_thresholds(itemParameters),
 theta = -4:4)
#> [[1]]
#>             [,1]       [,2]       [,3]       [,4]
#>  [1,] 0.81757448 0.06322260 0.04334474 0.07585818
#>  [2,] 0.73105858 0.08651590 0.06322260 0.11920292
#>  [3,] 0.62245933 0.10859925 0.08651590 0.18242552
#>  [4,] 0.50000000 0.12245933 0.10859925 0.26894142
#>  [5,] 0.37754067 0.12245933 0.12245933 0.37754067
#>  [6,] 0.26894142 0.10859925 0.12245933 0.50000000
#>  [7,] 0.18242552 0.08651590 0.10859925 0.62245933
#>  [8,] 0.11920292 0.06322260 0.08651590 0.73105858
#>  [9,] 0.07585818 0.04334474 0.06322260 0.81757448
#> 
#> [[2]]
#>             [,1]       [,2]        [,3]        [,4]
#>  [1,] 0.98201379 0.01129336 0.004220228 0.002472623
#>  [2,] 0.95257413 0.02943966 0.011293359 0.006692851
#>  [3,] 0.88079708 0.07177705 0.029439663 0.017986210
#>  [4,] 0.73105858 0.14973850 0.071777049 0.047425873
#>  [5,] 0.50000000 0.23105858 0.149738499 0.119202922
#>  [6,] 0.26894142 0.23105858 0.231058579 0.268941421
#>  [7,] 0.11920292 0.14973850 0.231058579 0.500000000
#>  [8,] 0.04742587 0.07177705 0.149738499 0.731058579
#>  [9,] 0.01798621 0.02943966 0.071777049 0.880797078
#> 
#> [[3]]
#>             [,1]         [,2]         [,3]         [,4]
#>  [1,] 0.99944722 0.0004293841 9.585888e-05 2.753569e-05
#>  [2,] 0.99752738 0.0019198445 4.293841e-04 1.233946e-04
#>  [3,] 0.98901306 0.0085143195 1.919845e-03 5.527786e-04
#>  [4,] 0.95257413 0.0364389305 8.514319e-03 2.472623e-03
#>  [5,] 0.81757448 0.1349996506 3.643893e-02 1.098694e-02
#>  [6,] 0.50000000 0.3175744762 1.349997e-01 4.742587e-02
#>  [7,] 0.18242552 0.3175744762 3.175745e-01 1.824255e-01
#>  [8,] 0.04742587 0.1349996506 3.175745e-01 5.000000e-01
#>  [9,] 0.01098694 0.0364389305 1.349997e-01 8.175745e-01
#> 


itemInformationGRM(
 a = itemParameters$a,
 b_thresholds = get_thresholds(itemParameters),
 theta = -4:4)
#> [[1]]
#> [1] 0.03772830 0.05055784 0.06256878 0.07103586 0.07405834 0.07103586 0.06256878
#> [8] 0.05055784 0.03772830
#> 
#> [[2]]
#> [1] 0.01766414 0.04520313 0.10542448 0.20181812 0.28587102 0.31214122 0.28587102
#> [8] 0.20181812 0.10542448
#> 
#> [[3]]
#> [1] 0.001243064 0.005549652 0.024449543 0.101690726 0.338250182 0.630303345
#> [7] 0.692850803 0.630303345 0.338250182
#> 
```
