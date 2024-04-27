#' @title
#' Package Dependencies.
#'
#' @description
#' Determine package dependencies.
#'
#' @details
#' Determine which packages depend on a target package (or packages).
#'
#' @param packs Character vector of names of target packages.
#'
#' @return Vector of packages that depend on the target package(s).
#'
#' @family packages
#'
#' @importFrom tools package_dependencies
#' @importFrom utils available.packages
#'
#' @export
#'
#' @examples
#' old <- options("repos")
#' options(repos = "https://cran.r-project.org")
#' getDependencies("tidyverse")
#' options(old)
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/52929114/install-packages-in-r-without-internet-connection-with-all-dependencies/52935020#52935020}

getDependencies <- function(packs){
  dependencyNames <- unlist(
    tools::package_dependencies(packages = packs, db = available.packages(),
                                which = c("Depends", "Imports"),
                                recursive = TRUE))
  packageNames <- union(packs, dependencyNames)
  packageNames
}
