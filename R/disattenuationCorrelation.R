#' @title
#' Disattenuation of Observed Correlation Due to Measurement Error.
#'
#' @description
#' Estimate the true association between the predictor and criterion after
#' accounting for the degree to which a true correlation is attenuated due to
#' measurement error.
#'
#' @details
#' Estimate the true association between the predictor and criterion after
#' accounting for the degree to which a true correlation is attenuated due to
#' random measurement error (unreliability).
#'
#' @param observedAssociation Magnitude of observed association (\emph{r}
#' value).
#' @param reliabilityOfPredictor Reliability of predictor (from 0 to 1).
#' @param reliabilityOfCriterion Reliability of criterion/outcome (from 0 to 1).
#'
#' @return
#' True association between predictor and criterion.
#'
#' @family correlation
#'
#' @export
#'
#' @examples
#' disattenuationCorrelation(
#'   observedAssociation = .7,
#'   reliabilityOfPredictor = .9,
#'   reliabilityOfCriterion = .85)

disattenuationCorrelation <- function(observedAssociation, reliabilityOfPredictor, reliabilityOfCriterion){
  trueAssociation <- observedAssociation / sqrt(reliabilityOfPredictor * reliabilityOfCriterion)

  return(trueAssociation)
}
