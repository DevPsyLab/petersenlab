#' @title
#' Posttest Odds & Probability.
#'
#' @description
#' Estimate posttest odds and posttest probability.
#'
#' @details
#' Estimates posttest odds or posttest probability.
#'
#' @param TP Number of true positive cases.
#' @param TN Number of true negative cases.
#' @param FP Number of false positive cases.
#' @param FN Number of false negative cases.
#' @param pretestProb Pretest probability (prevalence/base rate/prior
#' probability) of characteristic, as a number between 0 and 1.
#' @param SN Sensitivity of the test at a given cut point, as a number
#' between 0 and 1.
#' @param SP Specificity of the test at a given cut point, as a number
#' between 0 and 1.
#' @param likelihoodRatio Likelihood ratio of the test at a given cut point.
#'
#' @return
#' The requested posttest odds or pottest probability.
#'
#' @family accuracy
#'
#' @examples
#' posttestOdds(
#'   TP = 26,
#'   TN = 56,
#'   FP = 14,
#'   FN = 14)
#'
#' posttestOdds(
#'   pretestProb = 0.3636364,
#'   SN = 0.65,
#'   SP = 0.80)
#'
#' posttestOdds(
#'   pretestProb = 0.3636364,
#'   likelihoodRatio = 3.25)
#'
#' posttestProbability(
#'   TP = 26,
#'   TN = 56,
#'   FP = 14,
#'   FN = 14)
#'
#' posttestProbability(
#'   pretestProb = 0.3636364,
#'   SN = 0.65,
#'   SP = 0.80)
#'
#' posttestProbability(
#'   pretestProb = 0.3636364,
#'   likelihoodRatio = 3.25)

#' @rdname posttest
#' @export
posttestOdds <- function(TP, TN, FP, FN, pretestProb = NULL, SN = NULL, SP = NULL, likelihoodRatio = NULL){
  if(!is.null(pretestProb) & !is.null(SN) & !is.null(SP)){
    pretestProbability <- pretestProb
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    likelihoodRatio <- SN/(1 - SP)
  } else if(!is.null(pretestProb) & !is.null(likelihoodRatio)){
    pretestProbability <- pretestProb
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    likelihoodRatio <- likelihoodRatio
  } else {
    N <- TP + TN + FP + FN
    pretestProbability <- (TP + FN)/N
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    SN <- TP/(TP + FN)
    SP <- TN/(TN + FP)
    likelihoodRatio <- SN/(1 - SP)
  }

  value <- pretestOdds * likelihoodRatio

  return(value)
}

#' @rdname posttest
#' @export
posttestProbability <- function(TP, TN, FP, FN, pretestProb = NULL, SN = NULL, SP = NULL, likelihoodRatio = NULL){
  if(!is.null(pretestProb) & !is.null(SN) & !is.null(SP)){
    pretestProbability <- pretestProb
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    likelihoodRatio <- SN/(1 - SP)
  } else if(!is.null(pretestProb) & !is.null(likelihoodRatio)){
    pretestProbability <- pretestProb
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    likelihoodRatio <- likelihoodRatio
  } else {
    N <- TP + TN + FP + FN
    pretestProbability <- (TP + FN)/N
    pretestOdds <- pretestProbability / (1 - pretestProbability)

    SN <- TP/(TP + FN)
    SP <- TN/(TN + FP)
    likelihoodRatio <- SN/(1 - SP)
  }

  posttestOdds <- pretestOdds * likelihoodRatio
  value <- posttestOdds / (1 + posttestOdds)

  return(value)
}
