#' @title
#' Discrimination (IRT) to Standardized Factor Loading.
#'
#' @description
#' Convert a discrimination parameter in item response theory to a
#' standardized factor loading.
#'
#' @details
#' Convert a discrimination parameter in item response theory to a
#' standardized factor loading
#'
#' @param a Discrimination parameter in item response theory.
#' @param model Model type. One of:
#' \itemize{
#'   \item \code{"logit"}
#'   \item \code{"probit"}
#' }
#'
#' @return
#' Standardized factor loading.
#'
#' @family IRT
#'
#' @export
#'
#' @examples
#' discriminationToFactorLoading(0.5)
#' discriminationToFactorLoading(1.3)
#' discriminationToFactorLoading(1.3, model = "logit")
#'
#' @seealso
#' \url{https://aidenloe.github.io/introToIRT.html}
#' \url{https://stats.stackexchange.com/questions/228629/conversion-of-irt-logit-discrimination-parameter-to-factor-loading-metric}

discriminationToFactorLoading <- function(a, model = "probit"){
  scalingParameter <- 1.702
  aTransformed <- a/scalingParameter

  if(model == "probit"){
    loading <- aTransformed/(sqrt(1 + (aTransformed^2)))
  } else if(model == "logit"){
    loading <- aTransformed/(sqrt(3.29 + (aTransformed^2)))
  }

  return(loading)
}
