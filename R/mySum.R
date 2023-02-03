#' @title
#' My Sum.
#'
#' @description
#' Compute a row sum and retain \code{NA}s when all values in the row are
#' \code{NA}.
#'
#' @details
#' Compute a row sum and set the row sum to be missing (not zero) when all
#' values in the row are missing (\code{NA}).
#'
#' @param data dataframe
#'
#' @return Modified row sum to set row sum to be missing when all values in the
#' row are missing (\code{NA}).
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
#' df[sample(1:nrow(df), size = 100), c("item1","item2","item3")] <- NA
#'
#' # Calculate Missingness-Adjusted Row Sum
#' df$sum <- mySum(df)

mySum <- function(data){
  dataSum <- rowSums(data, na.rm = TRUE)
  dataSum[which(rowMeans(is.na(data)) == 1)] <- NA
  return(dataSum)
}
