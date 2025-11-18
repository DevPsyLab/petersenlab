# Sorts loadings from exploratory factor analysis.

Sorts items' loadings based on their loadings from exploratory factor
analysis fit with the
[`psych::fa()`](https://rdrr.io/pkg/psych/man/fa.html) function.

## Usage

``` r
my_loadings_sorter(
  fit,
  sort_type = "largest_loading",
  nchar = 40,
  return_blocks = FALSE,
  showlatentcor = TRUE,
  itemLabels = NULL
)
```

## Arguments

- fit:

  the fitted object from the
  [`psych::fa()`](https://rdrr.io/pkg/psych/man/fa.html) function

- sort_type:

  how to sort the loadings. One of:

  - "largest_loading": sorts items by the largest loading

  - "largest_loading_but_first": sorts items by the largest loading,
    ignoring the loading on the first factor

  - "first": sorts items by the largest loading on the first factor

- nchar:

  the limit for the number of characters to display for the item label

- return_blocks:

  whether to return the block number that corresponds to each item

- showlatentcor:

  whether or not to print the intercorrelation among the latent factors
  (only possible for models with an oblique rotation)

- itemLabels:

  a vector of the item labels

## Value

Sorted loadings from exploratory factor analysis model.

## Details

Adapted from code by Philipp Doebler (doebler@statistik.tu-dortmund.de).
