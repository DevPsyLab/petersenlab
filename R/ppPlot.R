#' @title
#' PP Plot.
#'
#' @description
#' Normal Probability (P-P) Plot.
#'
#' @details
#' A normal probability (P-P) plot compares the empirical cumulative
#' distribution to the theoretical cumulative distribution.
#'
#' @param model The model object of a linear regression model fit using the
#' \code{lm()} function.
#'
#' @return
#' Normal probability (P-P) plot.
#'
#' @family plot
#' @family multipleRegression
#'
#' @importFrom graphics abline
#' @importFrom stats predict resid sd pnorm rnorm lm na.omit ppoints
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' predictor1 <- rnorm(100)
#' predictor2 <- rnorm(100)
#' outcome <- rnorm(100)
#'
#' # Fit Model
#' lmModel <- lm(outcome ~ predictor1 + predictor2)
#'
#' # P-P Plot
#' ppPlot(lmModel)
#'
#' @seealso
#' \url{https://www.r-bloggers.com/2009/12/r-tutorial-series-graphic-analysis-of-regression-assumptions/}

ppPlot <- function(model){
  unstandardizedPredicted <- predict(model)
  unstandardizedResiduals <- resid(model)

  #Get standardized values
  standardizedPredicted <- (unstandardizedPredicted - mean(unstandardizedPredicted, na.rm = TRUE)) / sd(unstandardizedPredicted, na.rm = TRUE)
  standardizedResiduals <- (unstandardizedResiduals - mean(unstandardizedResiduals, na.rm = TRUE)) / sd(unstandardizedResiduals, na.rm = TRUE)

  #Get probability distribution for residuals
  probDist <- pnorm(standardizedResiduals)

  #Create PP plot
  plot(ppoints(length(na.omit(standardizedResiduals))), sort(probDist), main = "PP Plot", xlab = "Observed Probability", ylab = "Expected Probability")

  #Add diagonal line
  abline(0,1)
}
