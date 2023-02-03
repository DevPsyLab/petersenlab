#' @title
#' Optimal Cutoff.
#'
#' @description
#' Find the optimal cutoff for different aspects of accuracy. Actuals should be
#' binary, where \code{1} = present and \code{0} = absent.
#'
#' @details
#' Identify the optimal cutoff for different aspects of accuracy of predicted
#' values in relation to actual values by specifying the predicted values and
#' actual values. Optionally, you can specify the utility of hits, misses,
#' correct rejections, and false alarms to calculate the overall utility of
#' each possible cutoff.
#'
#' @inheritParams accuracyAtCutoff
#'
#' @return The optimal cutoff and optimal accuracy index at that cutoff based
#' on:
#' \itemize{
#'   \item \code{percentAccuracy} = percent accuracy
#'   \item \code{percentAccuracyByChance} = percent accuracy by chance
#'   \item \code{RIOC} = relative improvement over chance
#'   \item \code{relativeImprovementOverPredictingFromBaseRate} = relative
#'   improvement over predicting from the base rate
#'   \item \code{PPV} = positive predictive value
#'   \item \code{NPV} = negative predictive value
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
#' @export
#'
#' @examples
#' # Prepare Data
#' data("USArrests")
#' USArrests$highMurderState <- NA
#' USArrests$highMurderState[which(USArrests$Murder >= 10)] <- 1
#' USArrests$highMurderState[which(USArrests$Murder < 10)] <- 0
#'
#' # Determine Optimal Cutoff
#' optimalCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState)
#' optimalCutoff(predicted = USArrests$Assault,
#'   actual = USArrests$highMurderState,
#'   UH = 1, UM = 0, UCR = .9, UFA = 0)

optimalCutoff <- function(predicted, actual, UH = NULL, UM = NULL, UCR = NULL, UFA = NULL){
  accuracyTable <- accuracyAtEachCutoff(predicted, actual, UH = UH, UM = UM, UCR = UCR, UFA = UFA)

  percentAccuracyCutoff <- accuracyTable$cutoff[which(accuracyTable$percentAccuracy == max(accuracyTable$percentAccuracy, na.rm = TRUE))]
  percentAccuracyByChanceCutoff <- accuracyTable$cutoff[which(accuracyTable$percentAccuracyByChance == max(accuracyTable$percentAccuracyByChance, na.rm = TRUE))]
  RIOCCutoff <- accuracyTable$cutoff[which(accuracyTable$RIOC == max(accuracyTable$RIOC, na.rm = TRUE))]
  relativeImprovementOverPredictingFromBaseRateCutoff <- accuracyTable$cutoff[which(accuracyTable$relativeImprovementOverPredictingFromBaseRate == max(accuracyTable$relativeImprovementOverPredictingFromBaseRate, na.rm = TRUE))]
  PPVCutoff <- accuracyTable$cutoff[which(accuracyTable$PPV == max(accuracyTable$PPV, na.rm = TRUE))]
  NPVCutoff <- accuracyTable$cutoff[which(accuracyTable$NPV == max(accuracyTable$NPV, na.rm = TRUE))]
  youdenJCutoff <- accuracyTable$cutoff[which(accuracyTable$youdenJ == max(accuracyTable$youdenJ, na.rm = TRUE))]
  balancedAccuracyCutoff <- accuracyTable$cutoff[which(accuracyTable$balancedAccuracy == max(accuracyTable$balancedAccuracy, na.rm = TRUE))]
  f1ScoreCutoff <- accuracyTable$cutoff[which(accuracyTable$f1Score == max(accuracyTable$f1Score, na.rm = TRUE))]
  mccCutoff <- accuracyTable$cutoff[which(accuracyTable$mcc == max(accuracyTable$mcc, na.rm = TRUE))]
  diagnosticOddsRatioCutoff <- accuracyTable$cutoff[which(accuracyTable$diagnosticOddsRatio == max(accuracyTable$diagnosticOddsRatio, na.rm = TRUE))]
  positiveLikelihoodRatioCutoff <- accuracyTable$cutoff[which(accuracyTable$positiveLikelihoodRatio == max(accuracyTable$positiveLikelihoodRatio, na.rm = TRUE))]
  negativeLikelihoodRatioCutoff <- accuracyTable$cutoff[which(accuracyTable$negativeLikelihoodRatio == min(accuracyTable$negativeLikelihoodRatio, na.rm = TRUE))]
  dPrimeSDTCutoff <- accuracyTable$cutoff[which(accuracyTable$dPrimeSDT == max(accuracyTable$dPrimeSDT, na.rm = TRUE))]
  betaSDTCutoff <- accuracyTable$cutoff[which(abs(accuracyTable$betaSDT) == min(abs(accuracyTable$betaSDT), na.rm = TRUE))]
  cSDTCutoff <- accuracyTable$cutoff[which(abs(accuracyTable$cSDT) == min(abs(accuracyTable$cSDT), na.rm = TRUE))]
  aSDTCutoff <- accuracyTable$cutoff[which(accuracyTable$aSDT == max(accuracyTable$aSDT, na.rm = TRUE))]
  bSDTCutoff <- accuracyTable$cutoff[which(abs(accuracyTable$bSDT) == min(abs(accuracyTable$bSDT), na.rm = TRUE))]
  differenceBetweenPredictedAndObservedCutoff <- accuracyTable$cutoff[which(abs(accuracyTable$differenceBetweenPredictedAndObserved) == min(abs(accuracyTable$differenceBetweenPredictedAndObserved), na.rm = TRUE))]
  informationGainCutoff <- accuracyTable$cutoff[which(accuracyTable$informationGain == max(accuracyTable$informationGain, na.rm = TRUE))]

  percentAccuracyOptimal <- accuracyTable$percentAccuracy[which(accuracyTable$percentAccuracy == max(accuracyTable$percentAccuracy, na.rm = TRUE))]
  percentAccuracyByChanceOptimal <- accuracyTable$percentAccuracyByChance[which(accuracyTable$percentAccuracyByChance == max(accuracyTable$percentAccuracyByChance, na.rm = TRUE))]
  RIOCOptimal <- accuracyTable$RIOC[which(accuracyTable$RIOC == max(accuracyTable$RIOC, na.rm = TRUE))]
  relativeImprovementOverPredictingFromBaseRateOptimal <- accuracyTable$relativeImprovementOverPredictingFromBaseRate[which(accuracyTable$relativeImprovementOverPredictingFromBaseRate == max(accuracyTable$relativeImprovementOverPredictingFromBaseRate, na.rm = TRUE))]
  PPVOptimal <- accuracyTable$PPV[which(accuracyTable$PPV == max(accuracyTable$PPV, na.rm = TRUE))]
  NPVOptimal <- accuracyTable$NPV[which(accuracyTable$NPV == max(accuracyTable$NPV, na.rm = TRUE))]
  youdenJOptimal <- accuracyTable$youdenJ[which(accuracyTable$youdenJ == max(accuracyTable$youdenJ, na.rm = TRUE))]
  balancedAccuracyOptimal <- accuracyTable$balancedAccuracy[which(accuracyTable$balancedAccuracy == max(accuracyTable$balancedAccuracy, na.rm = TRUE))]
  f1ScoreOptimal <- accuracyTable$f1Score[which(accuracyTable$f1Score == max(accuracyTable$f1Score, na.rm = TRUE))]
  mccOptimal <- accuracyTable$mcc[which(accuracyTable$mcc == max(accuracyTable$mcc, na.rm = TRUE))]
  diagnosticOddsRatioOptimal <- accuracyTable$diagnosticOddsRatio[which(accuracyTable$diagnosticOddsRatio == max(accuracyTable$diagnosticOddsRatio, na.rm = TRUE))]
  positiveLikelihoodRatioOptimal <- accuracyTable$positiveLikelihoodRatio[which(accuracyTable$positiveLikelihoodRatio == max(accuracyTable$positiveLikelihoodRatio, na.rm = TRUE))]
  negativeLikelihoodRatioOptimal <- accuracyTable$negativeLikelihoodRatio[which(accuracyTable$negativeLikelihoodRatio == min(accuracyTable$negativeLikelihoodRatio, na.rm = TRUE))]
  dPrimeSDTOptimal <- accuracyTable$dPrimeSDT[which(accuracyTable$dPrimeSDT == max(accuracyTable$dPrimeSDT, na.rm = TRUE))]
  betaSDTOptimal <- accuracyTable$betaSDT[which(abs(accuracyTable$betaSDT) == min(abs(accuracyTable$betaSDT), na.rm = TRUE))]
  cSDTOptimal <- accuracyTable$cSDT[which(abs(accuracyTable$cSDT) == min(abs(accuracyTable$cSDT), na.rm = TRUE))]
  aSDTOptimal <- accuracyTable$aSDT[which(accuracyTable$aSDT == max(accuracyTable$aSDT, na.rm = TRUE))]
  bSDTOptimal <- accuracyTable$bSDT[which(abs(accuracyTable$bSDT) == min(abs(accuracyTable$bSDT), na.rm = TRUE))]
  differenceBetweenPredictedAndObservedOptimal <- accuracyTable$differenceBetweenPredictedAndObserved[which(abs(accuracyTable$differenceBetweenPredictedAndObserved) == min(abs(accuracyTable$differenceBetweenPredictedAndObserved), na.rm = TRUE))]
  informationGainOptimal <- accuracyTable$informationGain[which(accuracyTable$informationGain == max(accuracyTable$informationGain, na.rm = TRUE))]

  percentAccuracyStats <- data.frame(cbind(percentAccuracyCutoff, percentAccuracyOptimal))
  percentAccuracyByChanceStats <- data.frame(cbind(percentAccuracyByChanceCutoff, percentAccuracyByChanceOptimal))
  relativeImprovementOverPredictingFromBaseRateStats <- data.frame(cbind(relativeImprovementOverPredictingFromBaseRateCutoff, relativeImprovementOverPredictingFromBaseRateOptimal))
  RIOCStats <- data.frame(cbind(RIOCCutoff, RIOCOptimal))
  PPVStats <- data.frame(cbind(PPVCutoff, PPVOptimal))
  NPVStats <- data.frame(cbind(NPVCutoff, NPVOptimal))
  youdenJStats <- data.frame(cbind(youdenJCutoff, youdenJOptimal))
  balancedAccuracyStats <- data.frame(cbind(balancedAccuracyCutoff, balancedAccuracyOptimal))
  f1ScoreStats <- data.frame(cbind(f1ScoreCutoff, f1ScoreOptimal))
  mccStats <- data.frame(cbind(mccCutoff, mccOptimal))
  diagnosticOddsRatioStats <- data.frame(cbind(diagnosticOddsRatioCutoff, diagnosticOddsRatioOptimal))
  positiveLikelihoodRatioStats <- data.frame(cbind(positiveLikelihoodRatioCutoff, positiveLikelihoodRatioOptimal))
  negativeLikelihoodRatioStats <- data.frame(cbind(negativeLikelihoodRatioCutoff, negativeLikelihoodRatioOptimal))
  dPrimeSDTStats <- data.frame(cbind(dPrimeSDTCutoff, dPrimeSDTOptimal))
  betaSDTStats <- data.frame(cbind(betaSDTCutoff, betaSDTOptimal))
  cSDTStats <- data.frame(cbind(cSDTCutoff, cSDTOptimal))
  aSDTStats <- data.frame(cbind(aSDTCutoff, aSDTOptimal))
  bSDTStats <- data.frame(cbind(bSDTCutoff, bSDTOptimal))
  differenceBetweenPredictedAndObservedStats <- data.frame(cbind(differenceBetweenPredictedAndObservedCutoff, differenceBetweenPredictedAndObservedOptimal))
  informationGainStats <- data.frame(cbind(informationGainCutoff, informationGainOptimal))

  if(!is.null(UH) & !is.null(UM) & !is.null(UCR) & !is.null(UFA)){
    overallUtilityCutoff <- accuracyTable$cutoff[which(accuracyTable$overallUtility == max(accuracyTable$overallUtility, na.rm = TRUE))]
    overallUtilityOptimal <- accuracyTable$overallUtility[which(accuracyTable$overallUtility == max(accuracyTable$overallUtility, na.rm = TRUE))]
    overallUtilityStats <- data.frame(cbind(overallUtilityCutoff, overallUtilityOptimal))

    optimalCutoffList <- list(percentAccuracyStats,
                              percentAccuracyByChanceStats,
                              RIOCStats,
                              relativeImprovementOverPredictingFromBaseRateStats,
                              PPVStats,
                              NPVStats,
                              youdenJStats,
                              balancedAccuracyStats,
                              f1ScoreStats,
                              mccStats,
                              diagnosticOddsRatioStats,
                              positiveLikelihoodRatioStats,
                              negativeLikelihoodRatioStats,
                              dPrimeSDTStats,
                              betaSDTStats,
                              cSDTStats,
                              aSDTStats,
                              bSDTStats,
                              differenceBetweenPredictedAndObservedStats,
                              informationGainStats,
                              overallUtilityStats)
  } else{
    optimalCutoffList <- list(percentAccuracyStats,
                              percentAccuracyByChanceStats,
                              RIOCStats,
                              relativeImprovementOverPredictingFromBaseRateStats,
                              PPVStats,
                              NPVStats,
                              youdenJStats,
                              balancedAccuracyStats,
                              f1ScoreStats,
                              mccStats,
                              diagnosticOddsRatioStats,
                              positiveLikelihoodRatioStats,
                              negativeLikelihoodRatioStats,
                              dPrimeSDTStats,
                              betaSDTStats,
                              cSDTStats,
                              aSDTStats,
                              bSDTStats,
                              differenceBetweenPredictedAndObservedStats,
                              informationGainStats)
  }

  return(optimalCutoffList)
}
