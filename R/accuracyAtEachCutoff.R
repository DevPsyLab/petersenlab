#' @title
#' Accuracy at Each Cutoff.
#'
#' @description
#' Find the accuracy at each possible cutoff. Actuals should be binary,
#' where \code{1} = present and \code{0} = absent.
#'
#' @details
#' Compute accuracy indices of predicted values in relation to actual values at
#' each possible cutoff by specifying the predicted values and actual values.
#' The target condition is considered present at or above each cutoff value.
#' Optionally, you can specify the utility of hits, misses, correct rejections,
#' and false alarms to calculate the overall utility of each possible cutoff.
#'
#' @inheritParams accuracyAtCutoff
#'
#' @return
#' \itemize{
#'   \item \code{cutoff} = the cutoff specified
#'   \item \code{TP} = true positives
#'   \item \code{TN} = true negatives
#'   \item \code{FP} = false positives
#'   \item \code{FN} = false negatives
#'   \item \code{SR} = selection ratio
#'   \item \code{BR} = base rate
#'   \item \code{percentAccuracy} = percent accuracy
#'   \item \code{percentAccuracyByChance} = percent accuracy by chance
#'   \item \code{percentAccuracyPredictingFromBaseRate} = percent accuracy from
#'   predicting from the base rate
#'   \item \code{RIOC} = relative improvement over chance
#'   \item \code{relativeImprovementOverPredictingFromBaseRate} = relative
#'   improvement over predicting from the base rate
#'   \item \code{SN} = sensitivty
#'   \item \code{SP} = specificity
#'   \item \code{TPrate} = true positive rate
#'   \item \code{TNrate} = true negative rate
#'   \item \code{FNrate} = false negative rate
#'   \item \code{FPrate} = false positive rate
#'   \item \code{HR} = hit rate
#'   \item \code{FAR} = false alarm rate
#'   \item \code{PPV} = positive predictive value
#'   \item \code{NPV} = negative predictive value
#'   \item \code{FDR} = false discovery rate
#'   \item \code{FOR} = false omission rate
#'   \item \code{youdenJ} = Youden's J statistic
#'   \item \code{balancedAccuracy} = balanced accuracy
#'   \item \code{f1Score} = F1-score
#'   \item \code{mcc} = Matthews correlation coefficient
#'   \item \code{diagnosticOddsRatio} = diagnostic odds ratio
#'   \item \code{positiveLikelihoodRatio} = positive likelihood ratio
#'   \item \code{negativeLikelhoodRatio} = negative likelihood ratio
#'   \item \code{dPrimeSDT} = d-Prime index from signal detection theory
#'   \item \code{betaSDT} = beta index from signal detection theory
#'   \item \code{cSDT} = c index from signal detection theory
#'   \item \code{aSDT} = a index from signal detection theory
#'   \item \code{bSDT} = b index from signal detection theory
#'   \item \code{differenceBetweenPredictedAndObserved} = difference between
#'   predicted and observed values
#'   \item \code{informationGain} = information gain
#'   \item \code{overallUtility} = overall utility (if utilities were specified)
#' }
#'
#' @family accuracy
#'
#' @importFrom stats na.omit
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#' USArrests$highMurderState <- NA
#' USArrests$highMurderState[which(USArrests$Murder >= 10)] <- 1
#' USArrests$highMurderState[which(USArrests$Murder < 10)] <- 0
#'
#' # Calculate Accuracy
#' accuracyAtEachCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState)
#' accuracyAtEachCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState,
#'   UH = 1, UM = 0, UCR = .9, UFA = 0)

accuracyAtEachCutoff <- function(predicted, actual, UH = NULL, UM = NULL, UCR = NULL, UFA = NULL){
  possibleCutoffs <- unique(na.omit(predicted))
  possibleCutoffs <- possibleCutoffs[order(possibleCutoffs)]
  possibleCutoffs <- c(possibleCutoffs, max(possibleCutoffs, na.rm = TRUE) + 0.01)

  accuracyList <- lapply(possibleCutoffs, FUN = function(x) accuracyAtCutoff(predicted = predicted, actual = actual, cutoff = x, UH = UH, UM = UM, UCR = UCR, UFA = UFA))
  accuracyTable <- data.frame(do.call("rbind", accuracyList))
  accuracyTable[sapply(accuracyTable, is.infinite)] <- NA
  accuracyTable[sapply(accuracyTable, is.nan)] <- NA

  return(accuracyTable)
}
