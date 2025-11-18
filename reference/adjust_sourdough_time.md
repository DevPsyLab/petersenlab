# Adjust Sourdough Recipe Fermentation and Proofing Times Based on Temperature

Adjust sourdough recipe fermentation and proofing times based on
temperature.

## Usage

``` r
adjust_sourdough_time(
  original_time,
  recipe_temp,
  actual_temp,
  q10 = 2,
  temp_unit = c("F", "C")
)
```

## Arguments

- original_time:

  The original time(s) specified in the original recipe.

- recipe_temp:

  The intended ambient temperature in the original recipe.

- actual_temp:

  The actual ambient temperature used.

- q10:

  The \\Q\_{10}\\ temperature coefficient (describes rate change per
  10°C).

- temp_unit:

  "F" for Fahrenheit; "C" for Celsius.

## Value

The adjusted sourdough fermentation or proofing time(s).

## Details

Adjusts sourdough recipe fermentation and proofing times based on
ambient temperature. Suggested times are calculated using the
\\Q\_{10}\\ temperature coefficient, which describes how the rate of
fermentation changes with a 10°C temperature difference.

## See also

<https://en.wikipedia.org/wiki/Q10_(temperature_coefficient)>

## Examples

``` r
adjust_sourdough_time(
  original_time = c(12, 15, 18),
  recipe_temp = 70,
  actual_temp = 75
  )
#> [1]  9.898327 12.372909 14.847491
```
