# Package Dependencies.

Determine package dependencies.

## Usage

``` r
getDependencies(packs)
```

## Arguments

- packs:

  Character vector of names of target packages.

## Value

Vector of packages that depend on the target package(s).

## Details

Determine which packages depend on a target package (or packages).

## See also

<https://stackoverflow.com/questions/52929114/install-packages-in-r-without-internet-connection-with-all-dependencies/52935020#52935020>

Other packages:
[`load_or_install()`](https://devpsylab.github.io/petersenlab/reference/load_or_install.md)

## Examples

``` r
old <- options("repos")
options(repos = "https://cran.r-project.org")
getDependencies("tidyverse")
#>   [1] "tidyverse"     "broom"         "conflicted"    "cli"          
#>   [5] "dbplyr"        "dplyr"         "dtplyr"        "forcats"      
#>   [9] "ggplot2"       "googledrive"   "googlesheets4" "haven"        
#>  [13] "hms"           "httr"          "jsonlite"      "lubridate"    
#>  [17] "magrittr"      "modelr"        "pillar"        "purrr"        
#>  [21] "ragg"          "readr"         "readxl"        "reprex"       
#>  [25] "rlang"         "rstudioapi"    "rvest"         "stringr"      
#>  [29] "tibble"        "tidyr"         "xml2"          "backports"    
#>  [33] "generics"      "glue"          "lifecycle"     "utils"        
#>  [37] "memoise"       "blob"          "DBI"           "methods"      
#>  [41] "R6"            "tidyselect"    "vctrs"         "withr"        
#>  [45] "data.table"    "grDevices"     "grid"          "gtable"       
#>  [49] "isoband"       "S7"            "scales"        "stats"        
#>  [53] "gargle"        "uuid"          "cellranger"    "curl"         
#>  [57] "ids"           "rematch2"      "pkgconfig"     "mime"         
#>  [61] "openssl"       "timechange"    "utf8"          "systemfonts"  
#>  [65] "textshaping"   "clipr"         "crayon"        "vroom"        
#>  [69] "callr"         "fs"            "knitr"         "rmarkdown"    
#>  [73] "selectr"       "stringi"       "processx"      "rematch"      
#>  [77] "rappdirs"      "evaluate"      "highr"         "tools"        
#>  [81] "xfun"          "yaml"          "cachem"        "askpass"      
#>  [85] "bslib"         "fontawesome"   "htmltools"     "jquerylib"    
#>  [89] "tinytex"       "farver"        "labeling"      "RColorBrewer" 
#>  [93] "viridisLite"   "base64enc"     "bit64"         "tzdb"         
#>  [97] "graphics"      "sys"           "bit"           "fastmap"      
#> [101] "sass"          "digest"        "ps"           
options(old)
```
