#' @title
#' Any Rows Not NA.
#'
#' @description
#' Check if any rows for a column are not \code{NA}.
#'
#' @details
#' Determine whether any rows for a column (or vector) are not missing
#' (\code{NA}).
#'
#' @param x vector or column
#'
#' @return \code{TRUE} or \code{FALSE}
#'
#' @family dataEvaluations
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#'
#' # Check if any rows are not NA
#' not_all_na(USArrests$Murder)

not_all_na <- function(x) any(!is.na(x))
