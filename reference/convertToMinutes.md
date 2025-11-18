# Convert Time to Minutes.

Convert times to minutes.

## Usage

``` r
convertToMinutes(hours, minutes, seconds, HHMMSS, HHMM, MMSS)
```

## Arguments

- hours:

  Character vector of the number of hours.

- minutes:

  Character vector of the number of minutes.

- seconds:

  Character vector of the number of seconds.

- HHMMSS:

  Times in HH:MM:SS format.

- HHMM:

  Character vector of times in HH:MM format.

- MMSS:

  Character vector of times in MM:SS format.

## Value

Vector of times in minutes.

## Details

Converts times to minutes. To convert times to hours or seconds, see
[convertToHours](https://devpsylab.github.io/petersenlab/reference/convertToHours.md)
or
[convertToSeconds](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md).

## See also

Other times:
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md)

Other conversion:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md),
[`percentileToTScore()`](https://devpsylab.github.io/petersenlab/reference/percentileToTScore.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
# Prepare Data
df <- data.frame(hours = c(0,1), minutes = c(15,27), seconds = c(30,13),
  HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"))

# Convert to Minutes
convertToMinutes(hours = df$hours, minutes = df$minutes,
  seconds = df$seconds)
#> [1] 15.50000 87.21667
convertToMinutes(HHMMSS = df$HHMMSS)
#> [1] 15.50000 87.21667
convertToMinutes(HHMM = df$HHMM)
#> [1] 15 87
```
