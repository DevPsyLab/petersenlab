#' @title
#' 4-Parameter Logistic Curve.
#'
#' @description
#' 4-parameter logistic curve for item response theory.
#'
#' @details
#' Estimates the probability of item endorsement as function of the
#' four-parameter logistic (4PL) curve and the person's level on the construct
#' (theta).
#'
#' @param b Difficulty (severity) parameter (inflection point).
#' @param a Discrimination parameter (slope).
#' @param c Guessing parameter (lower asymptote).
#' @param d Careless errors parameter (upper asymptote).
#' @param theta Person's level on the construct.
#'
#' @return
#' Probability of item endorsement (or expected value on the item).
#'
#' @family IRT
#'
#' @export
#'
#' @examples
#' fourPL(b = 2, theta = -4:4) #1PL
#' fourPL(b = 2, a = 1.5, theta = -4:4) #2PL
#' fourPL(b = 2, a = 1.5, c = 0.10, theta = -4:4) #3PL
#' fourPL(b = 2, a = 1.5, c = 0.10, d = 0.95, theta = -4:4) #4PL
#'
#' @seealso
#' \doi{10.1177/0146621613475471}

fourPL <- function(a = 1, b, c = 0, d = 1, theta){
  c + (d - c) * (exp(a * (theta - b))) / (1 + exp(a * (theta - b)))
}
