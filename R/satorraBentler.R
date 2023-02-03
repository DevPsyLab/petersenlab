#' @title
#' Satorra-Bentler Scaled Chi-Square Difference Test Statistic.
#'
#' @description
#' Function that computes the Satorra-Bentler Scaled Chi-Square Difference Test
#' statistic.
#'
#' @details
#' Computes the Satorra-Bentler Scaled Chi-Square Difference Test statistic
#' between two structural equation models.
#'
#' @param T0 Value of the chi-square statistic for the nested model.
#' @param c0 Value of the scaling correction factor for the nested model.
#' @param d0 Number of model degrees of freedom for the nested model.
#' @param T1 Value of the chi-square statistic for the comparison model.
#' @param c1 Value of the scaling correction factor for the comparison model.
#' @param d1 Number of model degrees of freedom for the comparison model.
#'
#' @return Satorra-Bentler Scaled Chi-Square Difference Test statistic.
#'
#' @importFrom lavaan cfa fitMeasures
#'
#' @export
#'
#' @examples
#' # Fit structural equation model
#' HS.model <- '
#'  visual =~ x1 + x2 + x3
#'  textual =~ x4 + x5 + x6
#'  speed =~ x7 + x8 + x9
#' '
#'
#' fit1 <- lavaan::cfa(HS.model, data = lavaan::HolzingerSwineford1939,
#'  estimator = "MLR")
#' fit0 <- lavaan::cfa(HS.model, data = lavaan::HolzingerSwineford1939,
#'  orthogonal = TRUE, estimator = "MLR")
#'
#' # Chi-square difference test
#' # lavaan::anova(fit1, fit0)
#' satorraBentlerScaledChiSquareDifferenceTestStatistic(
#'  T0 = lavaan::fitMeasures(fit0)["chisq.scaled"],
#'  c0 = lavaan::fitMeasures(fit0)["chisq.scaling.factor"],
#'  d0 = lavaan::fitMeasures(fit0)["df.scaled"],
#'  T1 = lavaan::fitMeasures(fit1)["chisq.scaled"],
#'  c1 = lavaan::fitMeasures(fit1)["chisq.scaling.factor"],
#'  d1 = lavaan::fitMeasures(fit1)["df.scaled"])

satorraBentlerScaledChiSquareDifferenceTestStatistic <- function(T0, c0, d0, T1, c1, d1){
  cd <- (d0 * c0 - d1*c1)/(d0 - d1)
  TRd <- (T0*c0 - T1*c1)/cd

  return(TRd)
}
