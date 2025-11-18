# Convert AM and PM Hours.

Convert hours to 24-hour time.

## Usage

``` r
convertHoursAMPM(hours, ampm, am = 0, pm = 1, treatMorningAsLate = FALSE)
```

## Arguments

- hours:

  The vector of times in hours.

- ampm:

  Vector indicating whether given times are AM or PM.

- am:

  Value indicating AM in `ampm` variable.

- pm:

  Value indicating PM in `ampm` variable.

- treatMorningAsLate:

  `TRUE` or `FALSE` indicating whether to treat morning times as late
  (e.g., 1 AM would be considered a late bedtime, i.e., 25 hours, not an
  early bedtime).

## Value

Hours in 24-hour-time.

## Details

Convert hours to the number of hours in 24-hour time. You can specify
whether to treat morning hours (e.g., 1 AM) as late (25 H), e.g., for
specifying late bedtimes

## See also

Other times:
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md)

Other conversion:
[`convert.magic()`](https://devpsylab.github.io/petersenlab/reference/convert.magic.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md),
[`percentileToTScore()`](https://devpsylab.github.io/petersenlab/reference/percentileToTScore.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
# Prepare Data
df1 <- data.frame(hours = c(1, 1, 12, 12), ampm = c(0, 0, 1, 1))
df2 <- data.frame(hours = c(1, 1, 12, 12), ampm = c(1, 1, 0, 0))

# Convert AM and PM hours
convertHoursAMPM(hours = df1$hours, ampm = df1$ampm)
#> [1]  1  1 12 12
convertHoursAMPM(hours = df1$hours, ampm = df1$ampm,
  treatMorningAsLate = TRUE)
#> [1] 25 25 12 12

convertHoursAMPM(hours = df2$hours, ampm = df2$ampm, am = 1, pm = 0)
#> [1]  1  1 12 12
convertHoursAMPM(hours = df2$hours, ampm = df2$ampm, am = 1, pm = 0,
  treatMorningAsLate = TRUE)
#> [1] 25 25 12 12
```
