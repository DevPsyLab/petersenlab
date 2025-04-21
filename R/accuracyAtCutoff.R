#' @title
#' Accuracy at a Given Cutoff.
#'
#' @description
#' Find the accuracy at a given cutoff. Actuals should be binary, where \code{1}
#' = present and \code{0} = absent.
#'
#' @details
#' Compute accuracy indices of predicted values in relation to actual values
#' at a given cutoff by specifying the predicted values, actual values, and
#' cutoff value. The target condition is considered present at or above the
#' cutoff value. Optionally, you can also specify the utility of hits, misses,
#' correct rejections, and false alarms to calculate the overall utility of the
#' cutoff. To compute accuracy at each possible cutoff, see
#' \link{accuracyAtEachCutoff}.
#'
#' @param predicted vector of continuous predicted values.
#' @param actual vector of binary actual values (\code{1} = present and \code{0}
#' = absent).
#' @param cutoff numeric value at or above which the target condition is
#' considered present.
#' @param UH (optional) utility of hits (true positives), specified as a value
#' from 0-1, where 1 is the most highly valued and 0 is the least valued.
#' @param UM (optional) utility of misses (false negatives), specified as a
#' value from 0-1, where 1 is the most highly valued and 0 is the least valued.
#' @param UCR (optional) utility of correct rejections (true negatives),
#' specified as a value from 0-1, where 1 is the most highly valued and 0 is the
#' least valued.
#' @param UFA (optional) utility of false positives (false positives), specified
#' as a value from 0-1, where 1 is the most highly valued and 0 is the least
#' valued.
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
#' @importFrom dplyr mutate group_by summarise
#' @importFrom ggplot2 cut_number
#' @importFrom stringr str_replace_all str_split
#' @importFrom stats qnorm na.omit
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
#' accuracyAtCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState, cutoff = 200)
#' accuracyAtCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState, cutoff = 200,
#'   UH = 1, UM = 0, UCR = .9, UFA = 0)

accuracyAtCutoff <- function(predicted, actual, cutoff, UH = NULL, UM = NULL, UCR = NULL, UFA = NULL){
  decision <- NA
  decision[predicted < cutoff] <- 0
  decision[predicted >= cutoff] <- 1

  TP <- as.double(length(which(decision == 1 & actual == 1)))
  TN <- as.double(length(which(decision == 0 & actual == 0)))
  FP <- as.double(length(which(decision == 1 & actual == 0)))
  FN <- as.double(length(which(decision == 0 & actual == 1)))

  N <- TP + TN + FP + FN

  SR <- (TP + FP)/N
  BR <- (TP + FN)/N

  ifelse(BR >= .5, SRbaseRate <- 1, NA)
  ifelse(BR < .5, SRbaseRate <- 0, NA)

  percentAccuracy <- 100 * ((TP + TN)/N)
  percentAccuracyByChance <- 100 * ((BR * SR) + ((1 - BR) * (1 - SR)))
  percentAccuracyPredictingFromBaseRate <- 100 * ((BR * SRbaseRate) + ((1 - BR) * (1 - SRbaseRate)))

  actualYes <- TP + FN
  predictedYes <- TP + FP
  predictedYesBaseRate <- SRbaseRate * N
  RIOC <- ((N * (TP + TN)) - (actualYes * predictedYes + (N - predictedYes) * (N - actualYes))) / ((N * (actualYes + N - predictedYes)) - (actualYes * predictedYes + (N - predictedYes) * (N - actualYes)))
  relativeImprovementOverPredictingFromBaseRate <- ((N * (TP + TN)) - (actualYes * predictedYesBaseRate + (N - predictedYesBaseRate) * (N - actualYes))) / ((N * (actualYes + N - predictedYesBaseRate)) - (actualYes * predictedYesBaseRate + (N - predictedYesBaseRate) * (N - actualYes)))

  SN <- TPrate <- HR <- TP/(TP + FN)
  SP <- TNrate <- TN/(TN + FP)
  FNrate <- FN/(FN + TP)
  FPrate <- FAR <- FP/(FP + TN)

  PPV <- TP/(TP + FP)
  NPV <- TN/(TN + FN)

  FDR <- FP/(FP + TP)
  FOR <- FN/(FN + TN)

  youdenJ <- SN + SP - 1
  balancedAccuracy <- (SN + SP) / 2
  f1Score <- 2 * (PPV * SN)/(PPV + SN)
  mcc <- ((TP * TN) - (FP * FN)) / sqrt((TP + FP) * (TP + FN) * (TN + FP) * (TN + FN))

  diagnosticOddsRatio <- (TP * TN) / (FP * FN)

  positiveLikelihoodRatio <- SN/(1 - SP)
  negativeLikelihoodRatio <- (1 - SN)/SP

  dPrimeSDT <- qnorm(HR) - qnorm(FAR)
  betaSDT <- exp(qnorm(FAR)^2/2 - qnorm(HR)^2/2)
  cSDT <- -(qnorm(HR) + qnorm(FAR))/2

  ifelse(FAR <= .5 & HR >= .5, aSDT <- (3/4) + ((HR - FAR)/4) - (FAR * (1 - HR)), NA)
  ifelse(FAR <= HR & HR <= .5, aSDT <- (3/4) + ((HR - FAR)/4) - (FAR/(4 * HR)), NA)
  ifelse(FAR >= .5 & FAR <= HR, aSDT <- (3/4) + ((HR - FAR)/4) - ((1 - HR)/(4 * (1 - FAR))), NA)
  ifelse(FAR > HR, aSDT <- NA, NA)

  ifelse(FAR <= .5 & HR >= .5, bSDT <-(5 - (4 * HR))/(1 + (4 * FAR)), NA)
  ifelse(FAR <= HR & HR <= .5, bSDT <- (HR^2 + HR)/(HR^2 + FAR), NA)
  ifelse(FAR >= .5 & FAR <= HR, bSDT <- ((1 - FAR)^2 + (1 - HR))/((1 - FAR)^2 + (1 - FAR)), NA)
  ifelse(FAR > HR, bSDT <- NA, NA)

  data <- data.frame(na.omit(cbind(predicted, actual, decision)))

  miscalibration <- function(predicted, actual, cutoff, bins = 10){
    data <- data.frame(na.omit(cbind(predicted, actual)))

    bin <- NULL

    # Determine adaptively how many bins to use (if errors out with 10 bins)
    adaptive_num_bins <- function(x, min_bins = 1) {
      current_bins <- bins

      repeat {
        try_result <- tryCatch(
          cut_number(x, n = current_bins),
          error = function(e) NULL
        )

        if (!is.null(try_result)) {
          return(current_bins)
        }

        current_bins <- current_bins - 1
        if (current_bins < min_bins) {
          stop("Could not find a valid binning using cut_number() with the given range of bins.")
        }
      }
    }

    # Get the number of bins used
    binsToUse <- adaptive_num_bins(predicted)

    calibrationTable <- mutate(data, bin = cut_number(predicted, n = binsToUse)) |>
      group_by(bin) |>
      summarise(
        n = length(predicted),
        meanPredicted = mean(predicted, na.rm = TRUE),
        meanObserved = mean(actual, na.rm = TRUE),
        .groups = "drop")

    calibrationTable$cutoffMin <- as.numeric(str_replace_all(str_split(calibrationTable$bin, pattern = ",", simplify = T)[,1], "[^0-9.]",""))
    calibrationTable$cutoffMax <- as.numeric(str_replace_all(str_split(calibrationTable$bin, pattern = ",", simplify = T)[,2], "[^0-9.]",""))

    calibrationTable$inRange <- with(calibrationTable, cutoff >= cutoffMin & cutoff <= cutoffMax)

    if(length(which(calibrationTable$inRange == TRUE)) > 0){
      nearestCutoff <- calibrationTable$bin[min(which(calibrationTable$inRange == TRUE))]
      calibrationAtNearestCutoff <- calibrationTable[which(calibrationTable$bin == nearestCutoff),]
      calibrationAtNearestCutoff <- as.data.frame(calibrationTable[max(which(calibrationTable$inRange == TRUE)),])

      meanPredicted <- calibrationAtNearestCutoff[, "meanPredicted"]
      meanObserved <- calibrationAtNearestCutoff[, "meanObserved"]
      differenceBetweenPredictedAndObserved <- meanPredicted - meanObserved
    } else{
      differenceBetweenPredictedAndObserved <- NA
    }

    return(differenceBetweenPredictedAndObserved)
  }

  differenceBetweenPredictedAndObserved <- miscalibration(
    predicted = predicted,
    actual = actual,
    cutoff = cutoff)

  G <- BR*(HR) + (1 - BR)*(FAR)
  informationGain <- (BR*HR*log2(HR/G)) +
    (BR*(1 - HR)*(log2((1 - HR)/(1 - G)))) +
    ((1 - BR)*FAR*(log2(FAR/G))) +
    ((1 - BR)*(1 - FAR)*(log2((1 - FAR)/(1 - G))))

  accuracyTable <- data.frame(cbind(
    cutoff, TP, TN, FP, FN, SR, BR, percentAccuracy, percentAccuracyByChance, percentAccuracyPredictingFromBaseRate, RIOC, relativeImprovementOverPredictingFromBaseRate, SN, SP, TPrate, TNrate, FNrate, FPrate, HR, FAR, PPV, NPV, FDR, FOR,
    youdenJ, balancedAccuracy, f1Score, mcc, diagnosticOddsRatio, positiveLikelihoodRatio, negativeLikelihoodRatio, dPrimeSDT, betaSDT, cSDT, aSDT, bSDT, differenceBetweenPredictedAndObserved, informationGain))

  if(!is.null(UH) & !is.null(UM) & !is.null(UCR) & !is.null(UFA)){
    accuracyTable$overallUtility <- (BR*HR*UH) + (BR*(1 - HR)*UM) + ((1 - BR)*FAR*UFA) + ((1 - BR)*(1 - FAR)*(UCR))
  }

  return(accuracyTable)
}
