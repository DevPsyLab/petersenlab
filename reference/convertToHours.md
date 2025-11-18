# Convert Time to Hours.

Convert times to hours.

## Usage

``` r
convertToHours(hours, minutes, seconds, HHMMSS, HHMM)
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

## Value

Vector of times in hours.

## Details

Converts times to hours. To convert times to minutes or seconds, see
[convertToMinutes](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md)
or
[convertToSeconds](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md).

## See also

Other times:
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md)

Other conversion:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md),
[`percentileToTScore()`](https://devpsylab.github.io/petersenlab/reference/percentileToTScore.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
# Prepare Data
df <- data.frame(hours = c(0,1), minutes = c(15,27), seconds = c(30,13),
  HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"))

# Convert to Hours
convertToHours(hours = df$hours, minutes = df$minutes, seconds = df$seconds)
#> [1] 0.2583333 1.4536111
convertToHours(HHMMSS = df$HHMMSS)
#> [1] 0.2583333 1.4536111
convertToHours(HHMM = df$HHMM)
#> [1] 0.25 1.45
```
