#' @title
#' Reliability (IRT).
#'
#' @description
#' Estimate the reliability in item response theory.
#'
#' @details
#' Estimate the reliability in item response theory using the
#' test information (i.e., the sum of all items' information).
#'
#' @param information Test information.
#' @param varTheta Variance of theta.
#'
#' @return
#' Reliability for that amount of test information.
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
#' # Estimate reliability
#' reliabilityIRT(items$testInformation)
#'
#' @seealso
#' \url{https://groups.google.com/g/mirt-package/c/ZAgpt6nq5V8/m/R3OEeEqdAQAJ}

reliabilityIRT <- function(information, varTheta = 1){
  information / (information + varTheta)
}
