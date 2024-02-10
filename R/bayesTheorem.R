#' @title
#' Bayes' Theorem.
#'
#' @description
#' Estimate marginal and conditional probabilities using Bayes theorem.
#'
#' @details
#' Estimates marginal or conditional probabilities using Bayes theorem.
#'
#' @param pA The marginal probability of event \code{A}.
#' @param pB The marginal probability of event \code{B}.
#' @param pAgivenB The conditional probability of \code{A} given \code{B}.
#' @param pBgivenA The conditional probability of \code{B} given \code{A}.
#' @param pAgivenNotB The conditional probability of \code{A} given NOT
#' \code{B}.
#' @param pBgivenNotA The conditional probability of \code{B} given NOT
#' \code{A}.
#'
#' @return
#' The requested marginal or conditional probability. One of:
#' \itemize{
#'   \item the marginal probability of \code{A}
#'   \item the marginal probability of \code{B}
#'   \item the conditional probability of \code{A} given \code{B}
#'   \item the conditional probability of \code{B} given \code{A}
#'   \item the conditional probability of \code{A} given NOT \code{B}
#'   \item the conditional probability of \code{B} given NOT \code{A}
#' }
#'
#' @family bayesian
#'
#' @examples
#' pA(pAgivenB = .95, pB = .285, pAgivenNotB = .007171515)
#'
#' pB(pBgivenA = .95, pA = .285, pBgivenNotA = .007171515)
#'
#' pAgivenB(pBgivenA = .95, pA = .285, pB = .2758776)
#' pAgivenB(pBgivenA = .95, pA = .285, pBgivenNotA = .007171515)
#' pAgivenB(pBgivenA = .95, pA = .003, pBgivenNotA = .007171515)
#'
#' pBgivenA(pAgivenB = .95, pB = .285, pA = .2758776)
#' pBgivenA(pAgivenB = .95, pB = .285, pAgivenNotB = .007171515)
#' pBgivenA(pAgivenB = .95, pB = .003, pAgivenNotB = .007171515)
#'
#' pAgivenNotB(pAgivenB = .95, pB = .003, pA = .01)
#'
#' pBgivenNotA(pBgivenA = .95, pA = .003, pB = .01)

#' @rdname bayesTheorem
#' @export
pA <- function(pAgivenB, pB, pAgivenNotB){
  value <- (pAgivenB * pB) + pAgivenNotB * (1 - pB)

  value
}

#' @rdname bayesTheorem
#' @export
pB <- function(pBgivenA, pA, pBgivenNotA){
  value <- (pBgivenA * pA) + pBgivenNotA * (1 - pA)

  value
}

#' @rdname bayesTheorem
#' @export
pAgivenB <- function(pBgivenA, pA, pB = NULL, pBgivenNotA = NULL){
  if(!is.null(pB)){
    value <- pBgivenA * pA / pB
  } else{
    value <- (pBgivenA * pA) / ((pBgivenA * pA) + (pBgivenNotA * (1 - pA)))
  }

  value
}

#' @rdname bayesTheorem
#' @export
pBgivenA <- function(pAgivenB, pB, pA = NULL, pAgivenNotB = NULL){
  if(!is.null(pA)){
    value <- pAgivenB * pB / pA
  } else{
    value <- (pAgivenB * pB) / ((pAgivenB * pB) + (pAgivenNotB * (1 - pB)))
  }

  value
}

#' @rdname bayesTheorem
#' @export
pAgivenNotB <- function(pAgivenB, pA, pB){
  value <- (pA - (pAgivenB * pB)) / (1 - pB)

  value
}

#' @rdname bayesTheorem
#' @export
pBgivenNotA <- function(pBgivenA, pA, pB){
  value <- (pB - (pBgivenA * pA)) / (1 - pA)

  value
}
