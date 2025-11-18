# Recode Intensity.

Recode intensity of behavior based on frequency of behavior.

## Usage

``` r
recode_intensity(intensity, did_not_occur = NULL, frequency = NULL)

mark_intensity_as_zero(
  item_names,
  data,
  did_not_occur_vars = NULL,
  frequency_vars = NULL
)
```

## Arguments

- intensity:

  The intensity of the behavior.

- did_not_occur:

  Whether or not the behavior did NOT occur. If `0`, the behavior did
  occur (in the given timeframe). If `1`, the behavior did not occur in
  (in the given timeframe).

- frequency:

  The frequency of the behavior.

- item_names:

  The names of the questionnaire items.

- data:

  The data object.

- did_not_occur_vars:

  The name(s) of the variables corresponding to whether the behavior did
  not occur in the past year (`did_not_occur`).

- frequency_vars:

  The name(s) of the variables corresponding to the number of
  occurrences (`num_occurrences`).

## Value

The intensity of the behavior.

## Details

Recodes the intensity of behavior to zero if the frequency of the
behavior is zero (i.e., if the behavior has not occurred).
