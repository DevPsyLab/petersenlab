#' @title
#' Is Installed.
#'
#' @description
#' Checks whether a package is installed.
#'
#' @details
#' [INSERT].
#'
#' @param mypkg character vector of one or more packages
#'
#' @return
#' \code{TRUE} or \code{FALSE}, indicating whether package is installed.
#'
#' @family packages
#'
#' @export
#'
#' @importFrom utils installed.packages
#'
#' @examples
#' is_installed("nlme")

is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])
