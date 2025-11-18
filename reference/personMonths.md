# Person Months.

Calculate perons months for personnel effort in grants.

## Usage

``` r
percentEffort(
  academicMonths = NULL,
  calendarMonths = NULL,
  summerMonths = NULL,
  appointment = 9
)

personMonths(
  academicMonths = NULL,
  calendarMonths = NULL,
  summerMonths = NULL,
  effortAcademic = NULL,
  effortCalendar = NULL,
  effortSummer = NULL,
  appointment = 9
)
```

## Arguments

- academicMonths:

  The number of academic months.

- calendarMonths:

  The number of calendar months.

- summerMonths:

  The number of summer months.

- appointment:

  The duration (in months) of one's annual appointment; used as the
  denominator for determining the timeframe out of which the academic
  months occur. Default is a 9-month appointment.

- effortAcademic:

  Percent effort (in proportion) during academic months.

- effortCalendar:

  Percent effort (in proportion) during calendar months.

- effortSummer:

  Percent effort (in proportion) during summer months.

## Value

The person months of effort.

## Details

Calculate person months for personnel effort in grant proposals from
academic months, calendar months, and summer months.

## See also

<https://web.archive.org/web/20250211141002/https://nexus.od.nih.gov/all/2015/05/27/how-do-you-convert-percent-effort-into-person-months/>

## Examples

``` r
# Specify Values
appointmentDuration <- 9 #(in months)

# Specify either Set 1 (months) or Set 2 (percent effort) below:

#Set 1: Months
academicMonths <- 1.3 #AY (academic year) months (should be between 0 to appointmentDuration)
calendarMonths <- 0 #CY (calendar year) months (should be between 0-12)
summerMonths <- 0.5 #SM (summer) months (should be between 0 to [12-appointmentDuration])

# Set 2: Percent Effort
percentEffortAcademic <- 0.1444444 #(a proportion; should be between 0-1)
percentEffortCalendar <- 0 #(a proportion; should be between 0-1)
percentEffortSummer <- 0.1666667 #(a proportion; should be between 0-1)

# Calculations
summerDuration <- 12 - appointmentDuration

# Percent effort (in proportion)
percentEffort(academicMonths = academicMonths)
#> [1] 0.1444444
percentEffort(calendarMonths = calendarMonths)
#> [1] 0
percentEffort(summerMonths = summerMonths)
#> [1] 0.1666667

# Person-Months From NIH Website
(percentEffort(academicMonths = academicMonths) * appointmentDuration) +
 (percentEffort(calendarMonths = calendarMonths) * 12) +
 (percentEffort(summerMonths = summerMonths) * summerDuration)
#> [1] 1.8

# Person-Months from Academic/Calendar/Summer Months
personMonths(academicMonths = academicMonths,
             calendarMonths = calendarMonths,
             summerMonths = summerMonths)
#> [1] 1.8

# Person-Months from Percent Effort
personMonths(effortAcademic = percentEffortAcademic,
             effortCalendar = percentEffortCalendar,
             effortSummer = percentEffortSummer)
#> [1] 1.8
```
