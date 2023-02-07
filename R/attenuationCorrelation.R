#' @title
#' Attenuation of True Correlation Due to Measurement Error.
#'
#' @description
#' Estimate the observed association between the predictor and criterion after
#' accounting for the degree to which a true correlation is attenuated due to
#' measurement error.
#'
#' @details
#' Estimate the association that would be observed between the predictor and
#' criterion after accounting for the degree to which a true correlation is
#' attenuated due to random measurement error (unreliability).
#'
#' @param trueAssociation Magnitude of true association (\emph{r} value).
#' @param reliabilityOfPredictor Reliability of predictor (from 0 to 1).
#' @param reliabilityOfCriterion Reliability of criterion/outcome (from 0 to 1).
#'
#' @return
#' Observed correlation between predictor and criterion.
#'
#' @family correlation
#'
#' @export
#'
#' @examples
#' attenuationCorrelation(
#'   trueAssociation = .7,
#'   reliabilityOfPredictor = .9,
#'   reliabilityOfCriterion = .85)

attenuationCorrelation <- function(trueAssociation, reliabilityOfPredictor, reliabilityOfCriterion){
  observedAssociation <- trueAssociation * sqrt(reliabilityOfPredictor * reliabilityOfCriterion)

  return(observedAssociation)
}
