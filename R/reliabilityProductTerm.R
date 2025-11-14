#' @title
#' Reliability of Product Term.
#'
#' @description
#' Estimate the reliability of a product term (assuming the individual indices
#' are centered for the computation of the product term).
#'
#' @details
#' Estimates the reliability of a product term (assuming the individual indices
#' are centered for the computation of the product term).
#'
#' @param x Vector of one variable that is used in the computation of the
#' product term.
#' @param y Vector of second variable that is used in the computation of the
#' product term.
#' @param reliabilityX The reliability of the \code{x} variable.
#' @param reliabilityY The reliability of the \code{y} variable.
#'
#' @return
#' Reliability of the product term that is computed from the multiplication of
#' \code{x} and \code{y}.
#'
#' @family reliability
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' v1 <- rnorm(1000, mean = 100, sd = 15)
#' v2 <- rnorm(1000, mean = 1, sd = 15)
#' reliabilityOfProductTerm(x = v1, y = v2,
#'  reliabilityX = .7, reliabilityY = .8)

reliabilityOfProductTerm <- function(x, y, reliabilityX, reliabilityY){
  rxy <- as.numeric(cor.test(x = x, y = y)$estimate)

  reliability <- (reliabilityX * reliabilityY + (rxy^2)) / (1 + (rxy^2))

  return(reliability)
}
