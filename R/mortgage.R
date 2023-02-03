#' @title
#' Mortgage Principal and Interest.
#'
#' @description
#' Amount of principal and interest payments on a mortgage.
#'
#' @details
#' Calculates the amount of principal and interest payments on a mortgage.
#'
#' @param balance Initial mortgage balance.
#' @param interest Interest rate.
#' @param term Payoff period (in years).
#' @param n Number of payments per year.
#'
#' @return
#' Amount of principal and interest payments.

#' @export
#'
#' @examples
#' mortgage(balance = 300000, interest = .05)
#' mortgage(balance = 300000, interest = .04)
#' mortgage(balance = 300000, interest = .06)
#' mortgage(balance = 300000, interest = .05, term = 15)

mortgage <- function(balance, interest, term = 30, n = 12){
  principalPlusInterest <- balance * (interest / n) * (1 + (interest / n))^(n*term) / ((1 + (interest / n))^(n*term) - 1)

  return(principalPlusInterest)
}
