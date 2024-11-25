#' @title
#' Item and Test Information from Zero-Inflated Negative Binomial Model.
#'
#' @description
#' Estimate item and test information from Bayesian zero-inflated negative
#' binomial model that was fit using the \code{brms} package.
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
#' @param zero TRUE/FALSE. Whether the item is a from a zero-inflated model.
#' @param lower Numeric. The lower range of theta, for estimating error variance
#' or reliability.
#' @param upper Numeric. The upper range of theta, for estimating error variance
#' or reliability.
#'
#' @return
#' The amount of information for a given item (or the test as a whole) at each
#' of the values of \code{theta} specified. Based on test information, one can
#' estimate error variance and marginal reliability using
#' \code{error_variance_NB()} and \code{reliability_NB()}, respectively.
#'
#' @family bayesian
#' @family IRT
#'
#' @importFrom stats dnorm integrate
#'
#' @examples
#' \dontrun{
#' library("brms")
#' library("rstan")
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
#' # We use a loop for the calculations
#' item_info <- matrix(NA, nrow = nrow(itempars), ncol = length(theta_seq))
#' for(i in 1:nrow(itempars)){
#'   item_info[i, ] <- item_info_NB_zero_analytical(
#'     theta = theta_seq,
#'     alpha = itempars[i, "alpha_Intercept"],
#'     beta = itempars[i, "beta_Intercept"],
#'     phi = exp(itempars[i, "shape_Intercept"]),
#'     varpi = plogis(itempars[i, "zi_Intercept"]))
#' }
#'
#' test_info <- data.frame(
#'   theta = theta_seq,
#'   testInformation = colSums(item_info)
#' )
#'
#' # Or, alternatively:
#' test_info_NB(
#'   theta = compareTestInfo$theta,
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE)
#'
#' # Test Standard Error of Measurement in Different Theta Ranges
#' error_variance_NB(
#'   lower = -4,
#'   upper = 4,
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE
#' )
#'
#' error_variance_NB(
#'   lower = -4,
#'   upper = 0,
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE
#' )
#'
#' error_variance_NB(
#'   lower = 0,
#'   upper = 1.5,
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE
#' )
#'
#' error_variance_NB(
#'   lower = 1.5,
#'   upper = 4,
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE
#' )
#'
#' # One-Number Summary of Test Reliability
#' reliability_NB(
#'   alpha = itempars[,"alpha_Intercept"],
#'   beta = itempars[,"beta_Intercept"],
#'   phi = exp(itempars[,"shape_Intercept"]),
#'   varpi = plogis(itempars[,"zi_Intercept"]),
#'   zero = TRUE)
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

#' @rdname itemInformationZINB
#' @export
# item information analytical for negative binomial (can specify whether or not zero-inflated)
item_info_NB_analytical <- function(theta, alpha, beta, phi, varpi = NULL, zero = FALSE){
  mu <- exp(alpha * theta + beta)
  # if(mu == 0){warning("mu = 0 detected")}
  # if mu < Inf use normal calculation of item info
  if(zero){ # in case of zero-inflation (similar to item_info_NB_zero_analytical with
    # optimized parenthesis to prevent NaN for large phi)

    # first derivation of negBinom density at n = 0
    deriv_d_negBinom_0 <- -mu * alpha * (phi/ (mu+phi))^(phi + 1)
    # density of negBinom at 0
    d_negBinom_0 <-  (phi/(mu+phi))^(phi)
    # first derivation of log(negBinom density) at n = 0
    deriv_logd_negBinom_0 <- (alpha *phi * (-mu))/(mu + phi)

    # item information
    S_0_2 <- ((1-varpi)^2 * deriv_d_negBinom_0^2)/(varpi + (1-varpi) * d_negBinom_0)
    n0 <- (1-varpi) * d_negBinom_0 * deriv_logd_negBinom_0^2
    I_theta <- alpha^2 * phi * mu / (mu + phi)
    itemInformation <- S_0_2 - n0 + (1-varpi)* I_theta
    itemInformation[which(mu == Inf)] <- (1-varpi) * alpha^2 *phi # use limit values if mu = Inf to prevent NaN

    return(itemInformation)
  } else{ # if not zero-inflated
    itemInformation <- alpha^2 * phi * mu / (mu + phi)
    itemInformation[which(mu == Inf)] <- alpha^2 * phi # use limit values if mu = Inf to prevent NaN

    return(itemInformation)
  }
}

#' @rdname itemInformationZINB
#' @export
# calculates test function for test with M items
test_info_NB <- function(theta, # sequence of theta values
                         alpha, # vector of M item slopes
                         beta,  # vector of M item intercepts
                         phi,   # vector of M phi
                         varpi = NULL, # vector of M varpi
                         zero = FALSE){ # indicator if zero inflated case is present
  M <- length(alpha) # number of items
  J <- length(theta) # number of individuals
  # if zero = FALSE set varpi = 0 to prevent error
  if(!zero){
    varpi <- rep(0, M)
  }
  # repeat item parameter for each theta to get data frame for apply
  item_param <- data.frame(theta = rep(theta, each = M),
                           alpha = rep(alpha,J), beta = rep(beta,J),
                           phi = rep(phi,J), varpi = rep(varpi,J))


  # calculate item info for each combination of theta and item
  out_apply <-  apply(item_param,
                      1,function(x){item_info_NB_analytical(theta = x[1], alpha = x[2],
                                                            beta = x[3], phi = x[4], varpi = x[5], zero = zero)})

  # item informations for thetas in rows and sum over rows to get
  # item information for each theta
  out <- as.vector(rowSums(matrix(out_apply, byrow = T, nrow = J)))
  #names(out) <- theta
  # return vector of item informations for each theta (order like theta in input)
  return(out)
}

#' @rdname itemInformationZINB
#' @export
# Error variance as average squared standard error, equation 15.24 in Brown and Croudace (2015)
error_variance_NB <- function(lower = -Inf,
                              upper = Inf,
                              alpha, # vector of M item slopes
                              beta,  # vector of M item intercepts
                              phi,   # vector of M phi
                              varpi = NULL, # vector of M varpi
                              zero = FALSE){
  f <- function(theta){
    exp(-log(test_info_NB(theta = theta, alpha = alpha, beta = beta,
                          phi = phi, varpi = varpi, zero = zero)) + log(dnorm(theta,0,1)))
  }

  errorVariance <- integrate(f, lower = lower, upper = upper)

  return(errorVariance)
}

#' @rdname itemInformationZINB
#' @export
# Marginal reliability coefficient, based on theoretical reliability, equation 15.25 in Brown and Croudace (2015)
reliability_NB <- function(alpha, # vector of M item slopes
                           beta,  # vector of M item intercepts
                           phi,   # vector of M phi
                           varpi = NULL, # vector of M varpi
                           zero = FALSE){
  errorVariance <- error_variance_NB(
    lower = -Inf, upper = Inf, alpha = alpha, beta = beta, phi = phi,
    varpi = varpi, zero = zero)$value

  reliability <- 1 - errorVariance

  return(reliability)
}
