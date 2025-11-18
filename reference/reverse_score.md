# Reverse Score Variables.

Reverse score variables using either the theoretical min and max, or the
observed max.

## Usage

``` r
reverse_score(
  data,
  variables,
  theoretical_max = NULL,
  theoretical_min = NULL,
  append_string = NULL
)
```

## Arguments

- data:

  Data object.

- variables:

  Names of variables to reverse score.

- theoretical_max:

  (Optional): the theoretical maximum score.

- theoretical_min:

  (Optional): the theoretical minimum score.

- append_string:

  (Optional): a string to append to each variable name.

## Value

Dataframe with reverse-scored variables.

## Details

Reverse scores variables using either the theoretical min and max (by
subtracting the theoretical maximum from each score and adding the
theoretical minimum to each score) or by subtracting each score from the
maximum score for that variable.

## Examples

``` r
mydata <- data.frame(
  var1 = c(1, 2, NA, 4, 5),
  var2 = c(NA, 4, 3, 2, 1)
)

variables_to_reverse_score <- c("var1", "var2")

reverse_score(
  mydata,
  variables = variables_to_reverse_score)
#>   var1 var2
#> 1    4   NA
#> 2    3    0
#> 3   NA    1
#> 4    1    2
#> 5    0    3

reverse_score(
  mydata,
  variables = variables_to_reverse_score,
  append_string = ".R")
#>   var1.R var2.R
#> 1      4     NA
#> 2      3      0
#> 3     NA      1
#> 4      1      2
#> 5      0      3

reverse_score(
  mydata,
  variables = variables_to_reverse_score,
  theoretical_max = 7)
#>   var1 var2
#> 1    6   NA
#> 2    5    3
#> 3   NA    4
#> 4    3    5
#> 5    2    6

reverse_score(
  mydata,
  variables = variables_to_reverse_score,
  theoretical_max = 7,
  theoretical_min = 1)
#>   var1 var2
#> 1    7   NA
#> 2    6    4
#> 3   NA    5
#> 4    4    6
#> 5    3    7
```
