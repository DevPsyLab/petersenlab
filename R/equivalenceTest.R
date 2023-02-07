#' @title
#' Chi-Square Equivalence Test for Structural Equation Models.
#'
#' @description
#' Function that performs a chi-square equivalence test for structural equation
#' models.
#'
#' @details
#' Created by Counsell et al. (2020):
#' Counsell, A., Cribbie, R. A., & Flora, D. B. (2020). Evaluating equivalence
#' testing methods for measurement invariance. Multivariate Behavioral Research,
#' 55(2), 312-328. https://doi.org/10.1080/00273171.2019.1633617
#'
#' @param alpha Value of the significance level, which is set to
#' .05 by default.
#' @param chi Value of the observed chi-square test statistic.
#' @param df Number of model (or model difference in) degrees of freedom.
#' @param m Number of groups.
#' @param N_sample Sample size.
#' @param popRMSEA The value of the root-mean square error of approximation
#' (RMSEA) to set for the equivalence bounds, which is set to .08 by default.
#'
#' @return p-value indicating whether to reject the null hypothesis that the
#' model is a poor fit to the data.
#'
#' @importFrom stats pchisq
#'
#' @export
#'
#' @examples
#' # Prepare Data
#' data("mtcars")
#'
#' # Fit structural equation model
#'
#' # Extract statistics
#' N1 <- 1222
#' m <- 1
#' Tml1 <- 408.793
#' df1 <- 80
#'
#' # Equivalence test
#' equiv_chi(alpha = .05, chi = Tml1, df = df1, m = 1, N_sample = N1, popRMSEA = .08)

equiv_chi <- function(alpha = .05, chi, df, m, N_sample, popRMSEA = .08){
  Fml <- chi/(N_sample - m)
  popep <- (df * popRMSEA^2)/m
  popdelt <- (N_sample - m) * popep
  pval <- pchisq(chi, df, ncp = popdelt, lower.tail = TRUE)
  res <- data.frame(chi, Fml, popep, popdelt, pval)
  res
}
