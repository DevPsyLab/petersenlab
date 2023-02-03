#' @title
#' Simulate Complement Variable.
#'
#' @description
#' Simulate data with a specified correlation in relation to an existing
#' variable.
#'
#' @details
#' Simulates data with a specified correlation in relation to an existing
#' variable.
#'
#' @param y The existing variable against which to simulate a complement
#' variable.
#' @param rho The correlation magnitude, ranging from [-1, 1].
#' @param x (optional) Vector with the same length as \code{y}. Used for
#' calculating the residuals of the least squares regression of \code{x}
#' against \code{y}, to remove the \code{y} component from \code{x}.
#'
#' @return
#' Vector of a variable that has a specified correlation in relation to a given
#' variable \code{y}.
#'
#' @family simulation
#'
#' @importFrom stats rnorm residuals sd lm
#'
#' @export
#'
#' @examples
#' v1 <- rnorm(100)
#' complement(y = v1, rho = .5)
#' complement(y = v1, rho = -.5)
#'
#' v2 <- complement(y = v1, rho = .85)
#' plot(v1, v2)
#'
#' @seealso
#' \url{https://stats.stackexchange.com/a/313138/20338}

complement <- function(y, rho, x){
  if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
  y.perp <- residuals(lm(x ~ y, na.action = na.omit))
  rho * sd(y.perp) * y + y.perp * sd(y, na.rm = TRUE) * sqrt(1 - rho^2)
}
