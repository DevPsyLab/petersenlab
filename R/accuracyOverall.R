#' @title
#' Overall Accuracy.
#'
#' @description
#' Find overall accuracy.
#'
#' @details
#' Compute overall accuracy estimates of predicted values in relation to actual
#' values. Estimates of overall accuracy span all cutoffs. Some accuracy
#' estimates can be undefined under various circumstances. Optionally, you can
#' drop undefined values in the calculation of accuracy indices. Note that
#' dropping undefined values changes the meaning of these indices. Use this
#' option at your own risk!
#'
#' @param predicted vector of continuous predicted values.
#' @param actual vector of actual values.
#' @param dropUndefined \code{TRUE} or \code{FALSE}, indicating whether to drop
#' any undefined values calculated with the accuracy indices.
#'
#' @return
#' \itemize{
#'   \item \code{ME} = mean error
#'   \item \code{MAE} = mean absolute error
#'   \item \code{MSE} = mean squared error
#'   \item \code{RMSE} = root mean squared error
#'   \item \code{MPE} = mean percentage error
#'   \item \code{MAPE} = mean absolute percentage error
#'   \item \code{sMAPE} = symmetric mean absolute percentage error
#'   \item \code{MASE} = mean absolute scaled error
#'   \item \code{RMSLE} = root mean squared log error
#'   \item \code{rsquared} = \emph{R}-squared
#'   \item \code{rsquaredAdj} = adjusted \emph{R}-squared
#'   \item \code{rsquaredPredictive} = predictive \emph{R}-squared
#' }
#'
#' @export
#'
#' @family accuracy
#'
#' @importFrom stats na.omit residuals lm lm.influence anova
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#'
#' # Calculate Accuracy
#' accuracyOverall(predicted = USArrests$Assault, actual = USArrests$Murder)
#'
#' @seealso
#' Mean absolute scaled error (MASE): \cr
#' \url{https://stats.stackexchange.com/questions/108734/alternative-to-mape-when-the-data-is-not-a-time-series} \cr
#' \url{https://stats.stackexchange.com/questions/322276/is-mase-specified-only-to-time-series-data} \cr
#' \url{https://stackoverflow.com/questions/31197726/calculate-mase-with-cross-sectional-non-time-series-data-in-r} \cr
#' \url{https://stats.stackexchange.com/questions/401759/how-can-mase-mean-absolute-scaled-error-score-value-be-interpreted-for-non-tim} \cr
#'
#' Predictive R-squared: \cr
#' \url{http://www.r-bloggers.com/can-we-do-better-than-r-squared/} \cr
#'

accuracyOverall <- function(predicted, actual, dropUndefined = FALSE){

  #Mean error
  meanError <- function(predicted, actual){
    value <- mean(predicted - actual, na.rm = TRUE)
    return(value)
  }

  #Mean Absolute Error
  meanAbsoluteError <- function(predicted, actual){
    value <- mean(abs(predicted - actual), na.rm = TRUE)
    return(value)
  }

  #Mean Squared Error
  meanSquaredError = function(predicted, actual){
    value <- mean((predicted - actual)^2, na.rm = TRUE)
    return(value)
  }

  #Root Mean Squared Error
  rootMeanSquaredError = function(predicted, actual){
    value <- sqrt(mean((predicted - actual)^2, na.rm = TRUE))
    return(value)
  }

  #Mean Percentage Error
  meanPercentageError = function(predicted, actual, dropUndefined = dropUndefined){
    percentageError <- 100 * (actual - predicted) / actual

    if(dropUndefined == TRUE){
      percentageError[!is.finite(percentageError)] <- NA
    }

    value <- mean(percentageError, na.rm = TRUE)
    return(value)
  }

  #Mean Absolute Percentage Error (MAPE)
  meanAbsolutePercentageError = function(predicted, actual, dropUndefined = dropUndefined){
    percentageError <- 100 * (actual - predicted) / actual

    if(dropUndefined == TRUE){
      percentageError[!is.finite(percentageError)] <- NA
    }

    value <- mean(abs(percentageError), na.rm = TRUE)
    return(value)
  }

  #Symmetric Mean Absolute Percentage Error (sMAPE)
  symmetricMeanAbsolutePercentageError = function(predicted, actual, dropUndefined = dropUndefined){
    relativeError <- abs(predicted - actual)/(abs(predicted) + abs(actual))

    if(dropUndefined == TRUE){
      relativeError[!is.finite(relativeError)] <- NA
    }

    value <- 100 * mean(abs(relativeError), na.rm = TRUE)
    return(value)
  }

  #Mean Absolute Scaled Error (MASE)
  meanAbsoluteScaledError <- function(predicted, actual){
    mydata <- data.frame(na.omit(cbind(predicted, actual)))

    errors <- mydata$actual - mydata$predicted
    scalingFactor <- mean(abs(mydata$actual - mean(mydata$actual)))
    scaledErrors <- errors/scalingFactor

    value <- mean(abs(scaledErrors))
    return(value)
  }

  #Root Mean Squared Log Error
  rootMeanSquaredLogError <- function(predicted, actual, dropUndefined = dropUndefined){
    logError <- log(predicted + 1) - log(actual + 1)

    if(dropUndefined == TRUE){
      logError[!is.finite(logError)] <- NA
    }

    value <- sqrt(mean(logError^2, na.rm = TRUE))

    return(value)
  }

  #predictive residual sum of squares (PRESS)
  PRESS <- function(linear.model){
    # calculate the predictive residuals
    pr <- residuals(linear.model)/(1-lm.influence(linear.model)$hat)
    # calculate the PRESS
    PRESS <- sum(pr^2)

    return(PRESS)
  }

  #Predictive R-squared
  predictiveRSquared <- function(predicted, actual){
    #fit linear model
    linear.model <- lm(actual ~ predicted)

    # use anova() to get the sum of squares for the linear model
    lm.anova <- stats::anova(linear.model)

    # calculate the total sum of squares
    tss <- sum(lm.anova$'Sum Sq')

    # calculate the predictive R^2
    value <- 1 - PRESS(linear.model)/(tss)

    return(value)
  }

  #Mean Error
  ME <- meanError(predicted = predicted, actual = actual)

  #Mean Absolute Error
  MAE <- meanAbsoluteError(predicted = predicted, actual = actual)

  #Mean Squared Error
  MSE <- meanSquaredError(predicted = predicted, actual = actual)

  #Root Mean Squared Error
  RMSE <- rootMeanSquaredError(predicted = predicted, actual = actual)

  #Mean Percentage Error
  MPE <- meanPercentageError(predicted = predicted, actual = actual, dropUndefined = dropUndefined)

  #Mean Absolute Percentage Error
  MAPE <- meanAbsolutePercentageError(predicted = predicted, actual = actual, dropUndefined = dropUndefined)

  #Symmetric Mean Absolute Percentage Error
  sMAPE <- symmetricMeanAbsolutePercentageError(predicted = predicted, actual = actual, dropUndefined = dropUndefined)

  #Mean Absolute Scaled Error
  MASE <- meanAbsoluteScaledError(predicted = predicted, actual = actual)

  #Root Mean Squared Log Error
  RMSLE <- rootMeanSquaredLogError(predicted = predicted, actual = actual, dropUndefined = dropUndefined)

  #Coefficient of Determination (R-squared)
  rsquared <- summary(lm(actual ~ predicted))$r.squared

  #Adjusted R-squared
  rsquaredAdj <- summary(lm(actual ~ predicted))$adj.r.squared

  #Predictive R-squared
  rsquaredPredictive <- predictiveRSquared(predicted = predicted, actual = actual)

  accuracyTable <- data.frame(cbind(ME, MAE, MSE, RMSE, MPE, MAPE, sMAPE, MASE, RMSLE, rsquared, rsquaredAdj, rsquaredPredictive))

  return(accuracyTable)
}
