#' @title
#' Percent of Uncontaminated Correlations (PUC).
#'
#' @description
#' Percent of uncontaminated correlations (PUC) from bifactor model.
#'
#' @details
#' Estimates the percent of uncontaminated correlations (PUC) from a bifactor
#' model. The PUC represents the percentage of covariance terms that reflect
#' variance from only the general factor.
#'
#' @param numItems Number of items (or indicators).
#' @param numSpecificFactors Number of specific factors.
#'
#' @return
#' Percent of Uncontaminated Correlations (PUC).
#'
#' @export
#'
#' @examples
#' puc(
#'   numItems = 9,
#'   numSpecificFactors = 3
#' )
#'
#' mydata <- data.frame(
#'   numItems = c(9,18,18,36,36,36),
#'   numSpecificFactors = c(3,3,6,3,6,12)
#' )
#'
#' puc(
#'   numItems = mydata$numItems,
#'   numSpecificFactors = mydata$numSpecificFactors
#' )
#'
#' @seealso
#' \url{https://doi.org/10.31234/osf.io/6tf7j}
#' \url{https://doi.org/10.1177/0013164412449831}
#' \url{https://doi.org/10.1037/met0000045}

puc <- function(numItems, numSpecificFactors){
  itemsPerSpecificFactor <- numItems/numSpecificFactors
  uniqueCorrelations <- numItems * (numItems - 1)/2
  uniqueCorrelationsWithinEachSpecificFactor <- itemsPerSpecificFactor * (itemsPerSpecificFactor - 1)/2
  correlationsFromTheGeneralAndSpecificFactors <- uniqueCorrelationsWithinEachSpecificFactor * numSpecificFactors
  correlationsFromSolelySpecificFactor <- uniqueCorrelations - correlationsFromTheGeneralAndSpecificFactors
  puc <- correlationsFromSolelySpecificFactor / uniqueCorrelations

  return(puc)
}
