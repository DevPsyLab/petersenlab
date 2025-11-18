# Convert Time to Seconds.

Convert times to seconds.

## Usage

``` r
convertToSeconds(hours, minutes, seconds, HHMMSS, HHMM, MMSS)
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

Vector of times in seconds.

## Details

Converts times to seconds. To convert times to hours or minutes, see
[convertToHours](https://devpsylab.github.io/petersenlab/reference/convertToHours.md)
or
[convertToMinutes](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md).

## See also

Other times:
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md)

Other conversion:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`percentileToTScore()`](https://devpsylab.github.io/petersenlab/reference/percentileToTScore.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
# Prepare Data
df <- data.frame(hours = c(0,1), minutes = c(15,27), seconds = c(30,13),
  HHMMSS = c("00:15:30","01:27:13"), HHMM = c("00:15","01:27"),
  MMSS = c("15:30","87:13"))

# Convert to Minutes
convertToSeconds(hours = df$hours, minutes = df$minutes,
  seconds = df$seconds)
#> [1]  930 5233
convertToSeconds(HHMMSS = df$HHMMSS)
#> [1]  930 5233
convertToSeconds(HHMM = df$HHMM)
#> [1]  900 5220
convertToSeconds(MMSS = df$MMSS)
#> [1]  930 5233
```
