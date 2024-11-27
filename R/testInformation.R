#' @title
#' Test Information from Logistic IRT Model.
#'
#' @description
#' Estimate test information from logistic item response theory model.
#'
#' @details
#' Created by Philipp Doebler (doebler@statistik.tu-dortmund.de) and Loreen
#' Sabel (loreen.sabel@tu-dortmund.de).
#'
#' @param alpha Numeric. The discrimination parameter of the item,
#' indicating how steeply the item response changes with the person's
#' (\code{theta}).
#' @param beta Numeric. The difficulty parameter of the item,
#' indicating the expected count at a given level on the construct
#' (\code{theta}).
#' @param gamma Numeric. The lower asymptote.
#' @param delta Numeric. The upper asymptote.
#' @param theta Numeric. The respondent's level on the latent factor/construct.
#' @param lower Numeric. The lower range of theta, for estimating error variance
#' or reliability.
#' @param upper Numeric. The upper range of theta, for estimating error variance
#' or reliability.
#' @param mean Numeric. Mean of normal latent variable.
#' @param sd Numeric. Standard deviation of normal latent variable.
#' @param density_cutoff Numeric. Cut-off value for very large or very small
#' bounds needed for numerical stability.
#'
#' @return
#' The amount of information for a given the test as a whole at each
#' of the values of \code{theta} specified. Based on test information, one can
#' estimate error variance and marginal reliability using
#' \code{error_variance_4PL()} and \code{reliability_4PL()}, respectively.
#'
#' @family IRT
#'
#' @importFrom stats optimize qnorm dnorm integrate plogis
#'
#' @examples
#' test_info_4PL(0,1,0,0,1) # 0.25
#' test_info_4PL(-0.849, 1.1, -1, 0.2, 0.95) # Magis, 2013, Fig. 2
#' optimize(function(x)- test_info_4PL(x, 1.1, -1, 0.2, 0.95), c(-3, 3))
#'
#' # test
#' set.seed(23)
#' # parameters (some are totally unrealistic)
#' alpha <- runif(20,0.5,2.5)
#' beta <- runif(20,-2,2)
#' gamma <- runif(20,0,0.3)
#' delta <- runif(20,0.8,1)
#' error_variance_4PL(
#'   lower = -Inf, upper = Inf,
#'   alpha, beta, gamma, delta)
#'
#' error_variance_4PL(
#'   lower= -Inf, upper= Inf,
#'   alpha, beta, gamma, delta,
#'   density_cutoff = 1e-9)
#'
#' error_variance_4PL(
#'   lower= -Inf, upper= Inf,
#'   alpha, beta, gamma, delta,
#'   density_cutoff = 1e-8)
#'
#' error_variance_4PL(
#'   lower = -Inf, upper= Inf,
#'   alpha, beta, gamma, delta,
#'   density_cutoff = 1e-7)
#'
#' reliability_4PL(alpha, beta, gamma, delta)
#'
#' theta <- seq(-4, 4, length.out = 101)
#'
#' plot(theta, test_info_4PL(theta, alpha, beta, gamma, delta))

#' @rdname testInformation
#' @export
# calculates test function for test with M items
test_info_4PL <- function(theta, # sequence of theta values
                          alpha, # vector of M item slopes
                          beta,  # vector of M item intercepts
                          gamma = rep(0, length(alpha)), # vector of M lower asymptotes (guessing)
                          delta = rep(1, length(alpha)) # vector of M upper asymptotes
) # indicator if zero inflated case is present;
{
  M <- length(alpha) # number of items
  J <- length(theta) # number of individuals

  # overwrite inputs for brief code
  theta <- rep(theta, each = M)
  alpha <- rep(alpha, J)
  beta  <- rep(beta,  J)
  gamma <- rep(gamma, J)
  delta <- rep(delta, J)

  # response probs
  P <-  gamma + (delta - gamma) * plogis(alpha * (theta -  beta))

  # information in "long" format (see Magis, 2013, for the formula)
  out <- alpha^2 * (P - gamma)^2 * (delta - P)^2 / { (delta - gamma)^2 * P * (1-P) }

  # get the sum and return it
  colSums(matrix(out, ncol = J, nrow = M))
}

#' @rdname testInformation
#' @export
# error variance equation 15.24 in Brown and Croudace
error_variance_4PL <- function(lower = -Inf,
                               upper = Inf,
                               alpha, # vector of M item slopes
                               beta,  # vector of M item intercepts
                               gamma = rep(0, length(alpha)), # vector of M lower asymptotes (guessing)
                               delta = rep(1, length(alpha)), # vector of M upper asymptotes
                               mean = 0, # mean of normal latent variable
                               sd = 1, # standard deviation of normal latent variable,
                               density_cutoff = 1e-10 # cut-off value for very large or very small bounds needed for numerical stability
){
  # somewhat less opaque than integrate (but cannot do other intervals than -Inf to Inf:)
  # w <- gauss.quad.prob(n_nodes, "normal", mu = mean, sigma = sd) # nodes and weights for N(mean,sd^2)
  # sum(w$weights * test_info_4PL(w$nodes, alpha, beta, gamma, delta)^{-1})

  # make sure that Inf and -Inf do not cause problems:
  # We assume that if the normal density is very small, then
  # the tail of the item information is not relevant.

  if(lower == - Inf){lower <- qnorm(density_cutoff    , mean = mean, sd = sd)}

  if(upper == + Inf){upper <- qnorm(1 - density_cutoff, mean = mean, sd = sd)}

  f <- function(x){
    exp(- log(test_info_4PL(x, alpha, beta, gamma, delta)) +
          dnorm(x, mean = mean, sd = sd, log = TRUE))
  }
  integrate(f,lower,upper)$value
}

#' @rdname testInformation
#' @export
reliability_4PL <- function(alpha, # vector of M item slopes
                            beta,  # vector of M item intercepts
                            gamma = rep(0, length(alpha)), # vector of M lower asymptotes (guessing)
                            delta = rep(1, length(alpha)) # vector of M upper asymptotes
){
  1 - error_variance_4PL(lower = -Inf, upper = Inf,
                         alpha, beta, gamma, delta)
}
