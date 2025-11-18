# Frequency Per Duration.

Estimate frequency of a behavior for a particular duration.

## Usage

``` r
timesPerInterval(
  num_occurrences = NULL,
  interval = NULL,
  duration = "month",
  not_occurred_past_year = NULL
)

timesPerLifetime(num_occurrences = NULL, never_occurred = NULL)

computeItemFrequencies(
  item_names,
  data,
  duration = "month",
  frequency_vars,
  interval_vars,
  not_in_past_year_vars
)

computeLifetimeFrequencies(
  item_names,
  data,
  frequency_vars,
  never_occurred_vars
)
```

## Arguments

- num_occurrences:

  The number of times the behavior occurred during the specified
  interval, `interval`.

- interval:

  The specified interval corresponding to the number of times the
  behavior occurred, `num_occurrences`. One of:

  - `1` = average number of times per day

  - `2` = average number of times per week

  - `3` = number of times in the past month

  - `4` = number of times in the past year

- duration:

  The desired duration during which to estimate how many times the
  behavior occurred:

  - "day" = average number of times per day

  - "week" = average number of times per week

  - "month" = number of times in the past month

  - "year" = number of times in the past year

- not_occurred_past_year:

  Whether or not the behavior did NOT occur in the past year. If `0`,
  the behavior did occur in the past year. If `1`, the behavior did not
  occur in the past year.

- never_occurred:

  Whether or not the behavior has NEVER occurred in the person's
  lifetime. If `0`, the behavior has occurred in the person's lifetime.
  If `1`, the behavior has never occurred in the person's lifetime.

- item_names:

  The names of the questionnaire items.

- data:

  The data object.

- frequency_vars:

  The name(s) of the variables corresponding to the number of
  occurrences (`num_occurrences`).

- interval_vars:

  The name(s) of the variables corresponding to the intervals
  (`interval`).

- not_in_past_year_vars:

  The name(s) of the variables corresponding to whether the behavior did
  not occur in the past year (`not_occurred_past_year`).

- never_occurred_vars:

  The name(s) of the variables corresponding to whether the behavior has
  never occurred during the person's lifetime (`never_occurred`).

## Value

The frequency of the behavior for the specified duration.

## Details

Estimates the frequency of a given behavior for a particular duration,
given a specified number of times it occurred during a specified
interval.

## Examples

``` r
timesPerInterval(
  num_occurrences = 2,
  interval = 3,
  duration = "month",
  not_occurred_past_year = 0
)
#> [1] 2

timesPerInterval(
  duration = "month",
  not_occurred_past_year = 1
)
#> [1] 0

timesPerLifetime(
  num_occurrences = 2,
  never_occurred = 0
)
#> [1] 2

timesPerLifetime(
  never_occurred = 1
)
#> [1] 0
```
