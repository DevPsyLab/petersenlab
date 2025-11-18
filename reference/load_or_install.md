# Load or Install Packages.

Loads packages or, if not already installed, installs and loads
packages.

## Usage

``` r
load_or_install(package_names, ...)
```

## Arguments

- package_names:

  Character vector of one or more package names.

- ...:

  Additional arguments for
  [`install.packages()`](https://rdrr.io/r/utils/install.packages.html).

## Value

Loaded packages.

## Details

Loads packages that are already installed, and if the packages are not
already installed, it installs and then loads them.

## See also

<https://www.r-bloggers.com/2012/05/loading-andor-installing-packages-programmatically/>
<https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them>

Other packages:
[`getDependencies()`](https://devpsylab.github.io/petersenlab/reference/getDependencies.md)

## Examples

``` r
if (FALSE) { # \dontrun{
old <- options("repos")
options(repos = "https://cran.r-project.org")
# Warning: the command below installs packages that are not already installed
load_or_install(c("tidyverse","nlme"))
options(old)
} # }
```
