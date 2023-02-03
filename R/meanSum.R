#' @title
#' Mean Sum.
#'
#' @description
#' Compute a missingness-adjusted row sum.
#'
#' @details
#' Take row mean across columns (items) and then multiply by number of items to
#' account for missing (\code{NA}) values.
#'
#' @param x Matrix or dataframe with participants in the rows and items in the
#' columns.
#'
#' @return Missingness-adjusted row sum.
#'
#' @family computations
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' df <- data.frame(item1 = rnorm(1000), item2 = rnorm(1000), item3 = rnorm(1000))
#'
#' # Calculate Missingness-Adjusted Row Sum
#' df$missingnessAdjustedSum <- meanSum(df)

meanSum <- function(x){
  rowMeans(x, na.rm = TRUE) * ncol(x)
}
