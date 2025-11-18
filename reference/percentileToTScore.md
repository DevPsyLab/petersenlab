# Percentile to T-Score Conversion.

Conversion of percentile ranks to T-scores.

## Usage

``` r
percentileToTScore(percentileRank)
```

## Arguments

- percentileRank:

  Vector of percentile ranks.

## Value

Vector of T-scores.

## Details

Converts percentile ranks to the equivalent T-scores.

## See also

Other conversion:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
percentileRanks <- c(1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 99)

percentileToTScore(percentileRanks)
#>  [1] 26.73652 37.18448 41.58379 44.75599 47.46653 50.00000 52.53347 55.24401
#>  [9] 58.41621 62.81552 73.26348
```
