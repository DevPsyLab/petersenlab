#' @title
#' Load or Install Packages.
#'
#' @description
#' Loads packages or, if not already installed, installs and loads packages.
#'
#' @details
#' Loads packages that are already installed, and if the packages are not
#' already installed, it installs and then loads them.
#'
#' @param package_names Character vector of one or more package names.
#' @param ... Additional arguments for \code{install.packages()}.
#'
#' @return
#' Loaded packages.
#'
#' @family packages
#'
#' @importFrom utils install.packages
#'
#' @export
#'
#' @examples
#' \dontrun{
#' old <- options("repos")
#' options(repos = "https://cran.r-project.org")
#' # Warning: the command below installs packages that are not already installed
#' load_or_install(c("tidyverse","nlme"))
#' options(old)
#' }
#'
#' @seealso
#' \url{https://www.r-bloggers.com/2012/05/loading-andor-installing-packages-programmatically/}
#' \url{https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them}

load_or_install <- function(package_names, ...) {
  for(package_name in package_names) {
    if (!require(package_name, character.only = TRUE, quietly = TRUE)) {
      install.packages(package_name, ...)
      library(package_name, character.only = TRUE, quietly = TRUE, verbose = FALSE)
    }
  }
}
