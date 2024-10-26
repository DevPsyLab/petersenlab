#' @title
#' Item Information from Zero-Inflated Negative Binomial Model.
#'
#' @description
#' Estimate item information from Bayesian zero-inflated negative binomial
#' model that was fit using the \code{brms} package.
#'
#' @details
#' Created by Philipp Doebler (doebler@statistik.tu-dortmund.de) and Loreen
#' Sabel (loreen.sabel@tu-dortmund.de).
#'
#' @param n Integer. The observed count, representing the the event frequency.
#' @param alpha Numeric. The slope/discrimination parameter of the item,
#' indicating how steeply the item response changes with the person's
#' (\code{theta}).
#' @param beta Numeric. The intercept/easiness parameter of the item,
#' indicating the expected count at a given level on the construct
#' (\code{theta}).
#' @param theta Numeric. The respondent's level on the latent factor/construct.
#' @param phi Numeric. The shape/overdispersion parameter of the negative
#' binomial distribution, indicating the variance beyond what is expected from a
#' negative binomial distribution.
#' @param varpi Numeric. The probability of observing a zero count due to a
#' separate zero-inflation process.
#'
#' @return
#' The amount of information for a given item at each of the values of
#' \code{theta} specified.
#'
#' @family bayesian
#' @family IRT
#'
#' @examples
#' \dontrun{
#' library(brms)
#' library(rstan)
#'
#' coef_bayesianMixedEffectsGRM_gam <- coef(bayesianMixedEffectsGRM_gam)
#' str(coef_bayesianMixedEffectsGRM_gam)
#' itempars <- coef_bayesianMixedEffectsGRM_gam$item[,1,1:4]
#'
#' # define a grid of thetas for the computations:
#' theta_seq <- seq(-4, 4, length.out = 201)
#'
#' # item information for all items
#' # The resulting matrix has length(theta_seq) columns and a row per item.
#' # We use a loop for the calcualtions
#' item_info <- matrix(NA, nrow = nrow(itempars), ncol = length(theta_seq))
#' for(i in 1:nrow(itempars)){
#'   item_info[i, ] <- item_info_NB_zero_analytical(
#'     theta_seq,
#'     itempars[i, "alpha_Intercept"],
#'     itempars[i, "beta_Intercept"],
#'     exp(itempars[i, "shape_Intercept"]),
#'     plogis(itempars[i, "zi_Intercept"]))
#' }
#' }

#' @rdname itemInformationZINB
#' @export
deriv_d_negBinom <- function(n, alpha, beta, theta, phi){
  mu <- exp(alpha * theta + beta)
  value <- exp(log_gen_binom(n,phi)) * ((alpha * phi^(phi + 1) * mu^n * (n-mu))/ (mu+phi)^(n+phi+1))

  return(value)
}

#' @rdname itemInformationZINB
#' @export
# derivation of negBinom
d_negBinom <- function(n, alpha, beta, theta, phi){
  mu <-  exp(alpha * theta + beta)
  K <- exp(log_gen_binom(n, phi))
  value <- K * (mu/(mu+phi))^n * (phi/(mu+phi))^(phi)

  return(value)
}

#' @rdname itemInformationZINB
#' @export
log_gen_binom <- function(n, phi){
  value <- lgamma(n+phi) - lgamma(n+1) - lgamma(phi)

  return(value)
}

#' @rdname itemInformationZINB
#' @export
deriv_logd_negBinom <- function(n, alpha, beta, theta, phi){
  mu <- exp(alpha * theta + beta)
  value <- (alpha * phi * (n-mu))/(mu + phi)

  return(value)
}

#' @rdname itemInformationZINB
#' @export
info_neg_binom_analytical <- function(theta = seq(-2.5, 2.5, length.out = 101), alpha, beta, phi, varpi){
  mu <- exp(alpha * theta + beta)
  itemInformation <- alpha^2 * phi * mu / (mu + phi)

  return(itemInformation)
}

#' @rdname itemInformationZINB
#' @export
# item information analytical for zero inflated negative binomial
item_info_NB_zero_analytical <- function(theta, alpha, beta, phi, varpi){
  S_0_2 <- ((1-varpi)^2 * deriv_d_negBinom(0, alpha, beta, theta, phi)^2)/(varpi + (1-varpi) * d_negBinom(0, alpha, beta, theta, phi))
  n0 <- (1-varpi) * d_negBinom(0, alpha, beta, theta, phi) * deriv_logd_negBinom(0,alpha, beta, theta, phi)^2
  I_theta <- info_neg_binom_analytical(theta,alpha, beta, phi, varpi)
  itemInformation <- S_0_2 - n0 + (1-varpi)* I_theta

  return(itemInformation)
}
