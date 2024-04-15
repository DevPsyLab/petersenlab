#' @title
#' Standard Error of Measurement (IRT).
#'
#' @description
#' Estimate the standard error of measurement in item response theory.
#'
#' @details
#' Estimate the standard error of measurement in item response theory using the
#' test information (i.e., the sum of all items' information).
#'
#' @param information Test information.
#'
#' @return
#' Standard error of measurement for that amount of test information.
#'
#' @family IRT
#'
#' @export
#'
#' @examples
#' # Calculate information for 4 items
#' item1 <- itemInformation(b = -2, a = 0.6, theta = -4:4)
#' item2 <- itemInformation(b = -1, a = 1.2, theta = -4:4)
#' item3 <- itemInformation(b = 1, a = 1.5, theta = -4:4)
#' item4 <- itemInformation(b = 2, a = 2, theta = -4:4)
#'
#' items <- data.frame(item1, item2, item3, item4)
#'
#' # Calculate test information
#' items$testInformation <- rowSums(items)
#'
#' # Calculate standard error of measurement
#' standardErrorIRT(items$testInformation)
#'
#' @seealso
#' \url{10.1177/0146621613475471}

standardErrorIRT <- function(information){
  1/sqrt(information)
}
