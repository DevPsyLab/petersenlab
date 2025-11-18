# Clean Up Player Names For Merging.

Cleans up names of players for merging.

## Usage

``` r
cleanUpNames(name)
```

## Arguments

- name:

  character vector of player names.

## Value

Vector of cleaned player names.

## Details

Cleans up names of NFL Football players, including making them all-caps,
removing common suffixes, punctuation, spaces, etc. This is helpful for
merging multiple datasets.

## Examples

``` r
oldNames <- c("Peyton Manning","Tom Brady","Marvin Harrison Jr.")
cleanNames <- cleanUpNames(oldNames)
cleanNames
#> [1] "PEYTONMANNING"  "TOMBRADY"       "MARVINHARRISON"
```
