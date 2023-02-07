# petersenlab

## Installing the package

R package with functions for the Petersen Lab

To install the package, run the following in `R`:
```
install.packages("remotes")
remotes::install_github("DevPsyLab/petersenlab")
```

## Citing the package

To obtain the citation for the `petersenlab` package, run `citation("petersenlab")`; the citation is:

Petersen, I. T. (2023). *petersenlab: Package of R functions for the Petersen Lab*. R package version 0.1.2-9013. https://github.com/DevPsyLab/petersenlab, https://doi.org/10.5281/zenodo.7602890

A `BibTeX` entry for `LaTeX` users is:
```
@software{petersenlab,
  author = {Isaac T. Petersen},
  title = {{petersenlab}: Package of {R} functions for the {Petersen Lab}},
  url = {https://github.com/DevPsyLab/petersenlab},
  doi = {10.5281/zenodo.7602890},
  version = {0.1.2-9013},
  date = {2022-03-23}
}
```

# License

[![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

# Dev Notes

## Updating the package

To update the package, run the following in `R`:
```
# 1. Update packages in package environment
renv::upgrade()
renv::update()
renv::snapshot()

# 2. Add/edit code

# 3. Update documentation
roxygen2::roxygenise()

# 4. Update package version
usethis::use_version()
```

Then, build the package: Ctrl-Shift-B

Then, install the package:

```
renv::install("C:/R/Packages/petersenlab") #PC
renv::install("/Library/Frameworks/R.framework/Packages/petersenlab") #Mac
```

## Installing Packages

To install new packages in the package environment, run the following in `R`:
```
renv::install("NAME_OF_PACKAGE")
```
or:
```
install.packages("NAME_OF_PACKAGE)
```

## Some useful keyboard shortcuts for package authoring:

 Install Package:           'Ctrl + Shift + B'
 
 Check Package:             'Ctrl + Shift + E'
 
 Test Package:              'Ctrl + Shift + T'

```
renv::install("C:/R/Packages/petersenlab")
renv::snapshot()
renv::install()
```

## Resources

-https://rpubs.com/YaRrr/rpackageintro

-http://r-pkgs.had.co.nz/

-http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf

-http://portal.stats.ox.ac.uk/userdata/ruth/APTS2012/Rcourse10.pdf

-http://web.mit.edu/insong/www/pdf/rpackage_instructions.pdf

-https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

### For Package Development Tasks

-https://usethis.r-lib.org/index.html

### For Reproducibility of Package Management using renv

-https://rstudio.github.io/renv/articles/renv.html

### For Documentation

-https://github.com/r-lib/roxygen2#roxygen2
-https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
