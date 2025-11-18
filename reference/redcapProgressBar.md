# Progress Bar for REDCap.

Function that identifies the values for a progress bar in REDCap.

## Usage

``` r
redcapProgressBar(numSurveys, beginning = 2, end = 99)
```

## Arguments

- numSurveys:

  the number of surveys to establish progress.

- beginning:

  the first value to use in the sequence.

- end:

  the last value to use in the sequence.

## Value

sequence of numbers for the progress bar in REDCap.

## Details

A progress bar in REDCap can be created using the following code:

      Progress:
      <div style="width:100%;border:0;margin:0;padding:0;background-color:
      #A9BAD1;text-align:center;"><div style="width:2%;border: 0;margin:0;
      padding:0;background-color:#8491A2"><span style="color:#8491A2">.
      </span></div></div>

where `width:2%` specifies the progress (out of 100%).

## Examples

``` r
redcapProgressBar(numSurveys = 6)
#> [1]  2.0 21.4 40.8 60.2 79.6 99.0
redcapProgressBar(6)
#> [1]  2.0 21.4 40.8 60.2 79.6 99.0
redcapProgressBar(4)
#> [1]  2.00000 34.33333 66.66667 99.00000
redcapProgressBar(numSurveys = 7, beginning = 1, end = 99)
#> [1]  1.00000 17.33333 33.66667 50.00000 66.33333 82.66667 99.00000
```
