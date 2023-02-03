#' @title
#' Reliability of Difference Score.
#'
#' @description
#' Estimate the reliability of a difference score.
#'
#' @details
#' Estimates the reliability of a difference score.
#'
#' @param x Vector of one variable that is used in the computation of difference
#' score.
#' @param y Vector of second variable that is used in the computation of the
#' difference score.
#' @param reliabilityX The reliability of the \code{x} variable.
#' @param reliabilityY The reliability of the \code{y} variable.
#'
#' @return
#' Reliability of the difference score that is computed from the difference of
#' \code{x} and \code{y}.
#'
#' @family reliability
#'
#' @importFrom stats rnorm sd
#'
#' @export
#'
#' @examples
#' v1 <- rnorm(1000, mean = 100, sd = 15)
#' v2 <- v1 + rnorm(1000, mean = 1, sd = 15)
#' reliabilityOfDifferenceScore(x = v1, y = v2,
#'  reliabilityX = .7, reliabilityY = .8)

reliabilityOfDifferenceScore <- function(x, y, reliabilityX, reliabilityY){
  rxy <- as.numeric(cor.test(x = x, y = y)$estimate)
  sigmaX <- sd(x, na.rm = TRUE)
  sigmaY <- sd(y, na.rm = TRUE)

  reliability <- (sigmaX^2 * reliabilityX + sigmaY^2 * reliabilityY - (2 * rxy * sigmaX * sigmaY)) / (sigmaX^2 + sigmaY^2 - (2 * rxy * sigmaX * sigmaY))

  return(reliability)
}
