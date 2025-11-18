# Convert Variable Types.

Converts variable types of multiple columns of a dataframe at once.

## Usage

``` r
convert.magic(obj, type)
```

## Arguments

- obj:

  name of dataframe (object)

- type:

  type to convert variables to one of:

  - `"character"`

  - `"numeric"`

  - `"factor"`

## Value

Dataframe with columns converted to a particular type.

## Details

Converts variable types of multiple columns of a dataframe at once.
Convert variable types to character, numeric, or factor.

## See also

<https://stackoverflow.com/questions/11261399/function-for-converting-dataframe-column-type/11263399#11263399>

Other dataManipulation:
[`columnBindFill()`](https://devpsylab.github.io/petersenlab/reference/columnBindFill.md),
[`dropColsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropColsWithAllNA.md),
[`dropRowsWithAllNA()`](https://devpsylab.github.io/petersenlab/reference/dropRowsWithAllNA.md),
[`varsDifferentTypes()`](https://devpsylab.github.io/petersenlab/reference/varsDifferentTypes.md)

Other conversion:
[`convertHoursAMPM()`](https://devpsylab.github.io/petersenlab/reference/convertHoursAMPM.md),
[`convertToHours()`](https://devpsylab.github.io/petersenlab/reference/convertToHours.md),
[`convertToMinutes()`](https://devpsylab.github.io/petersenlab/reference/convertToMinutes.md),
[`convertToSeconds()`](https://devpsylab.github.io/petersenlab/reference/convertToSeconds.md),
[`percentileToTScore()`](https://devpsylab.github.io/petersenlab/reference/percentileToTScore.md),
[`pom()`](https://devpsylab.github.io/petersenlab/reference/pom.md)

## Examples

``` r
# Prepare Data
data("USArrests")

# Convert variables to character
convert.magic(USArrests, "character")
#>    Murder Assault UrbanPop Rape
#> 1    13.2     236       58 21.2
#> 2      10     263       48 44.5
#> 3     8.1     294       80   31
#> 4     8.8     190       50 19.5
#> 5       9     276       91 40.6
#> 6     7.9     204       78 38.7
#> 7     3.3     110       77 11.1
#> 8     5.9     238       72 15.8
#> 9    15.4     335       80 31.9
#> 10   17.4     211       60 25.8
#> 11    5.3      46       83 20.2
#> 12    2.6     120       54 14.2
#> 13   10.4     249       83   24
#> 14    7.2     113       65   21
#> 15    2.2      56       57 11.3
#> 16      6     115       66   18
#> 17    9.7     109       52 16.3
#> 18   15.4     249       66 22.2
#> 19    2.1      83       51  7.8
#> 20   11.3     300       67 27.8
#> 21    4.4     149       85 16.3
#> 22   12.1     255       74 35.1
#> 23    2.7      72       66 14.9
#> 24   16.1     259       44 17.1
#> 25      9     178       70 28.2
#> 26      6     109       53 16.4
#> 27    4.3     102       62 16.5
#> 28   12.2     252       81   46
#> 29    2.1      57       56  9.5
#> 30    7.4     159       89 18.8
#> 31   11.4     285       70 32.1
#> 32   11.1     254       86 26.1
#> 33     13     337       45 16.1
#> 34    0.8      45       44  7.3
#> 35    7.3     120       75 21.4
#> 36    6.6     151       68   20
#> 37    4.9     159       67 29.3
#> 38    6.3     106       72 14.9
#> 39    3.4     174       87  8.3
#> 40   14.4     279       48 22.5
#> 41    3.8      86       45 12.8
#> 42   13.2     188       59 26.9
#> 43   12.7     201       80 25.5
#> 44    3.2     120       80 22.9
#> 45    2.2      48       32 11.2
#> 46    8.5     156       63 20.7
#> 47      4     145       73 26.2
#> 48    5.7      81       39  9.3
#> 49    2.6      53       66 10.8
#> 50    6.8     161       60 15.6
```
