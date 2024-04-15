#' @title
#' Item Information.
#'
#' @description
#' Item information in item response theory.
#'
#' @details
#' Estimates the amount of information provided by a given item as function of
#' the item parameters and the person's level on the construct (theta).
#'
#' @param b Difficulty (severity) parameter (inflection point).
#' @param a Discrimination parameter (slope).
#' @param c Guessing parameter (lower asymptote).
#' @param d Careless errors parameter (upper asymptote).
#' @param theta Person's level on the construct.
#'
#' @return
#' Amount of item information.
#'
#' @family IRT
#'
#' @export
#'
#' @examples
#' itemInformation(b = 2, theta = -4:4) #1PL
#' itemInformation(b = 2, a = 1.5, theta = -4:4) #2PL
#' itemInformation(b = 2, a = 1.5, c = 0.10, theta = -4:4) #3PL
#' itemInformation(b = 2, a = 1.5, c = 0.10, d = 0.95, theta = -4:4) #4PL
#'
#' @seealso
#' \url{10.1177/0146621613475471}

itemInformation <- function(a = 1, b, c = 0, d = 1, theta){
  P <- NULL
  information <- NULL

  for(i in 1:length(theta)){
    P[i] <- fourPL(b = b, a = a, c = c, d = d, theta = theta[i])
    information[i] <- ((a^2) * (P[i] - c)^2 * (d - P[i])^2) / ((d - c)^2 * P[i] * (1 - P[i]))
  }

  return(information)
}
