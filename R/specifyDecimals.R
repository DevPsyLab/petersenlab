#' @title
#' Specify Decimals.
#'
#' @description
#' Specify the number of decimals to print.
#'
#' @details
#' [INSERT].
#'
#' @param x Numeric vector.
#' @param k Number of decimals to print.
#'
#' @return Character vector of numbers with the specified number of decimal
#' places.
#'
#' @family formatting
#'
#' @importFrom stringr str_trim
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' v1 <- rnorm(1000)
#'
#' # Specify Decimals
#' specify_decimal(v1, 2)

specify_decimal <- function(x, k) str_trim(format(round(x, k), nsmall = k))
