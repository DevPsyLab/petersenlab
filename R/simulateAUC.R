#' @title
#' Simulate Area Under the ROC Curve (AUC).
#'
#' @description
#' Simulate data with a specified area under the receiver operating
#' characteristic curve—i.e., the AUC of an ROC curve.
#'
#' @details
#' Simulates data with a specified area under the receiver operating
#' characteristic curve—i.e., the AUC of an ROC curve.
#'
#' @param auc The area under the receiver operating characteristic (ROC) curve.
#' @param n The number of observations to simulate.
#'
#' @return
#' Dataframe with two columns:
#' \itemize{
#'   \item \code{x} is the predictor variable.
#'   \item \code{y} is the dichotomous criterion variable.
#' }
#'
#' @family simulation
#'
#' @importFrom stats rnorm
#'
#' @export
#'
#' @examples
#' simulateAUC(.60, 50000)
#' simulateAUC(.70, 50000)
#' simulateAUC(.80, 50000)
#' simulateAUC(.90, 50000)
#' simulateAUC(.95, 50000)
#' simulateAUC(.99, 50000)
#'
#' @seealso
#' \url{https://stats.stackexchange.com/questions/422926/generate-synthetic-data-given-auc/424213}

simulateAUC <- function(auc, n){
  t <- sqrt(log(1/(1-auc)**2))
  z <- t-((2.515517 + 0.802853*t + 0.0103328*t**2) /
            (1 + 1.432788*t + 0.189269*t**2 + 0.001308*t**3))
  d <- z*sqrt(2)

  x <- c(rnorm(n/2, mean = 0), rnorm(n/2, mean = d))
  y <- c(rep(0, n/2), rep(1, n/2))

  data <- data.frame(x = x, y = y)

  return(data)
}
