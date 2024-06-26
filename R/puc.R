#' @title
#' Percent of Uncontaminated Correlations (PUC).
#'
#' @description
#' Percent of uncontaminated correlations (PUC) from bifactor model.
#'
#' @details
#' Estimates the percent of uncontaminated correlations (PUC) from a bifactor
#' model. The PUC represents the percentage of correlations (i.e., covariance
#' terms) that reflect variance from only the general factor (i.e., not
#' variance from a specific factor). Correlations that are explained by the
#' specific factors are considered "contaminated" by multidimensionality.
#'
#' @param numItems Number of items (or indicators).
#' @param numSpecificFactors Number of specific factors.
#'
#' @return
#' Percent of Uncontaminated Correlations (PUC).
#'
#' @family structural equation modeling
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
#' \doi{10.31234/osf.io/6tf7j}
#' \doi{10.1177/0013164412449831}
#' \doi{10.1037/met0000045}

puc <- function(numItems, numSpecificFactors){
  itemsPerSpecificFactor <- numItems/numSpecificFactors
  uniqueCorrelations <- numItems * (numItems - 1)/2
  uniqueCorrelationsWithinEachSpecificFactor <- itemsPerSpecificFactor * (itemsPerSpecificFactor - 1)/2
  correlationsFromTheGeneralAndSpecificFactors <- uniqueCorrelationsWithinEachSpecificFactor * numSpecificFactors
  correlationsFromSolelyGeneralFactor <- uniqueCorrelations - correlationsFromTheGeneralAndSpecificFactors
  puc <- correlationsFromSolelyGeneralFactor / uniqueCorrelations

  return(puc)
}
