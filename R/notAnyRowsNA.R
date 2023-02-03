#' @title
#' Not Any NA.
#'
#' @description
#' Check if all rows for a column are \code{NA}.
#'
#' @details
#' [INSERT].
#'
#' @param x column vector
#'
#' @return \code{TRUE} or \code{FALSE}, indicating whether the whole column does
#' not have any missing values (\code{NA}).
#'
#' @family dataEvaluations
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))
#' df[sample(1:nrow(df), size = 100), "item2"] <- NA
#' df[,"item3"] <- NA
#'
#' # Check if Not Any NA
#' not_any_na(df$item1)
#' not_any_na(df$item2)
#' not_any_na(df$item3)

not_any_na <- function(x) all(!is.na(x))
