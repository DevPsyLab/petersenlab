#' @title
#' NaN (Not a Number).
#'
#' @description
#' Check whether a value is "Not A Number" (\code{NaN}) in a dataframe.
#'
#' @details
#' [INSERT].
#'
#' @param x Dataframe.
#'
#' @return \code{TRUE} or \code{FALSE}, indicating whether values in a dataframe
#' are Not a Number (\code{NA}).
#'
#' @family dataEvaluations
#'
#' @importFrom stats rnorm
#'
#' @examples
#' # Prepare Data
#' df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))
#' df[sample(1:nrow(df), size = 100), c("item1","item2","item3")] <- NaN
#'
#' # Calculate Missingness-Adjusted Row Sum
#' is.nan(df)
#'
#' @seealso
#' \url{https://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame/18143097#18143097}
#'
#' @method is.nan data.frame
#'
#' @export

is.nan.data.frame <- function(x) do.call(cbind, lapply(x, is.nan))

